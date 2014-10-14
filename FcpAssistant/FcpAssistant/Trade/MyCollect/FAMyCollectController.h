//
//  FAMyCollectController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAPurchaseProfitView.h"

@interface FAMyCollectController : UITableViewController
{
//TableViewCell标识符
@private NSString* itemCellIdentifier;
//策略信息
@private NSMutableArray *dataSource;
//策略损益数据
@private NSDictionary *chartDic;
//订购策略
@private NSDictionary *purchaseDic;
}

@end
