//
//  FAStrategyDetailController.h
//  FcpAssistant
//
//  Created by admin on 9/23/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategyDetailController : UITableViewController
{
    NSString *topCellIdentifier;
    NSString *describCellIdentifier;
    NSString *profitCellIdentifier;
    NSString *latedRecordCellIdentifier;
}

//策略ID
@property(nonatomic,assign) int strategyId;

@end
