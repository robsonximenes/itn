//
//  ScoreViewController.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *gsDephView;
@property (weak, nonatomic) IBOutlet UILabel *gsDephSubtotal;
@property (weak, nonatomic) IBOutlet UILabel *gsDephConsistency;
@property (weak, nonatomic) IBOutlet UILabel *gsDephTotal;
@property (weak, nonatomic) IBOutlet UILabel *total;

@property (weak, nonatomic) IBOutlet UIView *volleyDephView;
@property (weak, nonatomic) IBOutlet UILabel *volleyDephSubtotal;
@property (weak, nonatomic) IBOutlet UILabel *volleyDephConsistency;
@property (weak, nonatomic) IBOutlet UILabel *volleyDephTotal;

@property (weak, nonatomic) IBOutlet UIView *gsAccuracyView;
@property (weak, nonatomic) IBOutlet UILabel *gsAccuracySubtotal;
@property (weak, nonatomic) IBOutlet UILabel *gsAccuracyConsistency;
@property (weak, nonatomic) IBOutlet UILabel *gsAccuracyTotal;

@property (weak, nonatomic) IBOutlet UIView *serverView;
@property (weak, nonatomic) IBOutlet UILabel *serverSubtotal;
@property (weak, nonatomic) IBOutlet UILabel *serverConsistency;
@property (weak, nonatomic) IBOutlet UILabel *serverTotal;

@property (weak, nonatomic) IBOutlet UIView *mobilityView;
@property (weak, nonatomic) IBOutlet UILabel *mobilityTotal;

@property (weak, nonatomic) IBOutlet UIView *itnView;
@property (weak, nonatomic) IBOutlet UILabel *itnTotal;

@end
