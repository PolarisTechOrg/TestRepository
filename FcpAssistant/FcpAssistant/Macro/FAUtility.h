//
//  FAEncryptUtility.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAUtility : NSObject

//SHA加密算法
+ (NSString *)sha1:(NSString *)source;

//提示对话框
+(void) showAlterView:(NSString *) errorMessage;

//异常提示对话框
+(void) showAlterViewWithException:(NSException *) exception;

//提示对话框（确定）
+(void) showPromptView:(NSString *)title withContent:(NSString *)content;
@end
