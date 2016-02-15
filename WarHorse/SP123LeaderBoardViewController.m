//
//  SP123LeaderBoardViewController.m
//  WarHorse
//
//  Created by APPLE on 04/02/16.
//  Copyright © 2016 Zytrix Labs. All rights reserved.
//

#import "SP123LeaderBoardViewController.h"

@interface SP123LeaderBoardViewController ()

@end

@implementation SP123LeaderBoardViewController
@synthesize leadersboard_URL;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",leadersboard_URL);

    NSURL *websiteUrl = [NSURL URLWithString:leadersboard_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webview loadRequest:urlRequest];
    
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

- (IBAction)homeBtnClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];


}
@end
