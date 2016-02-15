//
//  SPLeaderBoardViewController.h
//  WarHorse
//
//  Created by APPLE on 08/02/16.
//  Copyright © 2016 Zytrix Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLeaderBoardViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *toggleBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *amountBtn;
- (IBAction)amountBtnClicked:(id)sender;
- (IBAction)wagerButtonClicked:(id)sender;
- (IBAction)goToHome:(id)sender;
- (IBAction)goToMyBets:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString *leadersboard_URL;

@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *NickNameLbl;

@end
