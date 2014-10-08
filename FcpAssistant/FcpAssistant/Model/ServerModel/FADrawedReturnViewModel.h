//
//  FADrawedReturnViewModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-8.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FADrawedReturnViewModel : NSObject
// 标识。
@property(nonatomic,assign) int Id;
// 数据日期。
@property(nonatomic,copy) NSDate *DataDay;
// 数据。
@property(nonatomic,assign) double Data;
// 是否为样本数据。
@property(nonatomic,assign) BOOL IsSample;
@end
