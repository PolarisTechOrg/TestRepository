//
//  FAStationLoginModelDto.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-24.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStationLoginModelDto : NSObject

// 会员ID或用户名。
@property(nonatomic,copy) NSString *Account;
// 组合密码（key|salt|哈希后的密码）.哈希后的密码等于SHA1(key + SHA1(salt + SHA1(password)))。
@property(nonatomic,copy) NSString *Password;
// 记住帐号。
@property(nonatomic,assign) BOOL RememberMe;
// 自动登录。
@property(nonatomic,assign) BOOL Auto;
// 签名。
@property(nonatomic,copy) NSString *Sign;
// 第三方登录类型。
@property(nonatomic,assign) int OpenType;
// 第三方访问ID。
@property(nonatomic,copy) NSString *OpenId;
// 第三方访问令牌。
@property(nonatomic,copy) NSString *AccessToken;
// 移动设备标识。
@property(nonatomic,copy) NSString *MobileClientId;
//设备类型
@property(nonatomic,assign) int DeviceType;
@end
