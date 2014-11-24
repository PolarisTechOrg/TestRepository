//
//  ColorConstant.h
//  OptionLotto
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColorExtension.h"

@interface COLOR_CONSTANT : NSObject

+(COLOR_CONSTANT*) shared;

@property UIColor *CALL ;
@property UIColor *PUT;

@property UIColor *EXCHANGE_CFFE_MAIN_BACKGROUND;
@property UIColor *EXCHANGE_DCE_MAIN_BACKGROUND;
@property UIColor *EXCHANGE_SFE_MAIN_BACKGROUND;
@property UIColor *EXCHANGE_CZCE_MAIN_BACKGROUND;

@property UIColor *EXCHANGE_CFFE_SLAVE_BACKGROUND;
@property UIColor *EXCHANGE_DCE_SLAVE_BACKGROUND;
@property UIColor *EXCHANGE_SFE_SLAVE_BACKGROUND;
@property UIColor *EXCHANGE_CZCE_SLAVE_BACKGROUND;

@end
