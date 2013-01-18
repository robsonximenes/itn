//
//  ProfileViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 20/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabelInternationalized.h"

@interface ProfileViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabelInternationalized *nameLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;
@property (assign, nonatomic) IBOutlet UITextField *nameTextField;
@property (assign, nonatomic) IBOutlet UITextField *dateBirthTextField;
@property (assign, nonatomic) IBOutlet UISegmentedControl *sexSegmentField;
@property (assign, nonatomic) IBOutlet UITextField *assessortextField;
@property (assign, nonatomic) IBOutlet UITextField *dateTextField;
@property (assign, nonatomic) IBOutlet UITextField *venueTextField;
- (IBAction)exit:(id)sender;

@property (weak, nonatomic) IBOutlet UILabelInternationalized *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabelInternationalized *sexLabel;
@property (weak, nonatomic) IBOutlet UILabelInternationalized *assessorLabel;
@property (weak, nonatomic) IBOutlet UILabelInternationalized *dateLabel;
@property (weak, nonatomic) IBOutlet UILabelInternationalized *venueLabel;

@end
