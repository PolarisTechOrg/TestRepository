//
//  FADummieStrategyDetailViewMode.h
//  FcpAssistant2
//
//  Created by admin on 9/9/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FADummieStrategyDetailViewModel : NSObject

@property(nonatomic, assign) int ProviderId;

@property(nonatomic, assign) NSString *ProviderName;

@property(nonatomic, assign) bool IsCertificated;

@property(nonatomic, assign) NSString *QQ;

@property(nonatomic, assign) NSString *Microblog;

@property(nonatomic, assign) int Star;

@property(nonatomic, assign) int AssessCount;

@property(nonatomic, assign) int AssessPersons;

@property(nonatomic, assign) short IsOpen;

@property(nonatomic, assign) short PricePatterns;

@property(nonatomic, assign) short TradingDirection;

@property(nonatomic, assign) short TransactionFrequency;

@property(nonatomic, assign) int InitialAssets;

@property(nonatomic, retain) NSArray *WinLoss;

@property(nonatomic, retain) NSArray *WinLosses;

@property(nonatomic, retain) NSArray *Events;

@end
