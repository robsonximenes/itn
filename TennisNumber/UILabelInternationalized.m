//
//  UILabelInternationalized.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 18/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "UILabelInternationalized.h"

@implementation UILabelInternationalized

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])){
        [self localize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self localize];
    }
    return self;
}

-(void) localize{
    NSString* text = NSLocalizedString(self.text, nil);
    [self setText:text];
}

@end
