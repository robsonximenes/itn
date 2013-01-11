//
//  Assessment.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Assessment.h"

@interface AssessmentBC : NSObject

@property NSManagedObjectContext *ctx;
@property Assessment *assessment;

-(Assessment *) createAssessment;

- (int) getPointsForStrokeType: (int) type;
- (int) getConssistencyPointsForStrokeType: (int) type;
- (int) getTotalPointsForStrokeType: (int) type;

- (int) getStrokeTotalPoints;
- (int) getMobilityPoints;
- (int) getTotalPoints;

- (int) calculateITN;

-(NSMutableArray *) getStrokesForType: (int) type;

+(NSArray *) getPossiblePointsForType: (int) type;

+ (void) configureSampleAssessment;
+ (AssessmentBC *)current;
+ (void) clearInstance;

-(void)save:(Assessment *)object;
-(void)save;
- (void) removeAssessment:(Assessment *)object;
-(NSManagedObject *)fetch;
-(NSArray *)findAll;

@end
