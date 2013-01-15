//
//  TennisNumberIAPHelper.m
//  TennisNumber
//
//  Created by Robson Ximenes on 14/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "TennisNumberIAPHelper.h"


@implementation TennisNumberIAPHelper

+ (TennisNumberIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static TennisNumberIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"ALLFEATURES",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
