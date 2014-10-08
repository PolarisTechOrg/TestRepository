//
//  FAChartDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-8.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAChartDto.h"
#import "FADrawedReturnViewModel.h"

@implementation FAChartDto
// 数据集合。
@synthesize Items;

//数据集合类型
+(Class) Items_class
{
    return [FADrawedReturnViewModel class];
}
@end
