//
//  ScoreViewController.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 18/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@interface ScoreViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate>



- (IBAction)save:(id)sender;

- (IBAction)send:(id)sender;

@end
