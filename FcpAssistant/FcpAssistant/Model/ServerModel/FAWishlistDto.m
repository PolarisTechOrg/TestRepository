//
//  FAWishlistDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAWishlistDto.h"
#import "FADummieStrategyDetailViewModel.h"

@implementation FAWishlistDto


// 最大收藏数量。
@synthesize MaxCount;

// 已收藏数量。
@synthesize WishCount;

// 数据集合。
@synthesize Items;

//数据集合类型
+(Class) Items_class
{
    return [FADummieStrategyDetailViewModel class];
}
@end
