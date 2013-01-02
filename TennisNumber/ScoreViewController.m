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
    [self.assessment save];
    
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

#pragma mark Email

- (IBAction)send:(id)sender{
    if ([MFMailComposeViewController canSendMail]) {
        
        NSString *birthday = [NSDateFormatter localizedStringFromDate:[assessment birthday]
                                                          dateStyle:NSDateFormatterMediumStyle
                                                        timeStyle:NSDateFormatterNoStyle];
        
        NSString *linha1 = [NSString stringWithFormat:
                                @"<tr><td>Name</td><td>%@</td><td>Date of Birth</td><td>%@</td><td>Sex</td><td>%@</td></tr>" ,[assessment name], birthday, [assessment sex]];
        
        NSLog(@"%@", [assessment date]);
    
        NSString *date = [NSDateFormatter localizedStringFromDate:[assessment date]
                                              dateStyle:NSDateFormatterMediumStyle
                                              timeStyle:NSDateFormatterShortStyle];
        
        
        NSString *linha2 = [NSString stringWithFormat:
                            @"<tr><td>Assessor</td><td>%@</td><td>Date</td><td>%@</td><td>Venue</td><td>%@</td></tr>" ,[assessment assessor], date, [assessment local]];

        NSLog(@"%@", date);
        
        NSString *resultado1 = [NSString stringWithFormat:
                            @"<tr><td>Strokes</td><td>Mobility</td><td>Total</td></tr><tr><td>%d</td><td>%d</td><td>%d</td></tr>" ,[assessment getStrokePoints], [assessment getMobilityPoints], [assessment getTotalPoints]];
        
        NSString *body = [NSString stringWithFormat:
                          @"<h3>International Tennis Number On Court Assessment</h3> <table>%@ %@</table> <br/> <table> %@ </table> <br/> <h3>ITN %d</h3>" ,
                          linha1, linha2, resultado1, [assessment calculateITN]];
        
    
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"ITN Report"];
        [mailViewController setMessageBody:body isHTML:YES];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
        
    }else {
        NSLog(@"Device is unable to send email in its current state.");
        
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}


@end
