//
//  ScoreCell.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 22/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *abstrct;

@end
