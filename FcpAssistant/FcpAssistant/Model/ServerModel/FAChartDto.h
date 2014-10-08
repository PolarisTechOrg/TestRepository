//
//  FAChartDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-8.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAChartDto : NSObject
// 数据集合。
@property(nonatomic,retain) NSArray *Items;

//数据集合类型
+(Class) Items_class;
@end
