//
//  FAModifyPasswordModel.m
//  FcpAssistant
//
//  Created by YangMing on 14-10-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAModifyPasswordModel.h"

@implementation FAModifyPasswordModel
// 盐值。
@synthesize Salt;
// 时间戳。
@synthesize Stamp;
// 签名。
@synthesize Sign;
// 哈希后的密码，(密文：SHA1(Salt + SHA1(Password)))。
@synthesize Password;
// 哈希后的新密码。
@synthesize NewPassword;
// 哈希后的确认密码。
@synthesize ConfirmPassword;
@end
