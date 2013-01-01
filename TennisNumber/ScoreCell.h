//
//  ScoreCell.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 22/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreCell : UITableViewCell
@property (assign, nonatomic) IBOutlet UILabel *name;
@property (assign, nonatomic) IBOutlet UILabel *total;
@property (assign, nonatomic) IBOutlet UILabel *abstrct;

@end
