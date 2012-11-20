//
//  StrokeCell.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *strokeName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *score;

@end
