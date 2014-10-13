//
//  FADummieStrategyDetailViewModel.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FADummieStrategyDetailViewModel.h"
#import "FAWinLossViewModel.h"
@implementation FADummieStrategyDetailViewModel

// 提供者标识。
@synthesize ProviderId;

// 策略提供者姓名。
@synthesize ProviderName;

// 是否经过认证。
@synthesize IsCertificated;

// QQ号码。
@synthesize QQ;

// 微博地址。
@synthesize Microblog;

// 星级评价（0 ~ 5，可以有半星），空表示没有评价过。
@synthesize Star;

// 胜负记录，含平仓时间。
@synthesize WinLosses;

//胜负记录集合类型
+(Class) WinLosses_class
{
    return [FAWinLossViewModel class];
}

-(NSString *) description
{
    
    return [NSString stringWithFormat:@"ProviderName:%@ ProviderId:%d",ProviderName,ProviderId];
    
}
@end
