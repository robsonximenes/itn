//
//  HomeViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 21/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) IBOutlet UITableView *table;

@end
