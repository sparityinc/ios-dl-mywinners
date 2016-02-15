//
//  ZLTileComponentViewController.m
//  WarHorse
//
//  Created by Sparity on 7/9/13.
//  Copyright (c) 2013 Sparity. All rights reserved.
//

#import "ZLRunnersViewController.h"
#import "ZLRunners_CustomCell.h"
#import "ZLOddsBoardViewController.h"
#import "ZLAppDelegate.h"
#import "ZLAppData.h"
#import "ZLBetType.h"
#import "ZLRaceCard.h"
#import "ZLRunner.h"
#import "ZLWager.h"

#define SMALL_BOTTOM_VIEW_HEIGHT 46
#define BIG_BOTTOM_VIEW_HEIGHT  220
#define NUMBER_TO_INCREASE_HEIGHT 20
#define NUMBER_TO_INCREASE_CELL (([[UIScreen mainScreen] bounds].size.height-568)?9:12)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define kcustomRunnersViewCellIdentifier @"customRunnersViewCellIdentifier"

@interface ZLRunnersViewController ()
{
    NSInteger numberOfTotalLines;
    CGFloat changeInHeight;

}
@property (strong, nonatomic) UINib *customRunnersViewCellNib;

@property (strong, nonatomic) UILabel * lblWagerOn;

@property (strong, nonatomic) NSMutableArray * runnerColors;

@property (assign, nonatomic) BOOL isLeftSwipe;

@property (assign, nonatomic) BOOL isRightSwipe;

@property (assign, nonatomic) long int previousLeg;

@property (nonatomic, assign) BOOL isMultiBetRunnerSelected;
@property (strong, nonatomic) IBOutlet UIButton *checkboxButton;
@property (nonatomic, assign)BOOL checkboxSelected;
@property (nonatomic, assign)BOOL isSelected;


- (IBAction)selctAllClicked:(id)sender;

@end


@implementation ZLRunnersViewController


@synthesize numbers_Array=_numbers_Array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.runnerColors =[[NSMutableArray alloc]initWithObjects:@{@"bg":[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO},//1
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor blackColor],@"isSelected" :@NO},//2
                              @{@"bg":[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0],@"text":[UIColor whiteColor],@"isSelected" :@NO},//3
                              @{@"bg":[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO},//4
                              @{@"bg":[UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor whiteColor],@"isSelected" :@NO},//5
                              @{@"bg":[UIColor blackColor],@"text":[UIColor colorWithRed:255.0/255.0 green:215.0/255.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},//6
                              @{@"bg":[UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO},//7
                              @{@"bg":[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO},//8
                              @{@"bg":[UIColor colorWithRed:51.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO},//9
                              @{@"bg":[UIColor colorWithRed:153.0/255.0 green:0.0/255.0 blue:153.0/255.0 alpha:1.0],@"text":[UIColor whiteColor],@"isSelected" :@NO},//10
                              @{@"bg":[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0],@"text":[UIColor colorWithRed:128.0/225.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},//11
                              @{@"bg":[UIColor colorWithRed:0.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO}, //12
                              @{@"bg":[UIColor colorWithRed:153.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0],@"text":[UIColor whiteColor],@"isSelected" :@NO},//13
                              @{@"bg":[UIColor colorWithRed:153.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor colorWithRed:0.0/225.0 green:255/255.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO}, //14
                              @{@"bg":[UIColor colorWithRed:240.0/255.0 green:230.0/255.0 blue:140.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO},//15
                              @{@"bg":[UIColor colorWithRed:65.0/255.0 green:105.0/255.0 blue:225.0/255.0 alpha:1.0],@"text":[UIColor colorWithRed:255.0/225.0 green:215/255.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},//16
                              @{@"bg":[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:128.0/255.0 alpha:1.0],@"text":[UIColor whiteColor],@"isSelected" :@NO}, //17
                              @{@"bg":[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO}, //18
                              @{@"bg":[UIColor colorWithRed:70.0/255.0 green:130.0/255.0 blue:180.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO}, //19
                              @{@"bg":[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0],@"text":[UIColor blackColor],@"isSelected" :@NO}, //20
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO},
                              @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected" :@NO}, nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    numberOfTotalLines = 1;
    
    [self.sideMenuButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tile_CollectionView registerClass:[ZLRunners_CustomCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    
    _numbers_Array=[[NSMutableArray alloc]init];
    [self loadData];

//    NSString *selectedBetType = [ZLAppDelegate getAppData].currentWager.selectedBetType;
    CGRect rect = CGRectMake(5, self.navigationController.view.frame.size.height - 80, 226, 32.5);
    
    int num_legs = 1;
    ZLBetType* betType = nil;
    ZLRaceCard *_race_card = [ZLRaceCard findRaceCardByMeetNumber:[ZLAppDelegate getAppData].currentWager.selectedRaceMeetNumber AndPerformanceNumber:[ZLAppDelegate getAppData].currentWager.selectedRacePerformanceNumber];
    if(_race_card){
        
        if(![_race_card.breedType isEqualToString:@"TB"])
        {
            self.runnerColors = [[NSMutableArray alloc]initWithObjects:@{@"bg":[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:56.0/255.0 alpha:1.0],@"text":[UIColor blackColor]},//1
                                  @{@"bg":[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0],@"text":[UIColor whiteColor]},//2
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor blackColor]},//3
                                  @{@"bg":[UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor whiteColor]},//4
                                  @{@"bg":[UIColor blackColor],@"text":[UIColor whiteColor]},//5
                                  @{@"bg":[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor blackColor]},//6
                                  @{@"bg":[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0],@"text":[UIColor blackColor]},//7
                                  @{@"bg":[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0],@"text":[UIColor whiteColor]},//8
                                  @{@"bg":[UIColor colorWithRed:153.0/255.0 green:0.0/255.0 blue:153.0/255.0 alpha:1.0],@"text":[UIColor whiteColor]},//9
                                  @{@"bg":[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:1.0],@"text":[UIColor whiteColor]},//10
                                  @{@"bg":[UIColor colorWithRed:173.0/255.0 green:216.0/255.0 blue:230.0/255.0 alpha:1.0],@"text":[UIColor blackColor]},//11
                                  @{@"bg":[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],@"text":[UIColor blackColor]}, //12
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},//13
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]},
                                  @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]}
                                  , nil];
        }
        
        ZLRaceDetails * _race_details = [_race_card findRaceDeatilsByRaceId:[ZLAppDelegate getAppData].currentWager.selectedRaceId];
        if(_race_details){
            betType = [_race_details findBetTypeWithName:[ZLAppDelegate getAppData].currentWager.selectedBetType];
            num_legs = betType.numLegs;
            /*
            //Post time set
            if (_race_card.raceTime == nil){
                
                [self.postTimeLabel setText:[NSString stringWithFormat:@"Post Time: 0.00"]];
            }else{
                
                NSString *postTime = [NSString stringWithFormat:@"Post Time: %@",_race_card.raceTime];
                [self.postTimeLabel setText:postTime];
            }
             */
//            CGSize maximumLabelSize = CGSizeMake(320, FLT_MAX);
            
            //CGSize expectedLabelSize = [self.postTimeLabel.text sizeWithFont:self.postTimeLabel.font constrainedToSize:maximumLabelSize lineBreakMode:self.postTimeLabel.lineBreakMode];
            
            //adjust the label the the new height.
//            CGRect newFrame = self.postTimeLabel.frame;
            //newFrame.origin.x = (self.belowResultsView.frame.size.width-expectedLabelSize.width+4)/2;//+4 is the show last charecter
            //newFrame.size.width = expectedLabelSize.width + 4;
            //self.postTimeLabel.frame = newFrame;
            
            
                     
            [self.raceNumberLabel setText:_race_card.ticketName];
            
            [self.furlongsLabel setText:_race_card.distance];
            [self.weatherLabel setText:_race_card.trackType];
            if( _race_details.purseUsa != nil || [_race_details.purseUsa length] > 0){
                [self.amoutLabel setText:[NSString stringWithFormat:@"Purse $%@",_race_details.purseUsa]];
            }
            else{
                [self.amoutLabel setText:@""];
            }
            [self.betTypeLabel setText:betType.name];
            [self.wagerLabel setText:@"$0 WAGER ON"];
            [self.runnersLabel setText:@""];
        }
    }
    
    NSMutableDictionary * dictLegs = [ZLAppDelegate getAppData].currentWager.selectedRunners;
    for(int i=0;i<num_legs;i++){
        NSMutableArray *currentLegArray = [dictLegs valueForKey:[NSString stringWithFormat:@"%d", i]];
        if(currentLegArray == nil){
            currentLegArray = [NSMutableArray array];
            [dictLegs setValue:currentLegArray forKey:[NSString stringWithFormat:@"%d", i]];
        }
    }
    if( [betType.typeID isEqualToString:@"EBX"] || [betType.typeID isEqualToString:@"TBX"] || [betType.typeID isEqualToString:@"SFX"]){
        num_legs = 1;
    }
    if( num_legs > 1){
        
        UISwipeGestureRecognizer *swipeLeft;
        swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Gest_SwipedLeft:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.tile_CollectionView addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight;
        swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Gest_SwipedRight:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.tile_CollectionView addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeLeftTable;
        swipeLeftTable = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Gest_SwipedLeft:)];
        [swipeLeftTable setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.runnersTableView addGestureRecognizer:swipeLeftTable];
        
        UISwipeGestureRecognizer *swipeRightTable;
        swipeRightTable = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(Gest_SwipedRight:)];
        [swipeRightTable setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.runnersTableView addGestureRecognizer:swipeRightTable];
        
        if( [betType.typeID isEqualToString:(@"DBL")] || [betType.typeID isEqualToString:(@"PK3")] || [betType.typeID isEqualToString:(@"PK4")] || [betType.typeID isEqualToString:(@"PK5")] || [betType.typeID isEqualToString:(@"PK6")] || [betType.typeID isEqualToString:(@"PK7")] || [betType.typeID isEqualToString:(@"PK8")] || [betType.typeID isEqualToString:(@"PK9")] || [betType.typeID isEqualToString:(@"P10")] || [betType.typeID isEqualToString:(@"OTT")] ) {
            
            self.isMultiBetRunnerSelected = YES;
        }
        else {
            self.isMultiBetRunnerSelected = NO;
        }
        
        self.legSelection = [[AKLegSelection alloc] initWithFrame:rect totalnumberOfLegs:num_legs legsPerPage:10 currentRace:[ZLAppDelegate getAppData].currentWager.selectedRaceId delegate:self isMultiBetSelected:self.isMultiBetRunnerSelected];
        
        [self.legSelection setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
        [self.view addSubview:self.legSelection];
    }

    [self changeNumberOfItems];

    [self handleUIItems];
    
    [_bottomView bringSubviewToFront:_wagerOnImageView];
    
    [_selectedValuesLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [_selectedValuesLabel setBackgroundColor:[UIColor clearColor]];
    [_selectedValuesLabel setNumberOfLines:10];
    [_selectedValuesLabel sizeToFit];
    
    self.customRunnersViewCellNib = [UINib nibWithNibName:@"ZLRunnersViewCell" bundle:nil];
    [self.runnersTableView registerNib:self.customRunnersViewCellNib forCellReuseIdentifier:kcustomRunnersViewCellIdentifier];

    self.lblWagerOn =[[UILabel alloc] initWithFrame:CGRectMake(15, 1, 70, 20)];
    [self.lblWagerOn setContentMode:UIViewContentModeScaleAspectFit];
    [self.lblWagerOn setText:[NSString stringWithFormat:@"$0.00 WAGER ON"]];
    [self.lblWagerOn setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:8]];
    [self.lblWagerOn setTextColor:[UIColor blackColor]];
    [self.lblWagerOn setBackgroundColor:[UIColor clearColor]];
    [self.wagerOnImageView addSubview:self.lblWagerOn];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"HandleTopRightButtons" object:self userInfo:nil];
}

- (void) handleUIItems
{
    [self.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [self.boxButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [self.withButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [self.allButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [self.clearButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    
    [self.raceNumberLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    //[self.postTimeLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:10]];
    [self.furlongsLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:11]];
    [self.weatherLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:11]];
    [self.amoutLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:11]];
    [self.betTypeLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:11]];
    [self.wagerLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [self.runnersLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    
    
    if (self.numberOfItems < 20) {
        [_titleLabel setFrame:CGRectMake(10, 10, 95, 21)];
        [_separatorLine setFrame:CGRectMake(0, 41, 320, 1)];
        [_oddsButton setFrame:CGRectMake(156, 0, 41, 41)];
        [_listButton setFrame:CGRectMake(197, 0, 41, 41)];
        [_settingsButton setFrame:CGRectMake(195, 0, 41, 41)];
               
        [_settingsButton setImage:[UIImage imageNamed:@"settingsicon_new"] forState:UIControlStateNormal];
        [_oddsButton setImage:[UIImage imageNamed:@"odds"] forState:UIControlStateNormal];
        [_listButton setImage:[UIImage imageNamed:@"listicon"] forState:UIControlStateNormal];
        [_listButton setImage:[UIImage imageNamed:@"GridIcon"] forState:UIControlStateSelected];
        
        [_tile_CollectionView setFrame:CGRectMake(_tile_CollectionView.frame.origin.x, _tile_CollectionView.frame.origin.y + 14, _tile_CollectionView.frame.size.width, _tile_CollectionView.frame.size.height - 14)];
        [self.runnersTableView setFrame:CGRectMake(self.runnersTableView.frame.origin.x, self.runnersTableView.frame.origin.y + 14, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height - 30)];
    }
    
    
    CGRect bottoViewFrame;
    
    if (IS_IPHONE5) {
        bottoViewFrame = CGRectMake(5, self.navigationController.view.frame.size.height - 73.0, 228, 46);
    }
    else
    {
        bottoViewFrame = CGRectMake(5, self.navigationController.view.frame.size.height + 17.0, 228, 46);
    }
    
    [_bottomView setFrame:bottoViewFrame];
    
    [self.view addSubview:self.bottomView];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void) loadData{
    
    ZLRaceCard *_race_card = [ZLRaceCard findRaceCardByMeetNumber:[ZLAppDelegate getAppData].currentWager.selectedRaceMeetNumber AndPerformanceNumber:[ZLAppDelegate getAppData].currentWager.selectedRacePerformanceNumber];
    if(_race_card){
        ZLRaceDetails * _race_details = [_race_card findRaceDeatilsByRaceId:[ZLAppDelegate getAppData].currentWager.selectedRaceId];
        if(_race_details){
            self.numbers_Array = [_race_details.runners allObjects];
        }
    }
}

-(void) refreshRunnersFromServer{
    
    [self changeNumberOfItems];
    
}


- (void) handleHeightOfGridOrTableView
{
    if (!IS_IPHONE5) {
        if (self.numberOfItems > NUMBER_TO_INCREASE_HEIGHT) {
            [self.navigationController.view setFrame:CGRectMake(0, 0, self.navigationController.view.frame.size.width, 460)];
            
            self.legSelection.frame = CGRectMake(self.legSelection.frame.origin.x, self.navigationController.view.frame.size.height - 77, self.legSelection.frame.size.width, self.legSelection.frame.size.height);
            self.sideMenuButton.hidden = NO;
            CGRect rect = self.titleLabel.frame;
            rect.origin.x = 37.5;
            self.titleLabel.frame = rect;
        }
        else{
            //[self.navigationController.view setFrame:CGRectMake(0, 64, self.navigationController.view.frame.size.width, 460 - 64)];
            self.legSelection.frame = CGRectMake(self.legSelection.frame.origin.x, self.navigationController.view.frame.size.height - 77, self.legSelection.frame.size.width, self.legSelection.frame.size.height);
            self.sideMenuButton.hidden = YES;
            
            CGRect rect = self.titleLabel.frame;
            rect.origin.x = 8;
            self.titleLabel.frame = rect;
        }

    }
}

- (IBAction)sideMenuButtonClicked:(id)sender
{
    
}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
//    if (self.numbers_Array.count > NUMBER_TO_INCREASE_HEIGHT)
//    {
//        [self.navigationController.view setFrame:CGRectMake(0, 46, self.navigationController.view.frame.size.width, self.view.frame.size.height - 46)];
//    }
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"HandleTopRightButtons" object:self userInfo:nil];
}

- (NSUInteger) totalNumberOfLegs
{
    return 20;
}
- (NSUInteger) numberOfLegsInPage
{
    return 10;
}


-(void)Gest_SwipedLeft:(UISwipeGestureRecognizer *) sender
{
    if( sender.view == self.bottomView ){
        return;
    }
    
    if (self.legSelection.currentLeg == self.legSelection.totalLegs - 1) {
        return;
    }
    
    if (self.legSelection.currentLeg < self.legSelection.totalLegs)
    {
        self.legSelection.currentLeg =  self.legSelection.currentLeg + 1;
        self.isLeftSwipe = YES;
    }
    
    [self changeNumberOfItems];

}

-(void)Gest_SwipedRight:(UISwipeGestureRecognizer *) sender
{
    if( sender.view == self.bottomView ){
        return;
    }
    if (self.legSelection.currentLeg == 0) {
        return;
    }

    if (self.legSelection.currentLeg > 0)
    {
        self.legSelection.currentLeg =  self.legSelection.currentLeg - 1;
        self.isRightSwipe = YES;
    }
    
    [self changeNumberOfItems];
}

#pragma mark - LegSelectionDelegates -
- (void) moveRightToLegSelection:(id)LegSelection didSelect:(long int)selectedLeg
{
    //NSLog(@"%s move leg = %lu", __FUNCTION__, (unsigned long)self.legSelection.currentLeg);

    if (selectedLeg < self.previousLeg)
    {
        self.isRightSwipe = YES;
        
    }
    else if (selectedLeg > self.previousLeg)
    {
        self.isLeftSwipe = YES;
        
    }
    
    self.previousLeg = selectedLeg;
    
    [self changeNumberOfItems];

}
- (void) moveLefttToLegSelection:(id)LegSelection didSelect:(long int)selectedLeg
{
    
    if (selectedLeg < self.previousLeg)
    {
        self.isRightSwipe = YES;
        
    }
    else if (selectedLeg > self.previousLeg)
    {
        self.isLeftSwipe = YES;
        
    }
    
    self.previousLeg = selectedLeg;
    
    [self changeNumberOfItems];

}

- (void) LegSelection:(id)LegSelection didSelect:(long int)selectedLeg
{

//    if (self.previousLeg == 0) {
//        return;
//    }
//
//    if (self.previousLeg == self.legSelection.totalLegs - 1) {
//        return;
//    }
    

    if (self.legSelection.currentLeg < self.previousLeg)
    {
        self.isRightSwipe = YES;

    }
    else if (self.legSelection.currentLeg > self.previousLeg)
    {
        self.isLeftSwipe = YES;

    }

    self.previousLeg = self.legSelection.currentLeg;
    
    [self changeNumberOfItems];
}

- (void) changeNumberOfItems
{
    NSString * selectedBetType = [ZLAppDelegate getAppData].currentWager.selectedBetType;
    if( [selectedBetType isEqualToString:@"PK3"] || [selectedBetType isEqualToString:@"PK4"] || [selectedBetType isEqualToString:@"PK5"] || [selectedBetType isEqualToString:@"PK6"]|| [selectedBetType isEqualToString:@"PK7"] || [selectedBetType isEqualToString:@"PK8"] || [selectedBetType isEqualToString:@"PK9"] || [selectedBetType isEqualToString:@"P10"] || [selectedBetType isEqualToString:@"DD"] || [selectedBetType isEqualToString:@"DBL"]){

        ZLRaceCard *_race_card = [ZLRaceCard findRaceCardByMeetNumber:[ZLAppDelegate getAppData].currentWager.selectedRaceMeetNumber AndPerformanceNumber:[ZLAppDelegate getAppData].currentWager.selectedRacePerformanceNumber];
        if(_race_card){
            ZLRaceDetails * _race_details = [_race_card findRaceDeatilsByRaceId:[ZLAppDelegate getAppData].currentWager.selectedRaceId + self.legSelection.currentLeg];
            if(_race_details){
                self.numbers_Array = [_race_details.runners allObjects];
            }
        }
    }
    else{
        [self loadData];
    }
    
    self.numberOfItems = [self.numbers_Array count];
    [self reloadViews];
    [self handleHeightOfGridOrTableView];
}

- (void) reloadViews
{
    if (self.runnersTableView.hidden)
    {
        if (self.isLeftSwipe) {
            self.isLeftSwipe = NO;
            
            UIView *renderedView = self.tile_CollectionView;
            CGPoint tableContentOffset = self.tile_CollectionView.contentOffset;
            UIGraphicsBeginImageContextWithOptions(renderedView.bounds.size, renderedView.opaque, 0.0);
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(contextRef, 0, -tableContentOffset.y);
            [self.tile_CollectionView.layer renderInContext:contextRef];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height - 30.0)];
            iv.clipsToBounds = YES;
            iv.contentMode = UIViewContentModeTop;
            iv.image = image;
            [self.view addSubview:iv];
            self.tile_CollectionView.frame = CGRectMake(self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height);
            [UIView transitionWithView:self.tile_CollectionView duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                iv.frame = CGRectMake(-self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height);
                [self.tile_CollectionView reloadData];
                self.tile_CollectionView.frame = CGRectMake(0, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height);
                
            } completion:^(BOOL finished){
                [iv removeFromSuperview];
            }];
        }
        else if (self.isRightSwipe) {
            self.isRightSwipe = NO;
            
            UIView *renderedView = self.tile_CollectionView;
            CGPoint tableContentOffset = self.tile_CollectionView.contentOffset;
            UIGraphicsBeginImageContextWithOptions(renderedView.bounds.size, renderedView.opaque, 0.0);
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(contextRef, 0, -tableContentOffset.y);
            [self.tile_CollectionView.layer renderInContext:contextRef];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height - 30.0)];
            iv.clipsToBounds = YES;
            iv.contentMode = UIViewContentModeTop;
            iv.image = image;
            [self.view addSubview:iv];
            self.tile_CollectionView.frame = CGRectMake(-self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height);
            [UIView transitionWithView:self.tile_CollectionView duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                iv.frame = CGRectMake(self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height);
                [self.tile_CollectionView reloadData];
                self.tile_CollectionView.frame = CGRectMake(0, self.tile_CollectionView.frame.origin.y, self.tile_CollectionView.frame.size.width, self.tile_CollectionView.frame.size.height);
                
            } completion:^(BOOL finished){
                [iv removeFromSuperview];
            }];

        }
    }
    else
    {
        
        if (self.isLeftSwipe) {
            self.isLeftSwipe = NO;
            
            UIView *renderedView = self.runnersTableView;
            CGPoint tableContentOffset = self.runnersTableView.contentOffset;
            UIGraphicsBeginImageContextWithOptions(renderedView.bounds.size, renderedView.opaque, 0.0);
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(contextRef, 0, -tableContentOffset.y);
            [self.runnersTableView.layer renderInContext:contextRef];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height)];
            iv.clipsToBounds = YES;
            iv.contentMode = UIViewContentModeTop;
            iv.image = image;
            [self.view addSubview:iv];
            self.runnersTableView.frame = CGRectMake(self.runnersTableView.frame.size.width, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height);
            [UIView transitionWithView:self.runnersTableView duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                iv.frame = CGRectMake(-self.runnersTableView.frame.size.width, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height);
                [self.runnersTableView reloadData];
                self.runnersTableView.frame = CGRectMake(0, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height);
                
            } completion:^(BOOL finished){
                [iv removeFromSuperview];
            }];

            
        }
        else if (self.isRightSwipe) {
            self.isRightSwipe = NO;
            
            UIView *renderedView = self.runnersTableView;
            CGPoint tableContentOffset = self.runnersTableView.contentOffset;
            UIGraphicsBeginImageContextWithOptions(renderedView.bounds.size, renderedView.opaque, 0.0);
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(contextRef, 0, -tableContentOffset.y);
            [self.runnersTableView.layer renderInContext:contextRef];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height)];
            iv.clipsToBounds = YES;
            iv.contentMode = UIViewContentModeTop;
            iv.image = image;
            [self.view addSubview:iv];
            self.runnersTableView.frame = CGRectMake(-self.runnersTableView.frame.size.width, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height);
            [UIView transitionWithView:self.runnersTableView duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                iv.frame = CGRectMake(self.runnersTableView.frame.size.width, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height);
                [self.runnersTableView reloadData];
                self.runnersTableView.frame = CGRectMake(0, self.runnersTableView.frame.origin.y, self.runnersTableView.frame.size.width, self.runnersTableView.frame.size.height);
            } completion:^(BOOL finished){
                [iv removeFromSuperview];
            }];
            
        }


    }
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return [self.numbers_Array count];
}
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLRunners_CustomCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    ZLRunner * _runner = [self.numbers_Array objectAtIndex:indexPath.row];
    cell.horseNum_Label.text = _runner.runnerNumber;//[NSString stringWithFormat:@"%d",_runner.runner_id];
    NSDictionary * colorDict = nil;
    if( _runner.runner_id == 0 ){
        colorDict = @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:252.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0],@"isSelected":@NO};
    }
    else{
        colorDict = [self.runnerColors objectAtIndex:(_runner.runner_id - 1)];
    }
    cell.backgroundColor = [colorDict objectForKey:@"bg"];
    cell.horseNum_Label.textColor = [colorDict objectForKey:@"text"];
    cell.horseNum_Label.backgroundColor = [colorDict objectForKey:@"bg"];
    if( _runner.scratched == NO){
        if(_runner.winOdds == nil || _runner.winOdds.length == 0 || [_runner.winOdds isEqualToString:@"N/A"])
            cell.oddNum_Label.text = _runner.mlodds;
        else
            cell.oddNum_Label.text = _runner.winOdds;
    }
    if ([colorDict valueForKey:@"isSelected"])
    {
        NSLog(@"image selected");
        cell.topImageView.image = [UIImage imageNamed:@"tickmark.png"];
    }

    if ([self isRunnerAvailableInList:[NSString stringWithFormat:@"%d",_runner.runner_id] leg:self.legSelection.currentLeg])
    {
        cell.backgroundLabel.backgroundColor = [colorDict objectForKey:@"bg"];;
        cell.backgroundLabel.frame = cell.bounds;

        [cell.backgroundLabel.layer setCornerRadius:2.0];
        [cell.backgroundLabel.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [cell.backgroundLabel.layer setBorderWidth:2.0];
        
        cell.oddNum_Label.frame =  CGRectMake(-4, cell.frame.size.height-14, cell.frame.size.width, 12);
        cell.oddNum_Label.backgroundColor = [UIColor clearColor];
        cell.oddNum_Label.textColor = [colorDict objectForKey:@"text"];;
        
        CGFloat minValueOfWidthAndHeight = MIN(cell.backgroundLabel.frame.size.width, cell.backgroundLabel.frame.size.height - cell.oddNum_Label.frame.size.height) - 10;
        cell.topImageView.frame = CGRectMake((cell.backgroundLabel.frame.size.width - minValueOfWidthAndHeight)/2, (cell.backgroundLabel.frame.size.height - cell.oddNum_Label.frame.size.height - minValueOfWidthAndHeight)/2 - 2, minValueOfWidthAndHeight, minValueOfWidthAndHeight);
        NSLog(@"indexpath %@",indexPath);

        cell.topImageView.image = [UIImage imageNamed:@"tickmark.png"];
        CGRect rect = cell.oddNum_Label.frame;
        rect.origin.x = 4;
        rect.origin.y -= 6;
        rect.size.width -= 7;
        rect.size.height += 6;
        cell.horseNum_Label.frame = rect;
        cell.horseNum_Label.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        cell.backgroundLabel.backgroundColor = [UIColor clearColor];
        [cell.backgroundLabel.layer setCornerRadius:0.0];
        [cell.backgroundLabel.layer setBorderColor:[[UIColor clearColor] CGColor]];
        [cell.backgroundLabel.layer setBorderWidth:0.0];
        [cell.backgroundLabel setClipsToBounds:NO];
        
        cell.horseNum_Label.frame = CGRectMake(0, 0.0, cell.frame.size.width, cell.frame.size.height-13);
        cell.horseNum_Label.textAlignment = NSTextAlignmentCenter;
        
        cell.oddNum_Label.frame =  CGRectMake(0, cell.frame.size.height-12, cell.frame.size.width, 12);
        cell.oddNum_Label.backgroundColor = [UIColor whiteColor];
        cell.oddNum_Label.textColor = [UIColor blackColor];
        
        cell.topImageView.image = nil;
    }
    
    [cell.horseNum_Label setClipsToBounds:YES];
    [cell.oddNum_Label setClipsToBounds:YES];
    [cell.backgroundLabel setClipsToBounds:YES];
    
    cell.backgroundLabel.backgroundColor = [colorDict objectForKey:@"bg"];
    cell.horseNum_Label.backgroundColor = [colorDict objectForKey:@"bg"];
    
    if( _runner.scratched == YES){
        if( [cell viewWithTag:1000] == nil){
            UIView * vwOverlay = [[UIView alloc] initWithFrame:CGRectMake(0,0,cell.frame.size.width,cell.frame.size.height)];
            vwOverlay.tag = 1000;
            vwOverlay.backgroundColor = [UIColor clearColor];
            
            UIImageView *overlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
            [overlayImageView setBackgroundColor:[UIColor clearColor]];
            
            if (self.numberOfItems < 20) {
                
                overlayImageView.image = [UIImage imageNamed:@"scratch_runner_3"];
            }
            else
            {
                overlayImageView.image = [UIImage imageNamed:@"scratch_runner_4"];
            }
            
            [vwOverlay addSubview:overlayImageView];
            [cell addSubview:vwOverlay];
        }
    }
    else{
        UIView * overlayView = [cell viewWithTag:1000];
        if( overlayView ){
            [overlayView removeFromSuperview];
        }
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.numberOfItems > NUMBER_TO_INCREASE_CELL) {
        //return CGSizeMake(52, 46);
        return CGSizeMake(72, 69);
    }
    else
    {
        return CGSizeMake(72, 69);
    }
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(6, 6, 6, 6);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLRunner * _runner = [self.numbers_Array objectAtIndex:indexPath.row];
    if( _runner.scratched == NO)
    {
        NSMutableDictionary * changeDict = [NSMutableDictionary dictionaryWithDictionary:[self.runnerColors objectAtIndex:(_runner.runner_id - 1)]];
        if ([[changeDict valueForKey:@"isSelected"] intValue] == 1)
        {
            [changeDict setValue:@NO forKey:@"isSelected"];
            [self.checkboxButton setSelected:NO];


        }
        else
        {
            [changeDict setValue:@YES forKey:@"isSelected"];
            [self.checkboxButton setSelected:YES];

        }
        [self.runnerColors replaceObjectAtIndex:(_runner.runner_id - 1) withObject:changeDict];
        ZLRunners_CustomCell *cell = (ZLRunners_CustomCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        [self addOrRemoveRunnerFromResultsArray:cell.horseNum_Label.text leg:self.legSelection.currentLeg];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadWagerView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:WagerRunners] forKey:@"currentLoadedIndex"]];
        
        [collectionView reloadData];
        
        [self setTextToTextView];
    }

    
    
}

- (void) addOrRemoveRunnerFromResultsArray:(NSString *)runner leg:(int)leg
{
    int tempRunner = [runner intValue];
    runner = [NSString stringWithFormat:@"%d",tempRunner];//Temp hack to select / deselect runner 1A
//    NSLog(@"temp runner& %@",runner);
    
    NSMutableDictionary *dictLegs = [ZLAppDelegate getAppData].currentWager.selectedRunners;
    NSLog(@"dictLegs& %@",dictLegs);

    NSMutableArray *currentLegArray = [dictLegs valueForKey:[NSString stringWithFormat:@"%d", leg]];
//    NSLog(@"currentLegArray& %@",currentLegArray);

    if(currentLegArray == nil){
        currentLegArray = [NSMutableArray array];
        [dictLegs setValue:currentLegArray forKey:[NSString stringWithFormat:@"%d", leg]];
    }
    
    if ([self isRunnerAvailableInList:runner leg:leg]){
        [currentLegArray removeObject:runner];
    }
    else{
        [currentLegArray addObject:runner];
    }
//    NSLog(@"currentLegArray After %@",currentLegArray);


    ZLBetType* betType = nil;
    ZLRaceCard *_race_card = [ZLRaceCard findRaceCardByMeetNumber:[ZLAppDelegate getAppData].currentWager.selectedRaceMeetNumber AndPerformanceNumber:[ZLAppDelegate getAppData].currentWager.selectedRacePerformanceNumber];
    if(_race_card){
        ZLRaceDetails * _race_details = [_race_card findRaceDeatilsByRaceId:[ZLAppDelegate getAppData].currentWager.selectedRaceId];
        if(_race_details){
            betType = [_race_details findBetTypeWithName:[ZLAppDelegate getAppData].currentWager.selectedBetType];
            
            if( [betType.typeID isEqualToString:@"EBX"] || [betType.typeID isEqualToString:@"TBX"] || [betType.typeID isEqualToString:@"SFX"]){
                NSMutableDictionary * dictLegs = [ZLAppDelegate getAppData].currentWager.selectedRunners;
                NSMutableArray *firstLegArray = [dictLegs valueForKey:@"0"];
                
                for(int i=0;i<betType.numLegs;i++){
                    if(firstLegArray){
                        [dictLegs setValue:firstLegArray forKey:[NSString stringWithFormat:@"%d", i]];
                    }
                }
            }
        }
    }


}

- (BOOL) isRunnerAvailableInList:(NSString *)runner leg:(int)leg
{
    NSMutableDictionary * dictLegs = [ZLAppDelegate getAppData].currentWager.selectedRunners;
    NSLog(@"dictLegs %@",dictLegs);
    NSMutableArray *currentLegArray = [dictLegs valueForKey:[NSString stringWithFormat:@"%d", leg]];
    NSLog(@"currentLegArray %@",currentLegArray);
    if(currentLegArray == nil){
        currentLegArray = [NSMutableArray array];
        [dictLegs setValue:currentLegArray forKey:[NSString stringWithFormat:@"%d", leg]];
        return NO;
    }
    
    if ([currentLegArray containsObject:runner]) {
        return YES;
    }
    else{
        return NO;
    }
    
}


- (IBAction)bottomViewExpanstionOrCompression:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    [UIView beginAnimations:@"AdWhirlIn" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if ([button isSelected])
    {
        [button setSelected:NO];
        if (IS_IPHONE5) {
            self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x, self.bottomView.frame.origin.y + BIG_BOTTOM_VIEW_HEIGHT - 46, self.bottomView.frame.size.width, 46);
        }
        else
        {
            self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x, self.bottomView.frame.origin.y + BIG_BOTTOM_VIEW_HEIGHT - 46, self.bottomView.frame.size.width, 46);
        }
        
        /*if (IS_IPHONE5) {
            bottoViewFrame = CGRectMake(5, [[UIScreen mainScreen] bounds].size.height - 71 - 87, 228, 46);
        }
        else
        {
            bottoViewFrame = CGRectMake(5, [[UIScreen mainScreen] bounds].size.height - 71, 228, 46);
        }*/
        
        [self.belowResultsView setHidden:YES];
        [self.wagerOnImageView setImage:[UIImage imageNamed:@"uparrowithoutext.png"]];
        self.lblWagerOn.hidden = NO;
        [self.selectedValuesLabel setHidden:NO];
        [self setTextToTextView];
    }
    else
    {
        [button setSelected:YES];        
        
        if (IS_IPHONE5) {

            self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x, self.bottomView.frame.origin.y - BIG_BOTTOM_VIEW_HEIGHT + 46, self.bottomView.frame.size.width, BIG_BOTTOM_VIEW_HEIGHT);
        }
        else
        {
            self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x, self.bottomView.frame.origin.y - BIG_BOTTOM_VIEW_HEIGHT + 46, self.bottomView.frame.size.width, BIG_BOTTOM_VIEW_HEIGHT );
        }
        
        
        [_wagerOnImageView setImage:[UIImage imageNamed:@"downarrow.png"]];
        self.lblWagerOn.hidden = YES;
        [self.belowResultsView setHidden:NO];
        [self.selectedValuesLabel setHidden:YES];
    }
    
    [UIView commitAnimations];

}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.numbers_Array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.objZLRunnersViewCell  = [tableView dequeueReusableCellWithIdentifier:kcustomRunnersViewCellIdentifier];
    if (self.objZLRunnersViewCell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ZLRunnersViewCell" owner:self options:nil];
        
    }
  
    [self.objZLRunnersViewCell.runnerNumberLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:18]];
    [self.objZLRunnersViewCell.titleLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];
    [self.objZLRunnersViewCell.jocyNameLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:10]];
    [self.objZLRunnersViewCell.couchNameLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:10]];
    [self.objZLRunnersViewCell.lbsNameLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:10]];
    [self.objZLRunnersViewCell.bbLabel setFont:[UIFont fontWithName:@"Roboto-Light" size:10]];
    [self.objZLRunnersViewCell.oddNum_Label setFont:[UIFont fontWithName:@"Roboto-Light" size:13]];

 
    ZLRunner * _runner = [self.numbers_Array objectAtIndex:indexPath.row];
    
//    [self.objZLRunnersViewCell.runnerNumberLabel setText:[NSString stringWithFormat:@"%d",_runner.runner_id]];
    [self.objZLRunnersViewCell.runnerNumberLabel setText:_runner.runnerNumber];
    NSDictionary * colorDict = nil;
    if( _runner.runner_id == 0 ){
        colorDict = @{@"bg":[UIColor whiteColor],@"text":[UIColor colorWithRed:252.0/255.0 green:0.0/252.0 blue:0.0/255.0 alpha:1.0]};
    }
    else{
        colorDict = [self.runnerColors objectAtIndex:(_runner.runner_id - 1)];
    }
    [self.objZLRunnersViewCell.runnerNumberLabel setBackgroundColor:[colorDict objectForKey:@"bg"]];
    [self.objZLRunnersViewCell.runnerNumberLabel setTextColor:[colorDict objectForKey:@"text"]];


    [self.objZLRunnersViewCell.titleLabel setText:_runner.title];
    [self.objZLRunnersViewCell.jocyNameLabel setText:_runner.jockeyName];
    [self.objZLRunnersViewCell.couchNameLabel setText:_runner.couchName];
    [self.objZLRunnersViewCell.lbsNameLabel setText:_runner.lbs];
    [self.objZLRunnersViewCell.bbLabel setText:_runner.bb];
    
    if(_runner.scratched == NO){
        if(_runner.winOdds == nil || _runner.winOdds.length == 0 || [_runner.winOdds isEqualToString:@"N/A"])
            self.objZLRunnersViewCell.oddNum_Label.text = _runner.mlodds;
        else
            self.objZLRunnersViewCell.oddNum_Label.text = _runner.winOdds;
    }
    else{
        self.objZLRunnersViewCell.oddNum_Label.text = @"";
    }
    
    if ([self isRunnerAvailableInList:[NSString stringWithFormat:@"%d",_runner.runner_id] leg:self.legSelection.currentLeg])
    {
        [self.objZLRunnersViewCell.titleLabel setTextColor:[colorDict objectForKey:@"text"]];
        [self.objZLRunnersViewCell.jocyNameLabel setTextColor:[colorDict objectForKey:@"text"]];
        [self.objZLRunnersViewCell.couchNameLabel setTextColor:[colorDict objectForKey:@"text"]];
        [self.objZLRunnersViewCell.lbsNameLabel setTextColor:[colorDict objectForKey:@"text"]];
        [self.objZLRunnersViewCell.bbLabel setTextColor:[colorDict objectForKey:@"text"]];
        [self.objZLRunnersViewCell.oddNum_Label setTextColor:[colorDict objectForKey:@"text"]];

        [self.objZLRunnersViewCell.checkImageView setImage:[UIImage imageNamed:@"tickmark.png"]];
        [self.objZLRunnersViewCell.background setBackgroundColor:[colorDict objectForKey:@"bg"]];
    }
    else
    {
        [self.objZLRunnersViewCell.titleLabel setTextColor:[UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0]];
        [self.objZLRunnersViewCell.jocyNameLabel setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
        [self.objZLRunnersViewCell.couchNameLabel setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
        [self.objZLRunnersViewCell.lbsNameLabel setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
        [self.objZLRunnersViewCell.bbLabel setTextColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0]];
        [self.objZLRunnersViewCell.oddNum_Label setTextColor:[UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0]];

        [self.objZLRunnersViewCell.checkImageView setImage:nil];
        [self.objZLRunnersViewCell.background setBackgroundColor:[UIColor clearColor]];
    }

    if( _runner.scratched == YES){
        if( [self.objZLRunnersViewCell viewWithTag:1002] == nil){
            UIView * vwOverlay = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.objZLRunnersViewCell.frame.size.width,self.objZLRunnersViewCell.frame.size.height)];
            vwOverlay.tag = 1002;
            vwOverlay.backgroundColor = [UIColor blackColor];
            vwOverlay.alpha = 0.7;
            [self.objZLRunnersViewCell addSubview:vwOverlay];
        }
    }
    else{
        if( [self.objZLRunnersViewCell viewWithTag:1002] != nil){
            UIView * vw = [self.objZLRunnersViewCell viewWithTag:1002];
            [vw removeFromSuperview];
        }
    }
    return self.objZLRunnersViewCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZLRunner * _runner = [self.numbers_Array objectAtIndex:indexPath.row];
    if( _runner.scratched == NO ){
    
        [self addOrRemoveRunnerFromResultsArray:[NSString stringWithFormat:@"%d", _runner.runner_id] leg:self.legSelection.currentLeg];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadWagerView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:WagerRunners] forKey:@"currentLoadedIndex"]];
        
        [tableView reloadData];

        [self setTextToTextView];
    }
    else{
        [tableView reloadData];
    }
}


- (void) switchBetweenListAndGrid
{
    if (self.tile_CollectionView.hidden)
    {
        self.tile_CollectionView.hidden = NO;
        self.runnersTableView.hidden = YES;
        [self.tile_CollectionView reloadData];
    }
    else
    {
        self.tile_CollectionView.hidden = YES;
        self.runnersTableView.hidden = NO;
        [self.runnersTableView reloadData];
    }
}

- (IBAction)listOrGridButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button isSelected])
    {
        [button setSelected:NO];
        self.tile_CollectionView.hidden = NO;
        self.runnersTableView.hidden = YES;
        [self.tile_CollectionView reloadData];
    }
    else
    {
        [button setSelected:YES];
        self.tile_CollectionView.hidden = YES;
        self.runnersTableView.hidden = NO;
        [self.runnersTableView reloadData];
    }
}


- (IBAction)allButtonClicked:(id)sender
{
    NSMutableDictionary * dictLegs = [ZLAppDelegate getAppData].currentWager.selectedRunners;
    NSMutableArray *currentLegArray = [dictLegs valueForKey:[NSString stringWithFormat:@"%d", self.legSelection.currentLeg]];
    
    for (ZLRunner * _runner in self.numbers_Array) {
        [currentLegArray addObject:[NSString stringWithFormat:@"%d",_runner.runner_id]];
    }
    [self setTextToTextView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadWagerView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:WagerRunners] forKey:@"currentLoadedIndex"]];
    
    [self reloadViews];

}
- (IBAction)clearButtonClicked:(id)sender
{
    NSMutableDictionary * dictLegs = [ZLAppDelegate getAppData].currentWager.selectedRunners;
    NSMutableArray *currentLegArray = [dictLegs valueForKey:[NSString stringWithFormat:@"%d", self.legSelection.currentLeg]];
    
    [currentLegArray removeAllObjects];
    [self setTextToTextView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadWagerView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:WagerRunners] forKey:@"currentLoadedIndex"]];
    [self reloadViews];
}

- (void) setTextToTextView
{
    NSString *textString = [[ZLAppDelegate getAppData].currentWager getBetString];
    
    [self.selectedValuesLabel setText:textString];
    double betAmount = [[ZLAppDelegate getAppData].currentWager calculateTotalBetAmount];
                        
    [self.wagerLabel setText:[NSString stringWithFormat:@"$%.02f WAGER ON",betAmount]];
    [self.lblWagerOn setText:[NSString stringWithFormat:@"$%.02f WAGER ON",betAmount]];
    [self.runnersLabel setText:textString];
    
    CGSize maximumDateLabelSize = CGSizeMake(228,9999);
    
    CGSize expectedDateLabelSize = [_selectedValuesLabel.text sizeWithFont:_selectedValuesLabel.font constrainedToSize:maximumDateLabelSize lineBreakMode:_selectedValuesLabel.lineBreakMode];
    CGRect dateLabelNewFrame = _selectedValuesLabel.frame;
    
    BOOL isValueChanges = NO;
    
    int numberOfLines = expectedDateLabelSize.height/_selectedValuesLabel.font.lineHeight;
    
    if (numberOfTotalLines != numberOfLines && numberOfLines > 0) {
        
        numberOfTotalLines = numberOfLines;
        isValueChanges = YES;
        changeInHeight =  expectedDateLabelSize.height - _selectedValuesLabel.frame.size.height;
        
    }
    
    [UIView beginAnimations:@"AdWhirlIn" context:nil];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (isValueChanges) {
        
        CGRect bottomViewFrame = _bottomView.frame;
        
        //adjust the label the the new height.
        
        bottomViewFrame.origin.y = _bottomView.frame.origin.y  - changeInHeight;
        bottomViewFrame.size.height = _bottomView.frame.size.height + changeInHeight;
        _bottomView.frame = bottomViewFrame;
        
    }
    
    [UIView commitAnimations];
    
    dateLabelNewFrame.size.width = expectedDateLabelSize.width;
    dateLabelNewFrame.origin.x = (_bottomView.frame.size.width - dateLabelNewFrame.size.width)/2;
    
    dateLabelNewFrame.size.height = expectedDateLabelSize.height;
    _selectedValuesLabel.frame = dateLabelNewFrame;
    
    
}


- (IBAction)oddsButtonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadOddsView" object:self userInfo:nil];    
}

-(void) viewDidAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRunnersFromServer) name:@"ZLWagerRacesDidLoad" object:nil];
    
    [super viewDidAppear:animated];
    
}

-(void) viewDidDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selctAllClicked:(id)sender
{
    if (self.checkboxSelected == 0)
    {
        [self.checkboxButton setSelected:YES];
        for (int i = 0; i< [self.numbers_Array count]; i++)
        {
            ZLRunner * _runner = [self.numbers_Array objectAtIndex:i];
            NSMutableDictionary * changeDict = [NSMutableDictionary dictionaryWithDictionary:[self.runnerColors objectAtIndex:(_runner.runner_id - 1)]];
            if ([[changeDict valueForKey:@"isSelected"] intValue] == 1)
            {
                NSLog(@"Value true");
            }
            else
            {
            [changeDict setValue:@YES forKey:@"isSelected"];
                [self.runnerColors replaceObjectAtIndex:(_runner.runner_id - 1) withObject:changeDict];
            NSIndexPath * selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
            if( _runner.scratched == NO)
            {
                ZLRunners_CustomCell *cell = (ZLRunners_CustomCell *)[self.tile_CollectionView cellForItemAtIndexPath:selectedPath];
                
                [self addOrRemoveRunnerFromResultsArray:cell.horseNum_Label.text leg:self.legSelection.currentLeg];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadWagerView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:WagerRunners] forKey:@"currentLoadedIndex"]];
//                
//                [collectionView reloadData];
                
                [self setTextToTextView];
            }
            }
            
        }
        self.checkboxSelected = 1;
        [self.tile_CollectionView reloadData];
    }
    else
    {
        [self.checkboxButton setSelected:NO];
        self.checkboxSelected = 0;
        for (int i = 0; i< [self.numbers_Array count]; i++)
        {
            ZLRunner * _runner = [self.numbers_Array objectAtIndex:i];
            NSMutableDictionary * changeDict = [NSMutableDictionary dictionaryWithDictionary:[self.runnerColors objectAtIndex:(_runner.runner_id - 1)]];
            
            if ([[changeDict valueForKey:@"isSelected"] intValue] == 0)
            {
                NSLog(@"Value false");
            }
            else
            {
            [changeDict setValue:@NO forKey:@"isSelected"];
            [self.runnerColors replaceObjectAtIndex:(_runner.runner_id - 1) withObject:changeDict];
            NSIndexPath * selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
            if( _runner.scratched == NO)
            {
                ZLRunners_CustomCell *cell = (ZLRunners_CustomCell *)[self.tile_CollectionView cellForItemAtIndexPath:selectedPath];
                
                [self addOrRemoveRunnerFromResultsArray:cell.horseNum_Label.text leg:self.legSelection.currentLeg];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadWagerView" object:self userInfo:[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:WagerRunners] forKey:@"currentLoadedIndex"]];
                //
                //                [collectionView reloadData];
                
                [self setTextToTextView];
            }
            }
            
        }
        [self.tile_CollectionView reloadData];
}
}
@end
