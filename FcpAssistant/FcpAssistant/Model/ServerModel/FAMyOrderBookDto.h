//
//  FAMyOrderBookDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-1.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAMyOrderBookDto : NSObject
//关键字
@property(nonatomic,copy) NSString *Key;
//描述
@property(nonatomic,copy) NSString *Description;
//明细
@property(nonatomic,retain) NSArray *Detail;

//持仓明细数据集合
+(Class) Detail_class;
@end
