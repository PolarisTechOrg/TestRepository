//
//  FAStationLoginModelDto.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-24.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStationLoginModelDto.h"

@implementation FAStationLoginModelDto
// 会员ID或用户名。
@synthesize Account;
// 组合密码（key|salt|哈希后的密码）.哈希后的密码等于SHA1(key + SHA1(salt + SHA1(password)))。
@synthesize Password;
// 记住帐号。
@synthesize RememberMe;
// 自动登录。
@synthesize Auto;
// 签名。
@synthesize Sign;
// 第三方登录类型。
@synthesize OpenType;
// 第三方访问ID。
@synthesize OpenId;
// 第三方访问令牌。
@synthesize AccessToken;
// 移动设备标识。
@synthesize MobileClientId;
//设备类型
@synthesize DeviceType;
@end
