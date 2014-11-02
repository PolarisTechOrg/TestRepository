//
//  FAStrategyFilterControllerTableViewController.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategyFilterController : UITableViewController
{
    NSString *itemHeaderCellIdentifier;
    NSString *itemCellIdentifier;
    
    NSMutableDictionary *selectPricePartenDict;
    NSMutableDictionary *selectVarietiesDict;
}


@property NSMutableDictionary *pricePartenSource;

@property NSMutableDictionary *varietiesSource;

@end
