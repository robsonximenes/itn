//
//  VolleyDephViewController.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "VolleyDephViewController.h"
#import "Assessment.h"

#define TAG_STROKE1 101
#define TAG_STROKE2 102
#define TAG_STROKE3 103
#define TAG_STROKE4 104
#define TAG_STROKE5 105
#define TAG_STROKE6 106
#define TAG_STROKE7 107
#define TAG_STROKE8 108

@interface VolleyDephViewController ()
@property Assessment *assetment;
@end

@implementation VolleyDephViewController

@synthesize stroke1,stroke2,stroke3,stroke4,stroke5,stroke6,stroke7,stroke8;
@synthesize subtotal, consistency, total;
@synthesize assetment;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    assetment = [[Assessment alloc] init];
    
    [stroke1 setTag:TAG_STROKE1];
    [stroke2 setTag:TAG_STROKE2];
    [stroke3 setTag:TAG_STROKE3];
    [stroke4 setTag:TAG_STROKE4];
    [stroke5 setTag:TAG_STROKE5];
    [stroke6 setTag:TAG_STROKE6];
    [stroke7 setTag:TAG_STROKE7];
    [stroke8 setTag:TAG_STROKE8];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) calculateScore{
    
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke1.text intValue]] atIndexedSubscript:0];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke2.text intValue]] atIndexedSubscript:1];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke3.text intValue]] atIndexedSubscript:2];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke4.text intValue]] atIndexedSubscript:3];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke5.text intValue]] atIndexedSubscript:4];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke6.text intValue]] atIndexedSubscript:5];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke7.text intValue]] atIndexedSubscript:6];
    [assetment.groundStrokeDeph setObject:[NSNumber numberWithInt:[stroke8.text intValue]] atIndexedSubscript:7];
    
    
    [subtotal setText:[NSString stringWithFormat:@"%i", [assetment getGroundStrokePoints]]];
    [consistency setText:[NSString stringWithFormat:@"%i", [assetment getGroundStrokeConssistencyPoints]]];
    [total setText:[NSString stringWithFormat:@"%i", [assetment getGroundStrokeTotalPoints]]];
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
        default:
            [textField resignFirstResponder];
            break;
    }
    
    [self calculateScore];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == stroke8) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
}

@end

