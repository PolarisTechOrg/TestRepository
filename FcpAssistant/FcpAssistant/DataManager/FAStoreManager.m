//
//  FAStoreManager.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-5.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStoreManager.h"

@implementation FAStoreManager

+(instancetype) shareInstance
{
    static FAStoreManager * storeManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storeManager = [[FAStoreManager alloc] init];
    });
    
    return storeManager;
}

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

@end
