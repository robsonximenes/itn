//
//  GuideViewController.m
//  What's your number?
//
//  Created by Robson Ximenes on 22/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()
@property NSArray *topicos;
@end

@implementation GuideViewController

@synthesize topicos;

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
    
    topicos = [NSArray arrayWithObjects:@"Introduction",
                                        @"Resources and equipment",
                                        @"Overall rules",
                                        @"Set up",
                                        @"Ground stroke deph",
                                        @"Volley deph",
                                        @"Ground strok accuracy",
                                        @"Server",
                                        @"Mobility",
                                        @"ITN correlation table"
                                        , nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [topicos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"GuideCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[topicos objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (IBAction)exit:(id)sender {
    for (UIViewController *view in [self.navigationController viewControllers]) {
        [view dismissViewControllerAnimated:false completion:nil];
    }
}

@end
