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

+ (NSData *)sendRequest:(NSURL *)url error:(NSError **)error;

+ (NSData *)sendRequest:(NSURL *)url withHead:(FAHttpHead *)head httpBody:(id)body error:(NSError **)error;
+ (NSData *)sendRequestForReponse:(NSURL *)url withHead:(FAHttpHead *)head httpBody:(id)body error:(NSError **)error replyResponse:(NSURLResponse **)replyResponse;

@end
