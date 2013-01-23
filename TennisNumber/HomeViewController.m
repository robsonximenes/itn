//
//  HomeViewController.m
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 21/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "AssessmentBC.h"
#import "AppDelegate.h"
#import "ScoreViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface HomeViewController ()

@property NSArray *results;

@end

@implementation HomeViewController

@synthesize results,table;
@synthesize addAssessmentButton;


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
    
    [AssessmentBC clearInstance];
    
    
    [[self.tabBarController.viewControllers objectAtIndex:0] setTitle:NSLocalizedString(@"Assessment",@"Assessment label")];

    [[self.tabBarController.viewControllers objectAtIndex:1] setTitle:NSLocalizedString(@"Guide",@"Guide label")];

    [[self.tabBarController.viewControllers objectAtIndex:2] setTitle:NSLocalizedString(@"Preferences",@"Preferences label")];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [AssessmentBC clearInstance];
    results = [[AssessmentBC current]findAll];
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
    
    AssessmentBC *bc = [AssessmentBC current];
    
    [cell.name setText:a.name];
    [cell.detailedScore setText:
     [NSString stringWithFormat:NSLocalizedString(@"GS Deph(%d), Volley Deph(%d), GS Accuracy(%i), Server(%i), Mobility(%i)",@"Detaild score..."),
      [bc getTotalPointsForStrokeType: STROKE_TYPE_GS_DEPH ],
      [bc getTotalPointsForStrokeType: STROKE_TYPE_VOLLEY_DEPH ],
      [bc getTotalPointsForStrokeType: STROKE_TYPE_GS_ACCURACY ],
      [bc getTotalPointsForStrokeType: STROKE_TYPE_SERVER ],
      [bc getMobilityPoints]]];
    
    [cell.venue setText:[a venue]];
    [cell.date setText:[NSDateFormatter localizedStringFromDate:a.date
                                                      dateStyle:NSDateFormatterMediumStyle
                                                      timeStyle:NSDateFormatterShortStyle]];
    [cell.itnNumber setText:[NSString stringWithFormat:@"%@",[a itn]]];

    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Assessment * selected = [results objectAtIndex:indexPath.row];
    [[AssessmentBC current] setAssessment:selected];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    ScoreViewController *scoreView = [storyboard instantiateViewControllerWithIdentifier:@"NavigationScoreViewController"];
    [self presentViewController:scoreView animated:YES completion:nil ];
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (editingStyle == UITableViewCellEditingStyleDelete){
        // delete your data item here
        Assessment *a = [results objectAtIndex:indexPath.row];
        [[AssessmentBC current] removeAssessment:a];
        results = [[AssessmentBC current]findAll];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"new"]){
        if(![AppDelegate isEnabled]){
            if([results count]>=3){
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [appDelegate showMessageForEnablingFeaturesInViewController:self];
                return NO;
            }
        }
    }
    return YES;
}


@end
