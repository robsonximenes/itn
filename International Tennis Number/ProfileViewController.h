//
//  ProfileViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 20/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateBirthTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentField;
@property (weak, nonatomic) IBOutlet UITextField *assessortextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *venueTextField;
- (IBAction)exit:(id)sender;


@end
