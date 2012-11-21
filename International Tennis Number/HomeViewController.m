//
//  HomeViewController.m
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 21/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "Assessment.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    [Assessment clearInstance];
	
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [Assessment clearInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"HomeCell";
    HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
        for(id currentObject in topObjects){
            if([currentObject isKindOfClass:[HomeCell class]]){
                cell = (HomeCell *)currentObject;
                break;
            }
        }
    }
    
    [cell.name setText:@"Robson Saraiva Ximenes"];
    [cell.detailedScore setText:[NSString stringWithFormat:@"GS Deph(%i), Volley Deph(%i), GS Accuracy(%i), Server(%i), Mobility(%i)",70,70,70,70,70]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    [cell.date setText:[formatter stringFromDate:[NSDate date]]];
    
    [cell.itnNumber setText:@"3"];

    
    return cell;
    
}

@end
