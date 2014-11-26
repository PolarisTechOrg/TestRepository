//
//  PTErrorHelper.h
//  PolarisCtpDriver
//
//  Created by admin on 11/25/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTErrorHelper : NSObject

+(NSError*) getError:(NSString*)domain code:(NSInteger)code description:(NSString*)description;

@end
