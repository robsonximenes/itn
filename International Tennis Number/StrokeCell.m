//
//  StrokeCell.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "StrokeCell.h"

@implementation StrokeCell

@synthesize number, score, strokeName;

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
