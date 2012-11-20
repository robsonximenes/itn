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
#import "Assessment.h"

@interface GSAccuracyViewController ()
    @property Assessment *assetment;
@end

@implementation GSAccuracyViewController

@synthesize assetment;
@synthesize total,subtotal,consistency, resultContentView;

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
    self.assetment = [Assessment current];
    [self calculateScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


# pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.assetment getStrokesForGSAccuracy] count];
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
    
    Stroke *stroke = [[self.assetment getStrokesForGSAccuracy] objectAtIndex:indexPath.row];
    cell.number.text=stroke.number;
    cell.strokeName.text=stroke.strokeName;
    [self setupSegment:cell.score value:stroke.score];
    return cell;
    
}

-(void) setupSegment: (UISegmentedControl *)segControl value:(NSString *)value{
    NSArray *values = [Assessment getPointsForGSAccuracy];
    [segControl removeAllSegments];
    for (int i =0; i<[values count]; i++) {
        [segControl insertSegmentWithTitle:[values objectAtIndex:i] atIndex:i animated:false];
    }
    
    for (int i =0; i<[values count]; i++) {
        if([[values objectAtIndex:i] isEqualToString:value]){
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
    
    Stroke *stroke = [[self.assetment getStrokesForGSAccuracy] objectAtIndex:row];
    stroke.score = value;
    
    [[self.assetment getStrokesForGSAccuracy] replaceObjectAtIndex:row withObject:stroke];

    [self calculateScore];
}

- (void) calculateScore{
    NSMutableArray *strokes = [self.assetment getStrokesForGSAccuracy];
    for (int i =0; i<[strokes count]; i++) {
        Stroke *stroke = [strokes objectAtIndex:i];
        [assetment.groundStrokePrecision setObject:[NSNumber numberWithInt:[stroke.score intValue]] atIndexedSubscript:i];
    }
    
    
    [subtotal setText:[NSString stringWithFormat:@"%i", [assetment getGSAccuracyPoints]]];
    [consistency setText:[NSString stringWithFormat:@"%i", [assetment getGSAccuracyConssistencyPoints]]];
    [total setText:[NSString stringWithFormat:@"%i", [assetment getGSAccuracyTotalPoints]]];
}


@end
