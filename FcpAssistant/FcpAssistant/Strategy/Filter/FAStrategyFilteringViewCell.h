//
//  FAStrategyFilterViewCell.h
//  FcpAssistant
//
//  Created by admin on 11/3/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategyFilteringViewCell : UITableViewCell

@property NSMutableDictionary *pricePartenSource;

@property NSMutableDictionary *varietiesSource;

@property UITableView *parentTableView;

- (void)fillingData;

- (NSMutableArray *)searchPricePartenList;

- (NSMutableArray *)searchVarietiesList;

@end
