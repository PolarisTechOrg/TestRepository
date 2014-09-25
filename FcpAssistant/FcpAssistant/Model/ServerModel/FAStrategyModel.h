//
//  FAStrategyModel.h
//  FcpAssistant
//
//  Created by admin on 9/25/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAStrategyModel : NSObject

@property(nonatomic, assign) int StrategyId;

@property(nonatomic, copy) NSString *StrategyName;

@property(nonatomic, copy) NSString *UnderName;

@property(nonatomic, assign) int InitialAssets;

@property(nonatomic, copy) NSDate *UpdateTime;

@property(nonatomic, assign) int CollectionNumber;

@property(nonatomic, assign) int FollowNumber;

@property(nonatomic, assign) int Type;

@property(nonatomic, assign) int BuyLimit;

@property(nonatomic, assign) int BuyedQuantity;

@property(nonatomic, assign) double CumulativeReturnRatio;

@property(nonatomic, assign) double CumulativeNetProfit;

@property(nonatomic, retain) NSArray *RowVersion;

@property(nonatomic, copy) NSDate * PerformanceStartDay;

@property(nonatomic, assign) int ProviderId;

@property(nonatomic, copy) NSDate *CreateTime;

@property(nonatomic, assign) int MaxHoldings;

@property(nonatomic, assign) bool IsSpecified;

@property(nonatomic, assign) short IsOpen;

@property(nonatomic, assign) short TradingDirection;

@property(nonatomic, assign) short TransactionFrequency;

@property(nonatomic, assign) int CompanyId;

@property(nonatomic, assign) short Status;

@property(nonatomic, assign) short SignalPattern;

@end
