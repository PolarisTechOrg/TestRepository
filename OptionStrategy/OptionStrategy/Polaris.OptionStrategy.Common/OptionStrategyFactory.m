//
//  OptionStrategyFactory.m
//  OptionWuKong
//
//  Created by admin on 11/22/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "OptionStrategyFactory.h"
#import "OptionStrategy.h"
#import "One_DaShengStrategy.h"
#import "Two_DaDieStrategy.h"
#import "Three_NiuPiPianHaoStrategy.h"
#import "Four_NiuPiPianDanStrategy.h"
#import "Five_TuPoStrategy.h"
#import "Six_NiuPiStrategy.h"
#import "Seven_WenZhangStrategy.h"
#import "Eight_WenDieStrategy.h"
#import "Nine_WenZhangZuoZhuangStrategy.h"
#import "Ten_WenDieZuoZhuangStrategy.h"
#import "Eleven_XianPanZaiZhangStrategy.h"
#import "Twelve_XianPanZaiDieStrategy.h"

@implementation OptionStrategyFactory

+ (OptionStrategy *)Init:(OptionStrategyType)strategyType
{
    OptionStrategy *strategy = nil;
    switch (strategyType)
    {
        case OptionStrategyType_One_DaSheng:
            strategy = [[One_DaShengStrategy alloc] init];
            break;
            
        case OptionStrategyType_Two_DaDie:
            strategy = [[Two_DaDieStrategy alloc] init];
            break;
            
        case OptionStrategyType_Three_NiuPiPianHao:
            strategy = [[Three_NiuPiPianHaoStrategy alloc] init];
            break;
            
        case OptionStrategyType_Four_NiuPiPianDan:
            strategy = [[Four_NiuPiPianDanStrategy alloc] init];
            break;
            
        case OptionStrategyType_Five_TuPo:
            strategy = [[Five_TuPoStrategy alloc] init];
            break;
            
        case OptionStrategyType_Six_NiuPi:
            strategy = [[Six_NiuPiStrategy alloc] init];
            break;
            
        case OptionStrategyType_Seven_WenZhang:
            strategy = [[Seven_WenZhangStrategy alloc] init];
            break;
            
        case OptionStrategyType_Eight_WenDie:
            strategy = [[Eight_WenDieStrategy alloc] init];
            break;
            
        case OptionStrategyType_Nine_WenZhangZuoZhuang:
            strategy = [[Nine_WenZhangZuoZhuangStrategy alloc] init];
            break;
            
        case OptionStrategyType_Ten_WenDieZuoZhuang:
            strategy = [[Ten_WenDieZuoZhuangStrategy alloc] init];
            break;
            
        case OptionStrategyType_Eleven_XianPanZaiZhang:
            strategy = [[Eleven_XianPanZaiZhangStrategy alloc] init];
            break;
            
        case OptionStrategyType_Twelve_XianPanZaiDie:
            strategy = [[Twelve_XianPanZaiDieStrategy alloc] init];
            break;
            
        default:
            break;
    }
    
    return strategy;
}

@end
