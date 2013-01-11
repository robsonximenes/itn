//
//  Assessment.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 11/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "Assessment.h"
#import "Stroke.h"


@implementation Assessment

@dynamic assessor;
@dynamic birthday;
@dynamic date;
@dynamic gsAccuracyPoints;
@dynamic gsDephPoints;
@dynamic itn;
@dynamic mobility;
@dynamic name;
@dynamic serverPoints;
@dynamic sex;
@dynamic venue;
@dynamic volleyDephPoints;
@dynamic mobilityTime;
@dynamic strokes;

-(id) initWithContext: (NSManagedObjectContext *) context{
    self = [NSEntityDescription insertNewObjectForEntityForName:@"Assessment"
                                                inManagedObjectContext:context ];
    return self;
}

@end
