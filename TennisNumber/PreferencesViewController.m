//
//  PreferencesViewController.m
//  TennisNumber
//
//  Created by Robson Saraiva Ximenes on 14/01/13.
//  Copyright (c) 2013 RSX. All rights reserved.
//

#import "PreferencesViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PreferencesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:@"Sound enabled"];
    
    UISwitch *soundSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [soundSwitch addTarget:self action:@selector(soundValueChanged:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = soundSwitch;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [soundSwitch setOn:[defaults boolForKey:DEFAULTS_SOUND_ENEBLED]];
    
    return cell;
}

-(void) soundValueChanged:(UISwitch *)paramSender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:[paramSender isOn] forKey:DEFAULTS_SOUND_ENEBLED];
    [defaults synchronize];
}




@end
