//
//  ZLWagerUtility.h
//  WarHorse
//
//  Created by Jugs VN on 9/5/13.
//  Copyright (c) 2013 Zytrix Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLWager.h"

@interface ZLWagerUtility : NSObject

+(void) initialize;

+(int) getNumCombos:(ZLWager*) _wager;

+(NSString*) getBetTypeIdFromString:(NSString*) typeId;
@end
