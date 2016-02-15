//
//  SPSettingsViewController.m
//  WarHorse
//
//  Created by PVnarasimham on 11/10/13.
//  Copyright (c) 2013 Zytrix Labs. All rights reserved.
//

#import "SPSettingsViewController.h"

@interface SPSettingsViewController ()

@property (nonatomic, strong) IBOutlet UINavigationController *resultsNavigationController;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *toggleButton;

@end

@implementation SPSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View LifeCycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;

    [self prepareTopView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private API

- (void) prepareTopView
{
    
    [self.toggleButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleLabel setText:@"Settings"];
    [self.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:15]];
    
}

- (IBAction)wagerButtonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:DashBoardWager]forKey:@"viewNumber"]];
    
}


@end
