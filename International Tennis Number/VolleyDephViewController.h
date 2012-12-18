//
//  VolleyDephViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 21/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolleyDephViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *subtotal;
@property (weak, nonatomic) IBOutlet UILabel *consistency;
- (IBAction)exit:(id)sender;

@end
