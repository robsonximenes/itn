//
//  Stroke.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "Stroke.h"

@implementation Stroke

@synthesize number,strokeName,score;

- (id) initWithNumber: (NSString *)n strokName:(NSString *)sn score:(NSString *)s{

    if (self = [super init]){
        number = n;
        strokeName = sn;
        score = s;
    }
    return self;
}

@end
