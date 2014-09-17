//
//  FAHttpUtility.h
//  FcpAssistant
//
//  Created by admin on 9/15/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAHttpHead.h"

@interface FAHttpUtility : NSObject

+ (NSData *)sendRequest:(NSString *)url withHead:(FAHttpHead *)head httpBody:(NSString *)body error:(NSError *)error;

@end
