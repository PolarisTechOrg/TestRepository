//
//  FAStampDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-24.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStampDto : NSObject

// 盐值时间戳。
@property(nonatomic,copy) NSString *Stamp;
// Stamp的签名。
@property(nonatomic,copy) NSString *Sign;
@end
