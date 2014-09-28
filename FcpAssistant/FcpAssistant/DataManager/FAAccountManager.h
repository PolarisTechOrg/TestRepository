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

@property(nonatomic,strong) FAStationAccount* currentMember;

-(void) Login:(NSString *) account  withPassword:(NSString *) password clientId:(NSString *) clientId;
@end
