//
//  VolleyDephViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 21/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolleyDephViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) IBOutlet UITableView *table;
@property (assign, nonatomic) IBOutlet UILabel *total;
@property (assign, nonatomic) IBOutlet UILabel *subtotal;
@property (assign, nonatomic) IBOutlet UILabel *consistency;
- (IBAction)exit:(id)sender;

@end
