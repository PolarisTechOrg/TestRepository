//
//  FAHttpHead.h
//  FcpAssistant
//
//  Created by admin on 9/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAHttpHead : NSObject
{
    @public
    NSTimeInterval TimeOut;
    NSString *Method;
}

@property NSTimeInterval TimeOut;
@property NSString *Method;


- (FAHttpHead *)initDefault;

@end
