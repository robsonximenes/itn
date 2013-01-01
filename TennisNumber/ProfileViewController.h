//
//  ProfileViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 20/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UITableViewController<UITextFieldDelegate>
@property (assign, nonatomic) IBOutlet UITextField *nameTextField;
@property (assign, nonatomic) IBOutlet UITextField *dateBirthTextField;
@property (assign, nonatomic) IBOutlet UISegmentedControl *sexSegmentField;
@property (assign, nonatomic) IBOutlet UITextField *assessortextField;
@property (assign, nonatomic) IBOutlet UITextField *dateTextField;
@property (assign, nonatomic) IBOutlet UITextField *venueTextField;
- (IBAction)exit:(id)sender;


@end
