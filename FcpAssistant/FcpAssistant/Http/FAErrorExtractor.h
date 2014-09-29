//
//  FAErrorExtractor.h
//  FcpAssistant
//
//  Created by admin on 9/28/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAErrorExtractor : NSObject

+ (void)fromResponse: (NSURLResponse *) response data:(NSData *)data toError:(NSError **)error;

@end


