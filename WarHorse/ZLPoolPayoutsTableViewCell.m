//
//  ZLPoolPayoutsTableViewCell.m
//  WarHorse
//
//  Created by APPLE on 09/02/16.
//  Copyright © 2016 Zytrix Labs. All rights reserved.
//

#import "ZLPoolPayoutsTableViewCell.h"
#import "ZLPoolPayouts.h"
@implementation ZLPoolPayoutsTableViewCell
@synthesize trackResult;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateViewAtIndexPath:(NSIndexPath *)indexPath
{
    ZLPoolPayouts * poolPayOuts = [trackResult.PayOuts123 objectAtIndex:indexPath.row];
    if( poolPayOuts ){
        self.amountLbl.text = [NSString stringWithFormat:@"$%@",poolPayOuts.Amount];
        self.positionLbl.text = [NSString stringWithFormat:@"%@",poolPayOuts.Position];
        self.pointsLbl.text = [NSString stringWithFormat:@"%@",poolPayOuts.Points];
        self.paidLbl.text = [NSString stringWithFormat:@"$%@",poolPayOuts.Paid];
        [self.amountLbl setFont:[UIFont fontWithName:@"Roboto-Medium" size:13]];
        [self.pointsLbl setFont:[UIFont fontWithName:@"Roboto-Medium" size:13]];
        [self.pointsLbl setFont:[UIFont fontWithName:@"Roboto-Medium" size:13]];
        [self.paidLbl setFont:[UIFont fontWithName:@"Roboto-Medium" size:13]];
        


//        [self.titleLabel setFrame:CGRectMake(6, 2.5, 255, 20)];
//        self.titleLabel.text = [NSString stringWithFormat:@"%d",poolPayOuts.Amount];//scratcher.horseName;
//        [self.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:12]];
//        [self.separatorLineImage setFrame:CGRectMake(6, 24, 298, 1)];
//        self.numberLabel.hidden = YES;
    }

}
@end
