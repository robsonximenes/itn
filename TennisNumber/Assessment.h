//
//  Assessment.h
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 11/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stroke;

@interface Assessment : NSManagedObject

@property (nonatomic, retain) NSString * assessor;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * gsAccuracyPoints;
@property (nonatomic, retain) NSNumber * gsDephPoints;
@property (nonatomic, retain) NSNumber * itn;
@property (nonatomic, retain) NSNumber * mobility;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * serverPoints;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * venue;
@property (nonatomic, retain) NSNumber * volleyDephPoints;
@property (nonatomic, retain) NSNumber * mobilityTime;
@property (nonatomic, retain) NSSet *strokes;
@end

@interface Assessment (CoreDataGeneratedAccessors)

- (void)addStrokesObject:(Stroke *)value;
- (void)removeStrokesObject:(Stroke *)value;
- (void)addStrokes:(NSSet *)values;
- (void)removeStrokes:(NSSet *)values;

-(id) initWithContext: (NSManagedObjectContext *) context;

@end
