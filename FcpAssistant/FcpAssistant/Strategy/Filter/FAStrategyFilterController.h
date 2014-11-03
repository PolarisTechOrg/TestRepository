//
//  FAStrategyFilterController.h
//  FcpAssistant
//
//  Created by admin on 11/3/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAStrategyController.h"
#import "FAStrategySearchDto.h"

@interface FAStrategyFilterController : UITableViewController
{
    NSString *itemHeaderCellIdentifier;
    NSString *itemCellIdentifier;
    
    NSMutableDictionary *selectPricePartenDict;
    NSMutableDictionary *selectVarietiesDict;
    
    NSMutableArray *dataCellArray;
    FAStrategySearchDto *searchDto;
}

@property NSMutableDictionary *pricePartenSource;

@property NSMutableDictionary *varietiesSource;

@property (nonatomic, retain) FAStrategyController *strategyController;

@end
