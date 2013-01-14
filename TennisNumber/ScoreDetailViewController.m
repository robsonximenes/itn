//
//  ScoreDetailViewController.m
//  TennisNumber
//
//  Created by Robson Ximenes on 11/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "ScoreDetailViewController.h"
#import "AssessmentBC.h"
#import "Stroke.h"
#import "ScoreCell.h"
#import "StrokeDetailCell.h"

@interface ScoreDetailViewController ()

@property NSArray *strokes;

@end

@implementation ScoreDetailViewController

@synthesize type, strokes, strokeName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [self setTitle:strokeName];
    
    strokes = [[AssessmentBC current] getStrokesForType:type];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    return [strokes count];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return 33;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;

    // Detalhes dos golpes
    if(indexPath.section == 1){
        
        static NSString *StrokeDetailCellXib = @"StrokeDetailCell";
        StrokeDetailCell *detail = (StrokeDetailCell *)[tableView dequeueReusableCellWithIdentifier:StrokeDetailCellXib];
        if(!detail){
            NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:StrokeDetailCellXib owner:nil options:nil];
            for(id currentObject in topObjects){
                if([currentObject isKindOfClass:[StrokeDetailCell class]]){
                    detail = (StrokeDetailCell *)currentObject;
                    break;
                }
                
            }
        }
    
        Stroke *s = [strokes objectAtIndex:indexPath.row];
        
        [[detail order] setText:[NSString stringWithFormat:@"%@",[s order]]];
        [[detail score] setText:[NSString stringWithFormat:@"%@",[s score]]];
        [[detail strokeName] setText:[s name]];
        
        cell = detail;
        
    }else{ // Consolidado
            static NSString *ScoreCellXib = @"ScoreCell";
            ScoreCell *cell2 = (ScoreCell *)[tableView dequeueReusableCellWithIdentifier:ScoreCellXib];
            if(!cell2){
                NSArray *topObjects = [[NSBundle mainBundle] loadNibNamed:ScoreCellXib owner:nil options:nil];
                for(id currentObject in topObjects){
                    if([currentObject isKindOfClass:[ScoreCell class]]){
                        cell2 = (ScoreCell *)currentObject;
                        break;
                    }
                    
                }
            }
            
            
            AssessmentBC *bc = [AssessmentBC current];
            static NSString *text = @"Subtotal: %i, Consistency: %i";
            [cell2.name setText:strokeName];
            [cell2.abstrct setText:[NSString stringWithFormat:text,
                                   [bc getPointsForStrokeType:type],
                                   [bc getConssistencyPointsForStrokeType:type]]];
            [cell2.total setText:[NSString stringWithFormat:@"%d",[bc getTotalPointsForStrokeType:type]]];
        
            cell = cell2;
    }
    
    
    return cell;
}


@end
