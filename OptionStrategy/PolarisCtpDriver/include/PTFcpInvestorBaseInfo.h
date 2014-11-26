//
//  PTFcpInvestorBaseInfo.h
//  OptionStrategy
//
//  Created by admin on 11/21/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTFcpEnums.h"

/// <summary>
/// 投资者帐户基本信息。
/// </summary>
@interface PTFcpInvestorBaseInfo : NSObject<NSCopying>

/// <summary>
/// 投资者帐号。
/// </summary>
@property NSString* Account;

/// <summary>
/// 经纪商ID。
/// </summary>
@property NSString* BrokerID;

/// <summary>
/// 经纪商名称。
/// </summary>
@property NSString* BrokerName;

/// <summary>
/// 身份证件类型。
/// </summary>
@property PTFcpIDCardType IdCardType;

/// <summary>
/// 身份证件号码。
/// </summary>
@property NSString* IdentifiedCardNo;

/// <summary>
/// 开户日期。
/// </summary>
@property NSDate* OpenDate;

/// <summary>
/// 手机。
/// </summary>
@property NSString* Mobile;

/// <summary>
/// 真实姓名。
/// </summary>
@property NSString* RealName;

@end
