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
    
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton setTitle:@"Stop" forState:UIControlStateHighlighted];
    
    
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
        [self calculateScore];
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
    }
}

#pragma mark Quit the assessment
- (IBAction)exit:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Caution" message:@"If you quit now the data will be lost. Continue?" delegate:self cancelButtonTitle:@"Noooo!" otherButtonTitles:@"Ok, quit!", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0){
		// Yes, do something
	}else if (buttonIndex == 1){
		for (UIViewController *view in [self.navigationController viewControllers]) {
            [view dismissViewControllerAnimated:false completion:nil];
        }
    }
}

@end
