//
//  ZLPoolPayoutsTableViewCell.h
//  WarHorse
//
//  Created by APPLE on 09/02/16.
//  Copyright © 2016 Zytrix Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTrackResults.h"

@interface ZLPoolPayoutsTableViewCell : UITableViewCell
@property (nonatomic, strong) ZLTrackResults *trackResult;
- (void)updateViewAtIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) IBOutlet UILabel *amountLbl;

@property (strong, nonatomic) IBOutlet UILabel *positionLbl;
@property (strong, nonatomic) IBOutlet UILabel *pointsLbl;
@property (strong, nonatomic) IBOutlet UILabel *paidLbl;

@end
