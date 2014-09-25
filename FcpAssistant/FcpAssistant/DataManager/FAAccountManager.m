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

@implementation FAAccountManager

+(instancetype) shareInstance
{
    static FAAccountManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FAAccountManager alloc] init];
        instance.hasLogin = YES;
    });
    
    return instance;
}

-(void) Login:(NSString*) account withPassword:(NSString*) password
{
    FASaltDto *saltDto = [self getSalt:account];
}

-(FASaltDto *) getSalt:(NSString *) account
{
     NSString *requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Salt/%@",WEB_URL, account];
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

-(NSString *) encryptFcpPassword:(NSString *) password stamp:(NSString *)stamp salt:(NSString *) salt
{
    NSString *encryptPwd = password;
    return encryptPwd;
}
@end
