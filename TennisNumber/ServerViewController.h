//
//  ServerViewController.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) IBOutlet UIView *resultView;
@property (assign, nonatomic) IBOutlet UILabel *subtotal;
@property (assign, nonatomic) IBOutlet UILabel *consistency;
@property (assign, nonatomic) IBOutlet UILabel *total;
@property (assign, nonatomic) IBOutlet UITableView *table;

- (IBAction)exit:(id)sender;

@end
