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
#import "FAUtility.h"
#import "FAMember.h"
#import "FAStationAccount.h"
#import "FAModifyPasswordModel.h"

@implementation FAAccountManager

//当前Fcp账号
@synthesize currentMember;
//当前交易账号
@synthesize selectFundAccount;

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

//
-(void) Login:(NSString*) account withPassword:(NSString*) password clientId:(NSString *) clientId
{
    @try
    {
        
        FASaltDto *saltDto = [self getSalt:account];
      
        NSLog(@"Stamp:%@Salt:%@:Sign:%@",saltDto.Stamp,saltDto.Sign,saltDto.Salt);
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
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHeader httpBody:loginDto error:&error];
        
        NSString *replyMessage = [[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding];
        NSLog(@"Login reply: %@",replyMessage);


        if(error == nil)
        {
            FAStationAccount * stationAccount =[FAJSONSerialization toObject:[FAStationAccount class] fromData:replyData];
            self.currentMember = stationAccount;
            if(stationAccount.RealFundAccount == nil && stationAccount.SimulateFundAccount != nil)
            {
                self.selectFundAccount = stationAccount.SimulateFundAccount;
            }
            if(stationAccount.RealFundAccount !=nil && stationAccount.SimulateFundAccount == nil)
            {
                self.selectFundAccount = stationAccount.RealFundAccount;
            }
            if(stationAccount.RealFundAccount != nil && stationAccount.SimulateFundAccount != nil)
            {
                self.selectFundAccount = stationAccount.SimulateFundAccount;
            }
            self.hasLogin = YES;
        }
        else
        {
            self.currentMember = nil;
            self.hasLogin = NO;

            NSException *ex = [[NSException alloc] initWithName:@"LoginException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
            
            @throw ex;
        }
    }
    @catch (NSException *exception)
    {
        self.currentMember = nil;
        self.selectFundAccount = nil;
        self.hasLogin = false;
        @throw exception;
    }
    @finally
    {
    }
}

-(void)logout
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/member?logout",WEB_URL];
        NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
        
        NSString *replyMessage = [[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding];
        NSLog(@"Login reply: %@",replyMessage);
    }
    @catch (NSException *exception)
    {
        @throw exception;
    }
    @finally
    {
        self.currentMember = nil;
        self.selectFundAccount = nil;
        self.hasLogin = NO;
    }
}

-(void) modifyPasswor:(NSString *) oldpassword newPassword:(NSString *) newPassword confirmPassword:(NSString *)confirmPassword
{
    if(self.hasLogin == NO)
    {
        return;
    }
    
    @try
    {
        FASaltDto *saltDto = [self getSalt:self.currentMember.FcpAccount];
        
        NSString *oldEncryptPwd = [self encryptFcpPassword:oldpassword salt:saltDto.Salt];
        NSString *newEncryptPwd = [self encryptFcpPassword:newPassword salt:saltDto.Salt];
        NSString *confirmEncryptPwd = [self encryptFcpPassword:confirmPassword salt:saltDto.Salt];
        
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/member?modifypwd",WEB_URL];
        NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
        
        FAModifyPasswordModel *modifyPwdModel = [[FAModifyPasswordModel alloc]init];
        modifyPwdModel.Salt = saltDto.Salt;
        modifyPwdModel.Stamp = saltDto.Stamp;
        modifyPwdModel.Sign = saltDto.Sign;
        modifyPwdModel.Password = oldEncryptPwd;
        modifyPwdModel.NewPassword = newEncryptPwd;
        modifyPwdModel.ConfirmPassword = confirmEncryptPwd;
        
        FAHttpHead *httpHeader = [FAHttpHead defaultInstance];
        httpHeader.Method = @"POST";
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHeader httpBody:modifyPwdModel error:&error];
        
        NSString *replyMessage = [[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding];
        NSLog(@"Login reply: %@",replyMessage);
        
        
        if(error != nil)
        {
            NSException *ex = [[NSException alloc] initWithName:@"LoginException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
            
            @throw ex;
        }
    }
    @catch (NSException *exception)
    {
        @throw exception;
    }
    @finally
    {
    }
}

-(void) changeFundAccount:(NSString *) fundAccount fundAccountType:(int) fundAccountType
{
    if(self.currentMember.RealFundAccount != nil &&
       self.currentMember.RealFundAccount.FundAccount == fundAccount &&
       self.currentMember.RealFundAccount.FundAccountType == fundAccountType)
    {
        self.selectFundAccount = self.currentMember.RealFundAccount;
    }
    else if(self.currentMember.SimulateFundAccount != nil &&
            self.currentMember.SimulateFundAccount.FundAccount == fundAccount &&
            self.currentMember.SimulateFundAccount.FundAccountType == fundAccountType)
    {
        self.selectFundAccount = self.currentMember.SimulateFundAccount;
    }

}
-(FASaltDto *) getSalt:(NSString *) account
{
    NSString *requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Salt/%@",WEB_URL, account];
    NSLog(@"%@",requestUrlStr);
    NSURL *requestUrl =[NSURL URLWithString: requestUrlStr];
    
     NSError *error;
     NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
     
     if(error == nil)
     {

         FASaltDto *dtoObj =[FAJSONSerialization toObject:[FASaltDto class] fromData: replyData];
         return  dtoObj;
     }
     else
     {
         NSException *ex = [[NSException alloc] initWithName:@"GetSaltException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
         @throw ex;
     }
}

//密码加密
-(NSString *) encryptFcpPassword:(NSString *) password stamp:(NSString *)stamp salt:(NSString *) salt
{
    NSString *pwdEncryp = [FAUtility sha1:password];
    NSString *saltEncryp = [FAUtility sha1:[salt stringByAppendingString:pwdEncryp]];
    NSString *stampEncryp = [FAUtility sha1:[stamp stringByAppendingString:saltEncryp]];
    
    return [[NSString alloc] initWithFormat:@"%@|%@|%@",stamp,salt,stampEncryp];
}

//密码加密
-(NSString *) encryptFcpPassword:(NSString *) password salt:(NSString *) salt
{
    NSString *pwdEncryp = [FAUtility sha1:password];
    NSString *saltEncryp = [FAUtility sha1:[salt stringByAppendingString:pwdEncryp]];
    
    return saltEncryp;
}
@end
