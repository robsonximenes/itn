//
//  UIBarButtonItemLocalized.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 18/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "UIBarButtonItemLocalized.h"

@implementation UIBarButtonItemLocalized

-(id) initWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem target:(id)target action:(SEL)action{
    if ((self = [super initWithBarButtonSystemItem:systemItem target:target action:action])){
        [self localizeButton];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])){
        [self localizeButton];
    }
    return self;
}

-(void) localizeButton{
    self.title = NSLocalizedString(self.title, nil);
}

@end
