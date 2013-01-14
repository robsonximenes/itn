//
//  ServerViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "ServerViewController.h"
#import "StrokeCell.h"
#import "Stroke.h"
#import "AssessmentBC.h"

@interface ServerViewController ()
@property AssessmentBC *bc;
@end

@implementation ServerViewController

@synthesize bc;
@synthesize total,subtotal,consistency;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bc = [AssessmentBC current];
    [self calculateScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


# pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.bc getStrokesForType:STROKE_TYPE_SERVER] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STROKES_ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"StrokeCell";
    StrokeCell *cell = (StrokeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
        for(id currentObject in topObjects){
            if([currentObject isKindOfClass:[StrokeCell class]]){
                cell = (StrokeCell *)currentObject;
                break;
            }
        }
    }
    
    Stroke *stroke = [[self.bc getStrokesForType:STROKE_TYPE_SERVER] objectAtIndex:indexPath.row];
    cell.number.text=[NSString stringWithFormat:@"%@",stroke.order ];
    cell.strokeName.text=stroke.name;
    [self setupSegment:cell.score value:[NSString stringWithFormat:@"%@",stroke.score]];
    return cell;
    
}

-(void) setupSegment: (UISegmentedControl *)segControl value:(NSString *)value{
    NSArray *values = [AssessmentBC getPossiblePointsForType:STROKE_TYPE_SERVER];
    [segControl removeAllSegments];
    for (int i =0; i<[values count]; i++) {
        NSString *listValue = [NSString stringWithFormat:@"%@",[values objectAtIndex:i]];
        [segControl insertSegmentWithTitle:listValue atIndex:i animated:false];
    }
    
    for (int i =0; i<[values count]; i++) {
        NSString *listValue = [NSString stringWithFormat:@"%@",[values objectAtIndex:i]];
        if([listValue isEqualToString:value]){
            [segControl setSelectedSegmentIndex:i];
            break;
        }
    }
    
    [segControl addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentSelected:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    NSIndexPath *indexPath = [self.table indexPathForCell:(StrokeCell *)[[sender superview] superview]];
    NSUInteger row = indexPath.row;
    
    NSString *value = [segment titleForSegmentAtIndex:[segment selectedSegmentIndex]];
    
    [self.table setContentOffset:CGPointMake(0, indexPath.row * STROKES_ROW_HEIGHT) animated:YES];
    
    Stroke *stroke = [[self.bc getStrokesForType:STROKE_TYPE_SERVER] objectAtIndex:row];
    stroke.score = [NSNumber numberWithInt:[value intValue]];
    
    //    [[self.bc getStrokesForGSAccuracy] replaceObjectAtIndex:row withObject:stroke];
    
    [self calculateScore];
}

- (void) calculateScore{
    
    [subtotal setText:[NSString stringWithFormat:@"%i", [bc getPointsForStrokeType:STROKE_TYPE_SERVER]]];
    [consistency setText:[NSString stringWithFormat:@"%i", [bc getConssistencyPointsForStrokeType:STROKE_TYPE_SERVER]]];
    [total setText:[NSString stringWithFormat:@"%i", [bc getTotalPointsForStrokeType:STROKE_TYPE_SERVER]]];
}


#pragma mark Quit the assessment
- (IBAction)exit:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Caution" message:@"If you quit now the data will be lost. Continue?" delegate:self cancelButtonTitle:@"Noooo!" otherButtonTitles:@"Ok, quit!", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0){
		// Yes, do something
	}else if (buttonIndex == 1){
        [[AssessmentBC current] removeAssessment:[bc assessment]];

        
		for (UIViewController *view in [self.navigationController viewControllers]) {
            [view dismissViewControllerAnimated:false completion:nil];
        }
    }
}@end
