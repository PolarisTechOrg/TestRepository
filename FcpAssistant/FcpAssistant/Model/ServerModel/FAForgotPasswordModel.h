//
//  FAForgotPasswordModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-15.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAForgotPasswordModel : NSObject
// 会员ID或用户名。
@property(nonatomic,copy) NSString *UserName;
// 验证码。
@property(nonatomic,copy) NSString *CheckCode;
@end
