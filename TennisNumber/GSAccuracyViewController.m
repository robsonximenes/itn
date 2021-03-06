//
//  GSAccuracyViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "GSAccuracyViewController.h"
#import "StrokeCell.h"
#import "Stroke.h"
#import "AssessmentBC.h"

@interface GSAccuracyViewController ()
    @property AssessmentBC *bc;
@end

@implementation GSAccuracyViewController

@synthesize bc;
@synthesize total,subtotal,consistency, resultContentView;

-(id) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.title = NSLocalizedString(@"GS Accuracy",@"");
    }
    return self;
}

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
    return [[self.bc getStrokesForType:STROKE_TYPE_GS_ACCURACY] count];
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
    
    Stroke *stroke = [[self.bc getStrokesForType:STROKE_TYPE_GS_ACCURACY] objectAtIndex:indexPath.row];
    cell.number.text=[NSString stringWithFormat:@"%@",stroke.order ];
    cell.strokeName.text=stroke.name;
    [self setupSegment:cell.score value:[NSString stringWithFormat:@"%@",stroke.score]];
    return cell;
    
}

-(void) setupSegment: (UISegmentedControl *)segControl value:(NSString *)value{
    NSArray *values = [AssessmentBC getPossiblePointsForType:STROKE_TYPE_GS_ACCURACY];
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
    
    Stroke *stroke = [[self.bc getStrokesForType:STROKE_TYPE_GS_ACCURACY] objectAtIndex:row];
    stroke.score = [NSNumber numberWithInt:[value intValue]];
    
//    [[self.bc getStrokesForGSAccuracy] replaceObjectAtIndex:row withObject:stroke];

    [self calculateScore];
}

- (void) calculateScore{

    [subtotal setText:[NSString stringWithFormat:@"%i", [bc getPointsForStrokeType:STROKE_TYPE_GS_ACCURACY]]];
    [consistency setText:[NSString stringWithFormat:@"%i", [bc getConssistencyPointsForStrokeType:STROKE_TYPE_GS_ACCURACY]]];
    [total setText:[NSString stringWithFormat:@"%i", [bc getTotalPointsForStrokeType:STROKE_TYPE_GS_ACCURACY]]];
}


#pragma mark Quit the assessment
- (IBAction)exit:(id)sender {
    
    for (UIViewController *view in [self.navigationController viewControllers]) {
        [view dismissViewControllerAnimated:false completion:nil];
    }
}

@end
