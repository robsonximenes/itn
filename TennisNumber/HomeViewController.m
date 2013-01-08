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

#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()

@property NSArray *results;

@end

@implementation HomeViewController

@synthesize results,table;

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    bool OLD_USER = [defaults boolForKey:DEFAULTS_OLD_USER];
    if(!OLD_USER){
        NSLog(@"First time on app loading sample assessment...");
        [Assessment configureSampleAssessment];
        [defaults setBool:YES forKey:DEFAULTS_OLD_USER];
        [defaults synchronize];
    }
    
    [Assessment clearInstance];
    
	
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [Assessment clearInstance];
    results = [[Assessment current]findAll];
    [table reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [results count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HOME_ROW_HEIGHT;
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
    
    Assessment * a = [results objectAtIndex:indexPath.row];
    
    [cell.name setText:a.name];
    [cell.detailedScore setText:
     [NSString stringWithFormat:@"GS Deph(%d), Volley Deph(%d), GS Accuracy(%i), Server(%i), Mobility(%i)",
      a.gsDephPoints,a.volleyDephPoints, a.gsAccuracyPoints, a.serverPoints, a.mobilityPoints]];
    
    [cell.venue setText:a.local];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    
        
    [cell.date setText:[NSDateFormatter localizedStringFromDate:a.date
                                                      dateStyle:NSDateFormatterMediumStyle
                                                      timeStyle:NSDateFormatterShortStyle]
];
    
    [cell.itnNumber setText:[NSString stringWithFormat:@"%d",a.itn]];

    
    return cell;
    
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (editingStyle == UITableViewCellEditingStyleDelete){
        // delete your data item here
        
        Assessment * a = [results objectAtIndex:indexPath.row];
        [a remove];
        results = [[Assessment current]findAll];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}




@end
