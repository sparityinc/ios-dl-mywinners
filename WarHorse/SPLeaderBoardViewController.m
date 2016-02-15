//
//  SPLeaderBoardViewController.m
//  WarHorse
//
//  Created by APPLE on 08/02/16.
//  Copyright © 2016 Zytrix Labs. All rights reserved.
//

#import "SPLeaderBoardViewController.h"
#import "ZLAppDelegate.h"
#import "WarHorseSingleton.h"
#import "LeveyHUD.h"
#import "ZLAPIWrapper.h"

@interface SPLeaderBoardViewController ()

@end

@implementation SPLeaderBoardViewController
@synthesize leadersboard_URL;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self prepareTopView];
    [self nickNameService];

    NSURL *websiteUrl = [NSURL URLWithString:leadersboard_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];


}
- (void) prepareTopView
{
    
    [self.toggleBtn addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleLabel setText:@"123 LeaderBoard"];
    [self.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:15]];
    
    
    [self.amountBtn setTitle:[NSString stringWithFormat:@"BALANCE: \n$%0.2f",[ZLAppDelegate getAppData].balanceAmount] forState:UIControlStateSelected];
    [self.amountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.amountBtn.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:14]];
    
}
- (void)balanceUpdated:(NSNotification *)notification{
    
    [self.amountBtn setTitle:[NSString stringWithFormat:@"BALANCE: \n $%0.2f",[ZLAppDelegate getAppData].balanceAmount] forState:UIControlStateSelected];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)amountBtnClicked:(id)sender {
    CGRect rect = ((UIButton *)sender).frame;
    
    if ([self.amountBtn isSelected])
    {
        [self.amountBtn setSelected:NO];
        
        rect.origin.x += 30;
        rect.size.width -= 30;
        [self.amountBtn setFrame:rect];
        
    }
    else{
        [self.amountBtn setTitle:[NSString stringWithFormat:@"Loading.."] forState:UIControlStateSelected];
        
        if (![[WarHorseSingleton sharedInstance] isInternetConnectionAvailable]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:Aleart_Title message:@"Unable to connect to the server, please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        [[ZLAppDelegate getApiWrapper] refreshBalance:YES success:^(NSDictionary* _userInfo){
            [self.amountBtn setTitle:[NSString stringWithFormat:@"BALANCE: \n$%0.2f",[ZLAppDelegate getAppData].balanceAmount] forState:UIControlStateSelected];
        }failure:^(NSError *error){
        }];
        [self.amountBtn setSelected:YES];
        
        rect.origin.x -= 30;
        rect.size.width += 30;
        [self.amountBtn setFrame:rect];
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerMethod:) userInfo:nil repeats:NO];
    }
}

- (void)timerMethod:(NSTimer *)timer
{
    if ([self.amountBtn isSelected]) {
        [self.amountBtn setSelected:NO];
        [self.amountBtn setFrame:CGRectMake(272, 17, 45, 45)];
    }
}
- (IBAction)wagerButtonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:DashBoardWager]forKey:@"viewNumber"]];
    
}
#pragma mark - Private API

- (IBAction)goToHome:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:DashBoardHome]forKey:@"viewNumber"]];
}

- (IBAction)goToMyBets:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:DashBoardMyBets]forKey:@"viewNumber"]];
}
-(void)nickNameService{
    if (![[WarHorseSingleton sharedInstance] isInternetConnectionAvailable]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:Aleart_Title message:@"Unable to connect to the server, please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    if([[WarHorseSingleton sharedInstance] is_nick_name_enabled] == YES)
        
    {
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@ :",[[WarHorseSingleton sharedInstance] nick_name_label]];
    ZLAPIWrapper *apiWrapper = [ZLAppDelegate getApiWrapper];
    [[LeveyHUD sharedHUD] appearWithText:@"AppConfig Loading..."];
    [apiWrapper nickNameinfo:nil success:^(NSDictionary *nickInfo){
        NSDictionary *nickNmeDic= nickInfo;
        NSString *succesMesStr = [nickInfo valueForKey:@"response-status"];
        if ([succesMesStr isEqualToString:@"success"]){
            [[LeveyHUD sharedHUD] disappear];
            
            self.NickNameLbl.text = [NSString stringWithFormat:@"%@",[[nickNmeDic valueForKey:@"response-content"]valueForKey:@"nickName"]];
            
         
        }
    }failure:^(NSError *error){
              [[LeveyHUD sharedHUD] disappear];
        
    }];
    
    }
}




@end
