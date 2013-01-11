//
//  Stroke.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 09/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "Stroke.h"
#import "Assessment.h"


@implementation Stroke

@dynamic order;
@dynamic score;
@dynamic type;
@dynamic name;
@dynamic assessment;

-(id) initWithNumber:(NSString *) number strokName:(NSString *) name score:(NSString *) score type: (NSNumber *)type context: (NSManagedObjectContext *) context{
    self = self = [NSEntityDescription insertNewObjectForEntityForName:@"Stroke"
                                                inManagedObjectContext:context ];;
    if (self) {
        [self setName:name];
        [self setOrder:[NSNumber numberWithInt:[number intValue]]];
        [self setScore:[NSNumber numberWithInt:[score intValue]]];
        [self setType:type];
    }
    return self;
}

@end
