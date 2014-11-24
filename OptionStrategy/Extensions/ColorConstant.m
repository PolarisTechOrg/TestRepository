//
//  ColorConstant.m
//  OptionLotto
//
//  Created by admin on 14-10-13.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "ColorConstant.h"

@implementation COLOR_CONSTANT

+(COLOR_CONSTANT*) shared {
    static COLOR_CONSTANT *shared;
    static dispatch_once_t token;
    dispatch_once(&token, ^(){
        shared = [[COLOR_CONSTANT alloc] init];
    });
    
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.CALL = [UIColor fromRGB:169 green: 12 blue: 12 alpha: 1.0];
        self.PUT = [UIColor fromRGB:37 green: 99 blue: 16 alpha: 1.0];
        
        // 新增期权界面
        self.EXCHANGE_CFFE_MAIN_BACKGROUND = [UIColor fromRGB:19 green: 170 blue: 150 alpha: 1.0];
        self.EXCHANGE_DCE_MAIN_BACKGROUND = [UIColor fromRGB:106 green: 68 blue: 209 alpha: 1.0];
        self.EXCHANGE_SFE_MAIN_BACKGROUND = [UIColor fromRGB:237 green: 119 blue: 20 alpha: 1.0];
        self.EXCHANGE_CZCE_MAIN_BACKGROUND = [UIColor fromRGB:76 green: 126 blue: 20 alpha: 1.0];
        
        self.EXCHANGE_CFFE_SLAVE_BACKGROUND = [UIColor fromRGB:1 green: 113 blue: 92 alpha: 1.0];
        self.EXCHANGE_DCE_SLAVE_BACKGROUND = [UIColor fromRGB:44 green: 18 blue: 171 alpha: 1.0];
        self.EXCHANGE_SFE_SLAVE_BACKGROUND = [UIColor fromRGB:220 green: 56 blue: 2 alpha: 1.0];
        self.EXCHANGE_CZCE_SLAVE_BACKGROUND = [UIColor fromRGB:23 green: 62 blue: 2 alpha: 1.0];
    }
    return self;
}

@end
