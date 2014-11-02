//
//  FAAccountManager.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-16.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAStationAccount.h"

@interface FAAccountManager : NSObject

+(instancetype) shareInstance;

@property(nonatomic,assign) bool hasLogin;

//当前FCP用户
@property(nonatomic,strong) FAStationAccount *currentMember;
//当前选择交易账号
@property(nonatomic,strong) FAStationFundAccount *selectFundAccount;

@property(nonatomic,retain) NSString *geTuiClientId;
@property(nonatomic,retain) NSString *deviceToken;

//用户登陆
-(void) Login:(NSString *) account  withPassword:(NSString *) password;

//交易账户选中变更
-(void) changeFundAccount:(NSString *) fundAccount fundAccountType:(int) fundAccountType;

//修改密码
-(void) modifyPasswor:(NSString *) oldpassword newPassword:(NSString *) newPassword confirmPassword:(NSString *)confirmPassword;

//用户登出
-(void)logout;
@end
