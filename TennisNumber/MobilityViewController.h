//
//  MobilityViewController.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobilityViewController : UIViewController
@property (assign, nonatomic) IBOutlet UILabel *timeLabel;
@property (assign, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)start:(id)sender;
@property (assign, nonatomic) IBOutlet UIButton *stopButton;
- (IBAction)stop:(id)sender;

@property (assign, nonatomic) IBOutlet UILabel *total;
- (IBAction)exit:(id)sender;
@end
