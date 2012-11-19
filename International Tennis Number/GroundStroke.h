//
//  GroundStroke.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundStroke : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *stroke1;
@property (weak, nonatomic) IBOutlet UITextField *stroke2;
@property (weak, nonatomic) IBOutlet UITextField *stroke3;
@property (weak, nonatomic) IBOutlet UITextField *stroke4;
@property (weak, nonatomic) IBOutlet UITextField *stroke5;
@property (weak, nonatomic) IBOutlet UITextField *stroke6;
@property (weak, nonatomic) IBOutlet UITextField *stroke7;
@property (weak, nonatomic) IBOutlet UITextField *stroke8;
@property (weak, nonatomic) IBOutlet UITextField *stroke9;
@property (weak, nonatomic) IBOutlet UITextField *stroke10;
@property (weak, nonatomic) IBOutlet UILabel *subtotal;
@property (weak, nonatomic) IBOutlet UILabel *consistency;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
