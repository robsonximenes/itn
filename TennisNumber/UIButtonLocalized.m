//
//  UIButtonLocalized.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 18/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "UIButtonLocalized.h"

@implementation UIButtonLocalized

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])){
        [self localizeButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self localizeButton];
    }
    return self;
}

-(void) localizeButton{
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    NSString* text = NSLocalizedString(self.titleLabel.text, nil);
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitle:text forState:UIControlStateHighlighted];
    [self setTitle:text forState:UIControlStateDisabled];
    [self setTitle:text forState:UIControlStateSelected];
}

@end
