//
//  FAMyPurchaseDetailController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FAMyPurchaseDetailController : UITableViewController

{
    NSString *topCellIdentifier;
    NSString *positionCellIdentifier;
    NSString *signalCellIdentifier;
    NSString *orderCellIdentifier;
    NSString *profitCellIdentifier;
}

//策略ID
@property(nonatomic,assign) int strategyId;


@end
