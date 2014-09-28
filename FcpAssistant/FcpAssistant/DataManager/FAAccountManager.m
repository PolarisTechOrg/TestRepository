//
//  FAAccountManager.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-16.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAAccountManager.h"
#import "FAHttpHead.h"
#import "FAHttpUtility.h"
#import "FAFoundation.h"

#import "FASaltDto.h"
#import "FAStationLoginModelDto.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAJSONSerialization.h"
#import "FAEncryptUtility.h"

@implementation FAAccountManager

+(instancetype) shareInstance
{
    static FAAccountManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FAAccountManager alloc] init];
        instance.hasLogin = NO;
    });
    
    return instance;
}

-(void) Login:(NSString*) account withPassword:(NSString*) password clientId:(NSString *) clientId
{
    @try
    {
    FASaltDto *saltDto = [self getSalt:account];
    
    
           NSString *encryptPwd = [self encryptFcpPassword:password stamp:saltDto.Stamp salt:saltDto.Salt];
    
    NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/member?stationlogin",WEB_URL];
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    FAStationLoginModelDto *loginDto = [[FAStationLoginModelDto alloc] init];
    loginDto.Account = account;
    loginDto.Password = encryptPwd;
    loginDto.RememberMe = YES;
    loginDto.Auto = NO;
    loginDto.Sign = saltDto.Sign;
    loginDto.MobileClientId = clientId;
    loginDto.DeviceType = 2;
    
    FAHttpHead *httpHeader = [FAHttpHead defaultInstance];
    httpHeader.Method = @"POST";
    
    NSError *error;
    [FAHttpUtility sendRequest:requestUrl withHead:httpHeader httpBody:loginDto error:error];;

    if(error == nil)
    {
        self.hasLogin = YES;
    }
    else
    {
        self.hasLogin = NO;
    }
        
    }
    @catch (NSException *exception)
    {
        self.hasLogin = NO;
        NSLog(@"%@",exception);
        
    }
    @finally
    {
        
    }

    
}

-(FASaltDto *) getSalt:(NSString *) account
{
    NSString *requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Salt/%@",WEB_URL, account];
    NSLog(@"%@",requestUrlStr);
    NSURL *requestUrl =[NSURL URLWithString: requestUrlStr];
    
     NSError *error;
     NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:error];
     
     if(error == nil)
     {
         FASaltDto *dtoObj =[FAJSONSerialization toObject:[FASaltDto class] fromData: replyData];
         
         return  dtoObj;
         
     }
     else
     {
         return nil;
     }
}

//密码加密
-(NSString *) encryptFcpPassword:(NSString *) password stamp:(NSString *)stamp salt:(NSString *) salt
{
    NSString *pwdEncryp = [FAEncryptUtility sha1:password];
    NSString *saltEncryp = [FAEncryptUtility sha1:[salt stringByAppendingString:pwdEncryp]];
    NSString *stampEncryp = [FAEncryptUtility sha1:[stamp stringByAppendingString:saltEncryp]];
    
    return [[NSString alloc] initWithFormat:@"%@|%@|%@",stamp,salt,stampEncryp];
}
@end
