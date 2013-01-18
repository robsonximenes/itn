//
//  MobilityViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "MobilityViewController.h"
#import "AssessmentBC.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface MobilityViewController ()
@property Assessment *assessment;
@property NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property NSDate *startDate;
@property int time;
@property AVAudioPlayer *player;
@end

@implementation MobilityViewController{
    BOOL running;
    UIImage *startImage;
    UIImage *stopImage;
}

@synthesize timeLabel,total,startButton,stopButton, assessment;
@synthesize startDate,stopWatchTimer,time;
@synthesize player;


-(id) initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.title = NSLocalizedString(@"Mobility",@"");
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initSound];
    
    self.assessment = [[AssessmentBC current] assessment];
    [self calculateScore];
    
    running = false;
    
    startImage = [[UIImage imageNamed:@"pixelVerde"]
                  resizableImageWithCapInsets:UIEdgeInsetsMake(-5, 0, 5, 0)];
    stopImage = [[UIImage imageNamed:@"pixelVermelho"]
                  resizableImageWithCapInsets:UIEdgeInsetsMake(-5, 0, 5, 0)];
    
    startButton.layer.cornerRadius = 10;
    startButton.clipsToBounds = YES;
    
}

-(void) initSound{
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/apito.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	NSError *error;
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player setVolume:0.8];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    UIButton *button = sender;
//    [startButton setEnabled:false];
//    [stopButton setEnabled:true];
    
    if(running){
        // STOPPING
        if(stopWatchTimer){
            [self calculateScore];
            [stopWatchTimer invalidate];
            stopWatchTimer = nil;
        }
        running = false;
        [button setTitle:NSLocalizedString(@"Start",@"Label to start the mobility test") forState:UIControlStateNormal];
        [button setBackgroundImage:startImage forState:UIControlStateNormal];
        button.layer.cornerRadius = 10;
        
    }else{
        //STARTING
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([defaults boolForKey:DEFAULTS_SOUND_ENEBLED]){
            [player play];
        }
        if(stopWatchTimer){
            [stopWatchTimer invalidate];
            stopWatchTimer = nil;
        }
        startDate = [NSDate date];
        stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        
        running = true;
        [button setTitle:NSLocalizedString(@"Stop",@"Label to stop the mobility test") forState:UIControlStateNormal];
        [button setBackgroundImage:stopImage forState:UIControlStateNormal];
    }
    
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
        [assessment setMobilityTime:[NSNumber numberWithInt:time ]];
    }
    total.text = [NSString stringWithFormat:@"%d", [[AssessmentBC current] getMobilityPoints]];
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
    
    for (UIViewController *view in [self.navigationController viewControllers]) {
        [view dismissViewControllerAnimated:false completion:nil];
    }
}


@end
