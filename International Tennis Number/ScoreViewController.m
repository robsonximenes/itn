//
//  ScoreViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "ScoreViewController.h"
#import "Assessment.h"
#import "ScoreCell.h"

#import <QuartzCore/QuartzCore.h>

@interface ScoreViewController ()
@property Assessment *assessment;
@end

@implementation ScoreViewController

@synthesize assessment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.assessment = [Assessment current];
    
}

-(void)setupView: (UIView *)view{
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    
    [[Assessment current]save];
    
    for (UIViewController *view in [self.navigationController viewControllers]) {
        [view dismissViewControllerAnimated:false completion:nil];
    }
}

# pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else{
        return 5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ScoreCell";
    ScoreCell *cell = (ScoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
        for(id currentObject in topObjects){
            if([currentObject isKindOfClass:[ScoreCell class]]){
                cell = (ScoreCell *)currentObject;
                break;
            }
        }
    }
    
    
    if(indexPath.section == 1){
        NSString *text = @"Subtotal: %i, Consistency: %i";
    if(indexPath.row == 0){
        [cell.name setText:@"Ground Stroke Deph"];
        [cell.abstrct setText:[NSString stringWithFormat:text, [assessment getGroundStrokePoints],[assessment getGroundStrokeConssistencyPoints]]];
        [cell.total setText:[NSString stringWithFormat:@"%d",[assessment getGroundStrokeTotalPoints]]];
    }else if(indexPath.row == 1){
        [cell.name setText:@"Volley Deph"];
        [cell.abstrct setText:[NSString stringWithFormat:text, [assessment getVolleyDephPoints],[assessment getVolleyDephConssistencyPoints]]];
        [cell.total setText:[NSString stringWithFormat:@"%d",[assessment getVolleyDephTotalPoints]]];
    }else if(indexPath.row == 2){
        [cell.name setText:@"Ground Stroke Accuracy"];
        [cell.abstrct setText:[NSString stringWithFormat:text, [assessment getGSAccuracyPoints],[assessment getGSAccuracyConssistencyPoints]]];
        [cell.total setText:[NSString stringWithFormat:@"%d",[assessment getGSAccuracyTotalPoints]]];
    }else if(indexPath.row == 3){
        [cell.name setText:@"Server"];
        [cell.abstrct setText:[NSString stringWithFormat:text, [assessment getServerPoints],[assessment getServerConssistencyPoints]]];
        [cell.total setText:[NSString stringWithFormat:@"%d",[assessment getServerTotalPoints]]];
    }else if(indexPath.row == 4){
        [cell.name setText:@"Mobility"];
        [cell.abstrct setText:[NSString stringWithFormat:@"Time :%is", [assessment mobilityTime]]];
        [cell.total setText:[NSString stringWithFormat:@"%d",[assessment getMobilityPoints]]];
    }
        
    }else{
        [cell.name setText:@"Internationl Tennis Number"];
        [cell.abstrct setText:[NSString stringWithFormat:@"Strokes:%i Mobility:%i Total:%i", [assessment getStrokePoints],[assessment getMobilityPoints],[assessment getTotalPoints]]];
        [cell.total setText:[NSString stringWithFormat:@"%d",[assessment calculateITN]]];
    }
    
    return cell;
    
}


@end
