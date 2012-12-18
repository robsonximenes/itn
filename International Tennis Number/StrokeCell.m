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
@synthesize player;


- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSound];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSound];
    }
    return self;
}

-(void) initSound{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/tennisball.wav", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player setVolume:0.5];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)scoreValueChanged:(UISegmentedControl *)sender {
    [player play];
}
@end
