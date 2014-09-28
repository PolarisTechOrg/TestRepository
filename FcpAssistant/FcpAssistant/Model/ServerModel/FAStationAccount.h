//
//  FAStationAccount.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-28.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAStationFundAccount.h"

@interface FAStationAccount : NSObject
//期顾账号
@property(nonatomic,copy) NSString *FcpAccount;
//实盘交易账户
@property(nonatomic,retain) FAStationFundAccount *RealFundAccount;
//仿真交易账户
@property(nonatomic,retain) FAStationFundAccount *SimulateFundAccount;
@end
