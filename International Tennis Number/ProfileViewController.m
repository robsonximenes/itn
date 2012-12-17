//
//  ProfileViewController.m
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 20/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "ProfileViewController.h"
#import "Assessment.h"

@interface ProfileViewController ()
@property UIActionSheet *dateBirthSheet;
@property UIActionSheet *dateSheet;
@property UIDatePicker *dateBirthPicker;
@property UIDatePicker *datePicker;
@end

@implementation ProfileViewController

@synthesize dateBirthSheet,dateSheet,dateBirthPicker,datePicker;

@synthesize nameTextField,dateBirthTextField,sexSegmentField,assessortextField,dateTextField,venueTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    Assessment *a = [Assessment current];
    [a setName:nameTextField.text];
    [a setSex:[sexSegmentField titleForSegmentAtIndex:[sexSegmentField selectedSegmentIndex]]];
    [a setAssessor:assessortextField.text];
    [a setLocal:venueTextField.text];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark UITextFieldDelegate
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField == self.dateBirthTextField){
        [self createDateBirthPicker];
        return NO;
    }
    if(textField == self.dateTextField){
        [self createDatePicker];
        return NO;
    }
    return YES;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    Assessment * a = [Assessment current];
    a.name = nameTextField.text;
    a.birthday = dateBirthPicker.date;
    a.sex = [sexSegmentField titleForSegmentAtIndex:[sexSegmentField selectedSegmentIndex]];
    
    a.assessor = assessortextField.text;
    a.date = datePicker.date;
    a.local = venueTextField.text;
}

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    BOOL isOk = true;
    
    NSMutableString *sb = [NSMutableString stringWithString:@""];
    
    if(nameTextField.text.length<1){
        isOk = false;
        [sb appendString:@"The names is required.\n "];
    }
    
    if(!isOk){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile validation" message:sb delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
    
    return isOk;
}


#pragma mark DatePickers
-(void) createDateBirthPicker{
    dateBirthSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [dateBirthSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    dateBirthPicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,44,0,0)];
    [dateBirthPicker setDatePickerMode:UIDatePickerModeDate];
    
    [dateBirthSheet addSubview:dateBirthPicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,dateBirthSheet.bounds.size.width,44)];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [toolBar sizeToFit];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *selectButton = [[UIBarButtonItem alloc]initWithTitle:@"Select" style:UIBarButtonItemStyleBordered target:self action:@selector(dateBirthSelected)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dateCancelled)];
    
    [toolBar setItems:[NSArray arrayWithObjects:space,selectButton,cancelButton, nil] animated:YES];
    
    
    [dateBirthSheet addSubview:toolBar];
    [dateBirthSheet showInView:self.view];
    [dateBirthSheet setBounds:CGRectMake(0, 0, 320, 490)];
    
}

-(void) createDatePicker{
    dateSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [dateSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,44,0,0)];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[NSDate date] animated:YES];
    
    [dateSheet addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,dateBirthSheet.bounds.size.width,44)];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [toolBar sizeToFit];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *selectButton = [[UIBarButtonItem alloc]initWithTitle:@"Select" style:UIBarButtonItemStyleBordered target:self action:@selector(dateSelected)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dateCancelled)];
    
    [toolBar setItems:[NSArray arrayWithObjects:space,selectButton,cancelButton, nil] animated:NO];
    
    [dateSheet addSubview:toolBar];
    [dateSheet showInView:self.view];
    [dateSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
}

-(void) dateSelected{
    
    NSLog(@"Selecionou a data...");
    
    Assessment *assessment = [Assessment current];
    
    NSArray *listOfview = [dateSheet subviews];
    for (UIView *subview in listOfview) {
        if([subview isKindOfClass:[UIDatePicker class]]){
            [assessment setDate:[(UIDatePicker *)subview date]];
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSLog(@"%@",[formatter stringFromDate:[assessment date]]);
    
    [dateTextField setText:[formatter stringFromDate:[assessment date]]];
    
    [self dateCancelled];
    
}

-(void) dateBirthSelected{
    
    NSLog(@"Selecionou a data birthday...");
    
    Assessment *assessment = [Assessment current];
    
    NSArray *listOfview = [dateBirthSheet subviews];
    for (UIView *subview in listOfview) {
        if([subview isKindOfClass:[UIDatePicker class]]){
            [assessment setBirthday:[(UIDatePicker *)subview date]];
        }
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSLog(@"%@",[formatter stringFromDate:[assessment birthday]]);
    
    [dateBirthTextField setText:[formatter stringFromDate:[assessment birthday]]];
    
    [self dateCancelled];
    
}

-(void) dateCancelled{
    if(dateBirthSheet){
        [dateBirthSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    if(dateSheet){
        [dateSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
}


- (IBAction)exit:(id)sender {
    for (UIViewController *view in [self.navigationController viewControllers]) {
        [view dismissViewControllerAnimated:false completion:nil];
    }
}
@end
