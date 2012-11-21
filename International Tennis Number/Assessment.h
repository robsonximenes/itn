//
//  Assessment.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Assessment : NSObject

@property NSString *name;
@property NSDate *birthday;
@property NSString *sex;
@property NSString *assessor;
@property NSDate *date;
@property NSString *local;


@property NSMutableArray *groundStrokeDeph;
@property NSMutableArray *volleyDeph;
@property NSMutableArray *groundStrokePrecision;
@property NSMutableArray *server;
@property NSInteger mobilityTime;

@property NSMutableArray * strokesForGSAccuracy;
@property NSMutableArray * strokesForGSDeph;
@property NSMutableArray * strokesForVolleyDeph;
@property NSMutableArray * strokesForServer;


- (int) getGroundStrokePoints;
- (int) getGroundStrokeConssistencyPoints;
- (int) getGroundStrokeTotalPoints;

- (int) getVolleyDephPoints;
- (int) getVolleyDephConssistencyPoints;
- (int) getVolleyDephTotalPoints;

- (int) getGSAccuracyPoints;
- (int) getGSAccuracyConssistencyPoints;
- (int) getGSAccuracyTotalPoints;

- (int) getServerPoints;
- (int) getServerConssistencyPoints;
- (int) getServerTotalPoints;


- (int) getStrokePoints;
- (int) getMobilityPoints;
- (int) getTotalPoints;

- (int) calculateITN;

-(NSMutableArray *) getStrokesForGSAccuracy;
-(NSMutableArray *) getStrokesForGSDeph;
-(NSMutableArray *) getStrokesForVolleyDeph;
-(NSMutableArray *) getStrokesForServer;

+(NSArray *) getPointsForGSAccuracy;
+(NSArray *) getPointsForGSDeph;
+(NSArray *) getPointsForVolleyDeph;
+(NSArray *) getPointsForServer;

+ (Assessment *)current;
+ (void) clearInstance;

@end
