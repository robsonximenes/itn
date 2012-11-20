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
#import "Assessment.h"

@interface ServerViewController ()
@property Assessment *assetment;
@end

@implementation ServerViewController

@synthesize assetment;
@synthesize total,subtotal,consistency, resultView, table;

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
    return [[self.assetment getStrokesForServer] count];
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
    
    Stroke *stroke = [self getStrokeAtIndex:indexPath.row];
    cell.number.text=stroke.number;
    cell.strokeName.text=stroke.strokeName;
    [self setupSegment:cell.score withSelectedValue:stroke.score];
    return cell;
    
}

-(NSMutableArray *) getStrokes{
    return [self.assetment getStrokesForServer];
}

-(Stroke *) getStrokeAtIndex: (int) index{
    return [[self getStrokes] objectAtIndex:index];
}


-(void) setupSegment: (UISegmentedControl *)segControl withSelectedValue:(NSString *)value{
    NSArray *values = [Assessment getPointsForServer];
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
    
    Stroke *stroke = [self getStrokeAtIndex:row];
    stroke.score = value;
    
    [[self getStrokes] replaceObjectAtIndex:row withObject:stroke];
    
    [self calculateScore];
}

- (void) calculateScore{
    NSMutableArray *strokes = [self getStrokes];
    for (int i =0; i<[strokes count]; i++) {
        Stroke *stroke = [strokes objectAtIndex:i];
        [assetment.server setObject:[NSNumber numberWithInt:[stroke.score intValue]] atIndexedSubscript:i];
    }
    
    
    [subtotal setText:[NSString stringWithFormat:@"%i", [assetment getServerPoints]]];
    [consistency setText:[NSString stringWithFormat:@"%i", [assetment getServerConssistencyPoints]]];
    [total setText:[NSString stringWithFormat:@"%i", [assetment getServerTotalPoints]]];
}


@end
