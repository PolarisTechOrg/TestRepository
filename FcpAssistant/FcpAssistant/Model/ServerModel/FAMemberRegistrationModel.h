//
//  FAMemberRegistrationModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAMemberRegistrationModel : NSObject
// 电子邮件。
@property(nonatomic,copy) NSString *Email;
// 移动电话。
@property(nonatomic,copy) NSString *MobilePhone;
// 来源，1 => 期顾平台, 2 => 竞赛网站, 3=> 二维码, 4=> 移动版期顾平台
@property(nonatomic,assign) int Source;
@end
