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
    
    dateTextField.text = [self stringFormatedForDateTime:[[NSDate alloc] init]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    assessortextField.text= [defaults valueForKey:@"assessor"];
    venueTextField.text= [defaults valueForKey:@"vennue"];
    
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:a.local forKey:@"vennue"];
    [defaults setValue:a.assessor forKey:@"assessor"];
    [defaults synchronize];
    
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
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker setDate:[NSDate date] animated:YES];
    
    [dateSheet addSubview:datePicker];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,dateSheet.bounds.size.width,44)];
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

-(NSString *) stringFormatedForDate: (NSDate *)date{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM/dd/yyyy"];
//    return [formatter stringFromDate:date];
    
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterMediumStyle
                                          timeStyle:NSDateFormatterNoStyle];

    
}

-(NSString *) stringFormatedForDateTime: (NSDate *)date{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"MM/dd/yyyy HH:mm"];
//    return [formatter stringFromDate:date];
    return [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterMediumStyle
                                          timeStyle:NSDateFormatterShortStyle];

}

-(void) dateSelected{
    Assessment *assessment = [Assessment current];
    NSArray *listOfview = [dateSheet subviews];
    for (UIView *subview in listOfview) {
        if([subview isKindOfClass:[UIDatePicker class]]){
            [assessment setDate:[(UIDatePicker *)subview date]];
        }
    }
    [dateTextField setText:[self stringFormatedForDateTime:[assessment date]]];
    [self dateCancelled];
}

-(void) dateBirthSelected{
    Assessment *assessment = [Assessment current];
    NSArray *listOfview = [dateBirthSheet subviews];
    for (UIView *subview in listOfview) {
        if([subview isKindOfClass:[UIDatePicker class]]){
            [assessment setBirthday:[(UIDatePicker *)subview date]];
        }
    }
    [dateBirthTextField setText:[self stringFormatedForDate:[assessment birthday]]];
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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    //If you add a bit to x and decrease y, it will be more in line with the tableView cell (that is in iPad and landscape)
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.5, 0.5);
    label.font = [UIFont boldSystemFontOfSize:18];
    label.text = sectionTitle;
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,30)];
    [view addSubview:label];
    
    return view;
}

@end
