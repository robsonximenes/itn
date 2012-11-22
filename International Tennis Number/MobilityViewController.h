//
//  MobilityViewController.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobilityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)start:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
- (IBAction)stop:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *total;
- (IBAction)exit:(id)sender;
@end
