//
//  FAJingXuanController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAGeTuiReceiverDelegate.h"

@interface FAJingXuanController : UITableViewController<FAGeTuiReceiverDelegate>
{
    NSArray *dataSourceJingXuan;
    NSArray *dataSourceQuShi;
    NSArray *dataSourceNiShi;
    NSArray *dataSoruceTaoLi;
    
    NSString* itemCellIdentifier;
    
    NSDictionary *chartDic;
    NSMutableArray *chartIdArray;
}

@end
