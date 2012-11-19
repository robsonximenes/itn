//
//  Stroke.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stroke : NSObject

@property NSString *number;
@property NSString *strokeName;
@property NSString *score;

-(id) initWithNumber: (NSString *)n strokName:(NSString *)sn score:(NSString *)s;


@end
