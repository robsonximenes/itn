//
//  StrokeDetailCell.h
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 14/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrokeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *order;
@property (weak, nonatomic) IBOutlet UILabel *strokeName;
@property (weak, nonatomic) IBOutlet UILabel *score;
@end
