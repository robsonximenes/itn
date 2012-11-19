//
//  ScoreViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "ScoreViewController.h"
#import "Assessment.h"

@interface ScoreViewController ()
@property Assessment *assessment;
@end

@implementation ScoreViewController

@synthesize assessment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.assessment = [Assessment current];
    
    self.gsAccuracyConsistency.text = [NSString stringWithFormat:@"%d",[assessment getGSAccuracyConssistencyPoints] ];
    self.gsAccuracySubtotal.text = [NSString stringWithFormat:@"%d",[assessment getGSAccuracyPoints]];
    self.gsAccuracyTotal.text = [NSString stringWithFormat:@"%d",[assessment getGSAccuracyTotalPoints]];
    
    self.volleyDephConsistency.text = [NSString stringWithFormat:@"%d",[assessment getVolleyDephConssistencyPoints] ];
    self.volleyDephSubtotal.text = [NSString stringWithFormat:@"%d",[assessment getVolleyDephPoints]];
    self.volleyDephTotal.text = [NSString stringWithFormat:@"%d",[assessment getVolleyDephTotalPoints]];
    
    self.gsDephConsistency.text = [NSString stringWithFormat:@"%d",[assessment getGroundStrokeConssistencyPoints] ];
    self.gsDephSubtotal.text = [NSString stringWithFormat:@"%d",[assessment getGroundStrokePoints]];
    self.gsDephTotal.text = [NSString stringWithFormat:@"%d",[assessment getGroundStrokeTotalPoints]];
    
    self.serverConsistency.text = [NSString stringWithFormat:@"%d",[assessment getServerConssistencyPoints] ];
    self.serverSubtotal.text = [NSString stringWithFormat:@"%d",[assessment getServerPoints]];
    self.serverTotal.text = [NSString stringWithFormat:@"%d",[assessment getServerTotalPoints]];
    
    self.mobilityTotal.text = [NSString stringWithFormat:@"%d",[assessment getMobilityPoints] ];
    self.itnTotal.text = [NSString stringWithFormat:@"%d",[assessment calculateITN]];
    
    self.total.text = [NSString stringWithFormat:@"%d",[assessment getTotalPoints]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
