//
//  ContentViewController.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 26/12/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSString *content;

@end
