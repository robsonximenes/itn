//
//  HomeCell.h
//  What's your number?
//
//  Created by Robson Saraiva Ximenes on 21/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell

@property (assign, nonatomic) IBOutlet UILabel *name;
@property (assign, nonatomic) IBOutlet UILabel *itnNumber;
@property (assign, nonatomic) IBOutlet UILabel *detailedScore;
@property (assign, nonatomic) IBOutlet UILabel *venue;
@property (assign, nonatomic) IBOutlet UILabel *date;
@end
