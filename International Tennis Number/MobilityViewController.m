//
//  MobilityViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "MobilityViewController.h"
#import "Assessment.h"

@interface MobilityViewController ()
@property Assessment *assessment;
@property NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property NSDate *startDate;
@property int time;
@end

@implementation MobilityViewController

@synthesize timeLabel,total,startButton,stopButton, assessment;
@synthesize startDate,stopWatchTimer,time;

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
    [self calculateScore];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    [startButton setEnabled:false];
    [stopButton setEnabled:true];
    if(stopWatchTimer){
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
    }
    startDate = [NSDate date];
    stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    timeLabel.text = timeString;
    time = [timeString intValue];
    [self calculateScore];

}


-(void) calculateScore{
    if(time>0){
        [assessment setMobilityTime:time];
    }
    total.text = [NSString stringWithFormat:@"%d", [assessment getMobilityPoints]];
}

- (IBAction)stop:(id)sender {
    [startButton setEnabled:true];
    [stopButton setEnabled:false];
    if(stopWatchTimer){
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
    }
}
@end
