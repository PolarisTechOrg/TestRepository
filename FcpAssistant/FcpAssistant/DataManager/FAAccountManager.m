//
//  FAAccountManager.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-16.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAAccountManager.h"

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
    
}
@end
