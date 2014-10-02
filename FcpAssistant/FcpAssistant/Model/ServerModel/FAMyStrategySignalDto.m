//
//  FAMyStrategySignalDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-1.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyStrategySignalDto.h"
#import "FAStrategySignalDto.h"

@implementation FAMyStrategySignalDto
//关键字
@synthesize Key;
//描述
@synthesize Description;
//明细
@synthesize Detail;

//持仓明细数据集合
+(Class) Detail_class
{
    return [FAStrategySignalDto class];
}
@end
