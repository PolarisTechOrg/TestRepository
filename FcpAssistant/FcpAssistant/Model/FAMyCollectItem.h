//
//  FAMyCollectItem.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAMyCollectItem : NSObject

@property(nonatomic,assign) int strategyId;
@property (nonatomic,copy) NSString* strategyName;
@property(nonatomic,assign) int collectCount;
@property(nonatomic,copy) NSString* provider;

-(instancetype)initWithStrategyId:(int) strategyId;
@end
