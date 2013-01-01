//
//  StrokeCell.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface StrokeCell : UITableViewCell
@property (assign, nonatomic) IBOutlet UILabel *number;
@property (assign, nonatomic) IBOutlet UILabel *strokeName;
@property (assign, nonatomic) IBOutlet UISegmentedControl *score;
@property (retain) AVAudioPlayer *player;

- (IBAction)scoreValueChanged:(UISegmentedControl *)sender;
@end
