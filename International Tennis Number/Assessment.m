//
//  Assessment.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "Assessment.h"
#import "Stroke.h"

#define MOBILITY_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6],[NSNumber numberWithInt:7],[NSNumber numberWithInt:8],[NSNumber numberWithInt:9],[NSNumber numberWithInt:10],[NSNumber numberWithInt:11],[NSNumber numberWithInt:12],[NSNumber numberWithInt:12],[NSNumber numberWithInt:14],[NSNumber numberWithInt:15],[NSNumber numberWithInt:16],[NSNumber numberWithInt:18],[NSNumber numberWithInt:19],[NSNumber numberWithInt:21],[NSNumber numberWithInt:26],[NSNumber numberWithInt:32],[NSNumber numberWithInt:39],[NSNumber numberWithInt:45],[NSNumber numberWithInt:52],[NSNumber numberWithInt:61],[NSNumber numberWithInt:75],nil]

#define MALE_ITN_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:75],[NSNumber numberWithInt:104],[NSNumber numberWithInt:139],[NSNumber numberWithInt:175],[NSNumber numberWithInt:209],[NSNumber numberWithInt:244],[NSNumber numberWithInt:268],[NSNumber numberWithInt:293],[NSNumber numberWithInt:337],[NSNumber numberWithInt:362],[NSNumber numberWithInt:430],nil]

#define FEMALE_ITN_SCORE [NSArray arrayWithObjects: [NSNumber numberWithInt:57],[NSNumber numberWithInt:79],[NSNumber numberWithInt:108],[NSNumber numberWithInt:140],[NSNumber numberWithInt:171],[NSNumber numberWithInt:205],[NSNumber numberWithInt:230],[NSNumber numberWithInt:258],[NSNumber numberWithInt:303],[NSNumber numberWithInt:344],[NSNumber numberWithInt:430],nil]

@implementation Assessment


@synthesize name,birthday,sex,assessor,date,local,groundStrokeDeph,volleyDeph,groundStrokePrecision,server,mobilityTime;

@synthesize strokesForGSAccuracy,strokesForGSDeph,strokesForServer,strokesForVolleyDeph;


static Assessment *instance = NULL;

+ (Assessment *)current{
    @synchronized(self){
        if (!instance) instance = [[Assessment alloc] init];
    }
    return(instance);
}


-(id)init
{
    if (self = [super init]){
        groundStrokeDeph = [[NSMutableArray alloc] initWithCapacity:10];
        volleyDeph = [[NSMutableArray alloc] initWithCapacity:8];
        groundStrokePrecision = [[NSMutableArray alloc] initWithCapacity:12];
        server = [[NSMutableArray alloc] initWithCapacity:12];
    }
    return self;
}

- (int) getGroundStrokePoints{
    int points = 0;
    for (int i =0; i<[groundStrokeDeph count]; i++) {
        points+= [((NSNumber*)[groundStrokeDeph objectAtIndex:i]) intValue];
    }
    return points;
}
- (int) getGroundStrokeConssistencyPoints{
    int points = 0;
    for (int i =0; i<[groundStrokeDeph count]; i++) {
        int p = [((NSNumber*)[groundStrokeDeph objectAtIndex:i]) intValue];
        if(p>0){
            points++;
        }
    }
    return points;
}
- (int) getGroundStrokeTotalPoints{
    return [self getGroundStrokePoints]+[self getGroundStrokeConssistencyPoints];
}

- (int) getVolleyDephPoints{
    int points = 0;
    for (int i =0; i<[volleyDeph count]; i++) {
        points+= [((NSNumber*)[volleyDeph objectAtIndex:i]) intValue];
    }
    return points;
}

- (int) getVolleyDephConssistencyPoints{
    int points = 0;
    for (int i =0; i<[volleyDeph count]; i++) {
        if([((NSNumber*)[volleyDeph objectAtIndex:i]) intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getVolleyDephTotalPoints{
    return [self getVolleyDephPoints]+[self getVolleyDephConssistencyPoints];
}


- (int) getGSAccuracyPoints{
    int points = 0;
    for (int i =0; i<[groundStrokePrecision count]; i++) {
        points+= [((NSNumber*)[groundStrokePrecision objectAtIndex:i]) intValue];
    }
    return points;
}

- (int) getGSAccuracyConssistencyPoints{
    int points = 0;
    for (int i =0; i<[groundStrokePrecision count]; i++) {
        if([((NSNumber*)[groundStrokePrecision objectAtIndex:i]) intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getGSAccuracyTotalPoints{
    return [self getGSAccuracyPoints]+[self getGSAccuracyConssistencyPoints];
}
            

- (int) getServerPoints{
    int points = 0;
    for (int i =0; i<[server count]; i++) {
        points+= [((NSNumber*)[server objectAtIndex:i]) intValue];
    }
    return points;
}

- (int) getServerConssistencyPoints{
    int points = 0;
    for (int i =0; i<[server count]; i++) {
        if([((NSNumber*)[server objectAtIndex:i]) intValue]>0){
            points++;
        }
    }
    return points;
}

- (int) getServerTotalPoints{
    return [self getServerPoints]+[self getServerConssistencyPoints];
}


- (int) getStrokePoints{
    return [self getGroundStrokeTotalPoints]+ [self getVolleyDephTotalPoints] + [self getGSAccuracyTotalPoints] + [self getServerTotalPoints];
}
- (int) getMobilityPoints{
    int points = 0;
    if(mobilityTime==0){
        points = 0;
    }else if(mobilityTime<15){
        points = [((NSNumber*)[MOBILITY_SCORE objectAtIndex:25]) intValue];
    }else if(mobilityTime>40){
        points = [((NSNumber*)[MOBILITY_SCORE objectAtIndex:0]) intValue];
    }else{
        points = [((NSNumber*)[MOBILITY_SCORE objectAtIndex:40 - mobilityTime]) intValue];
    }
    
    return points;
}
- (int) getTotalPoints{
    return [self getStrokePoints]+[self getMobilityPoints];
}

- (int) calculateITN{
    int itn = 10;
    int score = [self getTotalPoints];
    NSArray *points = NULL;
    if([sex isEqualToString:@"F"]){
        points = FEMALE_ITN_SCORE;
    }else{
        points = MALE_ITN_SCORE;
    }
    for (int i =0; i<[points count]; i++) {
        int max = [((NSNumber*)[points objectAtIndex:i]) intValue];
        NSLog(@"Max (%d) - Score(%d)",max,score);
        if(score<= max){
            itn = 11-i;
            break;
        }
    }
    
    return itn;
}


-(NSMutableArray *) getStrokesForGSAccuracy{
    if(!strokesForGSAccuracy){
        NSMutableArray *strokes = [[NSMutableArray alloc] init];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"9" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"10" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"11" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"12" strokName:@"Backhand CC" score:@"0" ]];
        strokesForGSAccuracy = strokes;
    }
    return strokesForGSAccuracy;
}

-(NSMutableArray *) getStrokesForGSDeph{
    NSMutableArray *strokes = [[NSMutableArray alloc] init];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"9" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"10" strokName:@"Backhand" score:@"0" ]];
    return strokes;
}

-(NSMutableArray *) getStrokesForVolleyDeph{
    NSMutableArray *strokes = [[NSMutableArray alloc] init];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand" score:@"0" ]];
    [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand" score:@"0" ]];
    return strokes;
}

-(NSMutableArray *) getStrokesForServer{
    if(!strokesForServer){
        NSMutableArray *strokes = [[NSMutableArray alloc] init];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"1" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"2" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"3" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"4" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"5" strokName:@"Forehand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"6" strokName:@"Backhand DL" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"7" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"8" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"9" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"10" strokName:@"Backhand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"11" strokName:@"Forehand CC" score:@"0" ]];
        [strokes addObject:[[Stroke alloc] initWithNumber:@"12" strokName:@"Backhand CC" score:@"0" ]];
        strokesForServer = strokes;
    }
    return strokesForServer;
}


//GS Deph   : 0,1,2,3,4,5,6,8
//VO Deph   : 0,1,2,3,4,5,6,8
//GS Accu   : 0,1,2,3,4,6
//Service   : 0,1,2,3,4,5,8
+(NSArray *) getPointsForGSAccuracy{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"6", nil];
}

+(NSArray *) getPointsForGSDeph{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"8", nil];
}

+(NSArray *) getPointsForVolleyDeph{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"8", nil];
}

+(NSArray *) getPointsForServer{
    return [NSArray arrayWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"8", nil];
}




@end
