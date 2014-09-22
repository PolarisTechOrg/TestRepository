//
//  FAWishlistDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-22.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAWishlistDto : NSObject

// 最大收藏数量。
@property(nonatomic,assign) int MaxCount;

// 已收藏数量。
@property(nonatomic,assign) int WishCount;

// 数据集合。
@property(nonatomic,retain) NSArray *Items;

//数据集合类型
+(Class) Items_class;
@end
