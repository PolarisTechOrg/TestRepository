//
//  FAStoreManager.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-5.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStoreManager : NSObject

+(instancetype) shareInstance;

-(NSMutableArray *) getTradeConfigArray;

- (NSMutableArray *)getMoreConfigureArray;

@end

//@interface XHStoreManager : NSObject

//+ (instancetype)shareStoreManager;

//- (NSMutableArray *)getDiscoverConfigureArray;
//
//- (NSMutableArray *)getContactConfigureArray;
//
//- (NSMutableArray *)getAlbumConfigureArray;
//
//- (NSMutableArray *)getProfileConfigureArray;
//
//- (NSMutableArray *)getLocationServiceArray;
//
//- (NSMutableArray *)getSettingConfigureArray;

//@end