//
//  FAMessageController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAGeTuiReceiverDelegate.h"

@interface FAMessageController : UITableViewController<FAGeTuiReceiverDelegate>
{
    NSString *itemCellIdentifier;
    
    NSMutableArray *dataSource;
    
    NSMutableDictionary *dataDictionary;
}

@property(nonatomic, assign) int unReadCount;

@property(nonatomic, assign) int maxMessageId;

@end
