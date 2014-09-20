//
//  FAStoreManager.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-5.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStoreManager.h"

@implementation FAStoreManager

//获取FAStoreManager实例。
+(instancetype) shareInstance
{
    static FAStoreManager * storeManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storeManager = [[FAStoreManager alloc] init];
    });
    
    return storeManager;
}

//获取交易菜单子项配置
-(NSMutableArray *) getTradeConfigArray
{
    NSMutableArray * traderConfigArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    NSDictionary * collectDic = @{@"title":@"收藏",@"image":@"tradeItem_Collect"};
    [traderConfigArray addObject:@[collectDic]];
    
    NSDictionary * orderDic = @{@"title":@"订购",@"image":@"tradeItem_Order"};
    [traderConfigArray addObject:@[orderDic]];
    
    NSDictionary * positionDic = @{@"title": @"持仓",@"image":@"tradeItem_Position"};
    NSDictionary * orderBookDic = @{@"title": @"委托",@"image":@"tradeItem_OrderBook"};
    NSDictionary * signalDic = @{@"title": @"信号",@"image":@"tradeItem_Signal"};
    [traderConfigArray addObject:@[positionDic,orderBookDic, signalDic]];
    
    return traderConfigArray;
}

//获取更多菜单子项配置
- (NSMutableArray *)getMoreConfigureArray
{
    NSMutableArray *moreConfigureArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSDictionary *myFcpDictionary = @{@"title": @"我的期顾", @"image" : @"moreItem_myFcp",@"subTitle":@"未登陆"};
    [moreConfigureArray addObject:@[myFcpDictionary]];
    
    NSDictionary *shareDictionary = @{@"title": @"分享一下", @"image" : @"moreItem_share",@"subTitle":@""};
    NSDictionary *feedbackDictionary = @{@"title": @"意见反馈", @"image" : @"moreItem_feedback",@"subTitle":@""};
    NSDictionary *moreProductDictionary = @{@"title": @"更多产品", @"image" : @"moreItem_moreProduct",@"subTitle":@""};
    [moreConfigureArray addObject:@[shareDictionary, feedbackDictionary,moreProductDictionary]];
    
    NSDictionary *contractUsDictionary = @{@"title": @"联系我们", @"image" : @"moreItem_contractUs",@"subTitle":@"021-60402266"};
    NSDictionary *checkUpdateDictionary = @{@"title": @"检查更新", @"image" : @"moreItem_checkUpdate",@"subTitle":@"当前版本1.0.1"};
    NSDictionary *aboutDictionary = @{@"title": @"关于", @"image" : @"moreItem_about",@"subTitle":@""};
    [moreConfigureArray addObject:@[contractUsDictionary, checkUpdateDictionary,aboutDictionary]];
    
    return moreConfigureArray;
}

//获取更多产品配置信息
-(NSMutableArray *) getMoreProductConfigureArray;
{
    NSMutableArray *moreProductConfigureArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSDictionary * lotoDictionary = @{@"title": @"擎研期权乐翻天", @"image" : @"moreProduct_loto",@"version":@"1.0.0.1",@"description":@"选择交易品种以及对该品种后市走势看法，根据自己的投资偏好，参考期权合约到期日选择要投资的合约系列"};
    [moreProductConfigureArray addObject:@[lotoDictionary]];
    
    return moreProductConfigureArray;
}

//获取交易菜单子项配置
-(NSMutableArray *) getMessageConfigArray
{
    NSMutableArray * traderConfigArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSDictionary * no1Dic = @{@"readFlag": @"common_collect_flag.png",                                 @"image":@"tradeItem_Position.png",
        @"provider":@"赢家一号",
        @"arriveTime":@"5分钟前",
    @"body":@"赢家一号的信号刚刚发出买入信号测试"};
    
    NSDictionary * no2Dic = @{@"readFlag": @"common_collect_flag.png",                                 @"image":@"tradeItem_Position.png",
                              @"provider":@"乔帮主",
                              @"arriveTime":@"8月10日",
                              @"body":@"赢家一号的跟单人数已经突破2万了测试"};
    
    NSDictionary * no3Dic = @{@"readFlag": @"common_collect_flag.png",                                 @"image":@"tradeItem_Position.png",
                              @"provider":@"系统信息",
                              @"arriveTime":@"8月8日",
                              @"body":@"2.0.0版本已自动更新，请放心使用测试"};

    [traderConfigArray addObject:@[no1Dic,no2Dic, no3Dic]];
    
    return traderConfigArray;
}

@end
