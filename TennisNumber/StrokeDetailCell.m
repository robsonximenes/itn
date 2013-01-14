//
//  StrokeDetailCell.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 14/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "StrokeDetailCell.h"

@implementation StrokeDetailCell

@synthesize order, score,strokeName;

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
