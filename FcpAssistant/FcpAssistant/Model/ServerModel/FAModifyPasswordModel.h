//
//  FAModifyPasswordModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAModifyPasswordModel : NSObject
// 盐值。
@property(nonatomic,copy) NSString *Salt;
// 时间戳。
@property(nonatomic,copy) NSString *Stamp;
// 签名。
@property(nonatomic,copy) NSString *Sign;
// 哈希后的密码，(密文：SHA1(Salt + SHA1(Password)))。
@property(nonatomic,copy) NSString *Password;
// 哈希后的新密码。
@property(nonatomic,copy) NSString *NewPassword;
// 哈希后的确认密码。
@property(nonatomic,copy) NSString *ConfirmPassword;
@end
