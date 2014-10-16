//
//  FAHttpHead.h
//  FcpAssistant
//
//  Created by admin on 9/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAHttpHead : NSObject
@property NSTimeInterval TimeOut;
@property NSString *Method;
@property NSDictionary *headeDic;

+(instancetype) defaultInstance;

- (FAHttpHead *)initDefault;

@end
