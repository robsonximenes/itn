//
//  GSAccuracyViewController.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSAccuracyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) IBOutlet UITableView *table;
@property (assign, nonatomic) IBOutlet UILabel *subtotal;
@property (assign, nonatomic) IBOutlet UILabel *consistency;
@property (assign, nonatomic) IBOutlet UILabel *total;
@property (assign, nonatomic) IBOutlet UIView *resultContentView;
- (IBAction)exit:(id)sender;

@end
