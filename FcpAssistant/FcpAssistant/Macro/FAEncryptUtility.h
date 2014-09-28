//
//  FAEncryptUtility.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAEncryptUtility : NSObject

//SHA加密算法
+ (NSString *)sha1:(NSString *)source;
@end
