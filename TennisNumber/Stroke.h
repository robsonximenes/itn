//
//  Stroke.h
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 09/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>




@class Assessment;

@interface Stroke : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Assessment *assessment;

-(id) initWithNumber:(NSString *) number strokName:(NSString *) name score:(NSString *) score type: (NSNumber *)type context: (NSManagedObjectContext *) context;

@end
