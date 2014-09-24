//
//  FASaltDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-24.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAStampDto.h"

@interface FASaltDto : FAStampDto

// 盐值。
@property(nonatomic,copy) NSString *Salt;
@end
