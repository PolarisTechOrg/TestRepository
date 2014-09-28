//
//  FAStationFundAccount.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStationFundAccount : NSObject
// 交易帐号。
@property(nonatomic,copy) NSString *FundAccount;
// 交易帐号类型。
@property(nonatomic,assign) int FundAccountType;
@end
