//
//  PTCommonIdCreator.h
//  OptionStrategy
//
//  Created by admin on 11/17/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTCommonIdCreator : NSObject

- (instancetype)init;
-(int) next;
-(void) set:(int) currentId;

@end
