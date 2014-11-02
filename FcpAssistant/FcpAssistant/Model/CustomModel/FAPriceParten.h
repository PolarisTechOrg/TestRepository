//
//  FAPriceParten.h
//  FcpAssistant
//
//  Created by admin on 11/2/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAPriceParten : NSObject

@property (nonatomic, assign) int PartenID;

@property (nonatomic, copy) NSString *PartenName;

@property (nonatomic, assign) BOOL includeFlag;

@property (nonatomic, assign) int seqId;

@end
