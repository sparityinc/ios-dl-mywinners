//
//  SP123LeaderBoardViewController.h
//  WarHorse
//
//  Created by APPLE on 04/02/16.
//  Copyright © 2016 Zytrix Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SP123LeaderBoardViewController : UIViewController
@property (nonatomic, strong) NSString *leadersboard_URL;
@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)homeBtnClicked:(id)sender;

@end
