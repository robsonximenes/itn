//
//  GroundStroke.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "GroundStroke.h"

#define TAG_STROKE1 101
#define TAG_STROKE2 102
#define TAG_STROKE3 103
#define TAG_STROKE4 104
#define TAG_STROKE5 105
#define TAG_STROKE6 106
#define TAG_STROKE7 107
#define TAG_STROKE8 108
#define TAG_STROKE9 109
#define TAG_STROKE10 1010

@interface GroundStroke ()

@end

@implementation GroundStroke

@synthesize stroke1,stroke2,stroke3,stroke4,stroke5,stroke6,stroke7,stroke8,stroke9,stroke10;
@synthesize subtotal, consistency, total;
@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [stroke1 setTag:TAG_STROKE1];
    [stroke2 setTag:TAG_STROKE2];
    [stroke3 setTag:TAG_STROKE3];
    [stroke4 setTag:TAG_STROKE4];
    [stroke5 setTag:TAG_STROKE5];
    [stroke6 setTag:TAG_STROKE6];
    [stroke7 setTag:TAG_STROKE7];
    [stroke8 setTag:TAG_STROKE8];
    [stroke9 setTag:TAG_STROKE9];
    [stroke10 setTag:TAG_STROKE10];
    
//    scrollView.contentSize = CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height*2);
    
    [scrollView setContentSize:CGSizeMake(2000, 2000)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) calculateScore{
    int s = 0;
    int c = 0;
    int t = 0;
    
    s+= [stroke1.text intValue];
    s+= [stroke2.text intValue];
    s+= [stroke3.text intValue];
    s+= [stroke4.text intValue];
    s+= [stroke5.text intValue];
    s+= [stroke6.text intValue];
    s+= [stroke7.text intValue];
    s+= [stroke8.text intValue];
    s+= [stroke9.text intValue];
    s+= [stroke10.text intValue];
    
    if([stroke1.text intValue]!=0) c++;
    if([stroke2.text intValue]!=0) c++;
    if([stroke3.text intValue]!=0) c++;
    if([stroke4.text intValue]!=0) c++;
    if([stroke5.text intValue]!=0) c++;
    if([stroke6.text intValue]!=0) c++;
    if([stroke7.text intValue]!=0) c++;
    if([stroke8.text intValue]!=0) c++;
    if([stroke9.text intValue]!=0) c++;
    if([stroke10.text intValue]!=0) c++;
    
    t = s + c;
    
    [subtotal setText:[NSString stringWithFormat:@"%i", s]];
    [consistency setText:[NSString stringWithFormat:@"%i", c]];
    [total setText:[NSString stringWithFormat:@"%i", t]];
}

# pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case TAG_STROKE1:
            [stroke2 becomeFirstResponder];
            break;
        case TAG_STROKE2:
            [stroke3 becomeFirstResponder];
            break;
        case TAG_STROKE3:
            [stroke4 becomeFirstResponder];
            break;
        case TAG_STROKE4:
            [stroke5 becomeFirstResponder];
            break;
        case TAG_STROKE5:
            [stroke6 becomeFirstResponder];
            break;
        case TAG_STROKE6:
            [stroke7 becomeFirstResponder];
            break;
        case TAG_STROKE7:
            [stroke8 becomeFirstResponder];
            break;
        case TAG_STROKE8:
            [stroke9 becomeFirstResponder];
            break;
        case TAG_STROKE9:
            [stroke10 becomeFirstResponder];
            break;
        default:
            [textField resignFirstResponder];
            break;
    }
    
    [self calculateScore];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == stroke10) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
}

@end
