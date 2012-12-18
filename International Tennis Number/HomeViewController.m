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

@end
