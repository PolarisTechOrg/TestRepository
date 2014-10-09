//
//  FAFillingProfile.h
//  FcpAssistant
//
//  Created by admin on 10/9/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAFillingProfileOperation : NSOperation
{
    NSArray *strategyIdArray;
}

- (id)initWithStrategyIdArray:(NSArray *)array;

@end
