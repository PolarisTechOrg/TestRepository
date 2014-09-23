//
//  FAUnderlyingViewModel.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-23.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAUnderlyingViewModel : NSObject
// 策略标的（品种）名称。
@property(nonatomic,copy) NSString *UnderName;
// 策略标的ID。
@property(nonatomic,assign) int UnderId;
// 交易代码。
@property(nonatomic,copy) NSString *UnderCode;
// 交易品种分类，1、金融期货，2、贵金属，3、农产品，4、工业品，5、能源类，6、有色金属，7、钢材。
@property(nonatomic,assign) NSCharacterSet *UnderType;
@end
