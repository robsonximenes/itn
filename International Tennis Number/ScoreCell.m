//
//  ScoreCell.m
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 22/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "ScoreCell.h"

@implementation ScoreCell

@synthesize name, total, abstrct;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
