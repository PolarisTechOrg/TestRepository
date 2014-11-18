//
//  FAMessageDetailViewController.h
//  FcpAssistant
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAGeTuiReceiverDelegate.h"

@interface FAMessageDetailViewController : UITableViewController<FAGeTuiReceiverDelegate>
{
    NSString *itemHeaderCellIdentifier;
    NSString *itemCellIdentifier;
    
    NSMutableArray *dataSource;
    NSMutableDictionary *dataDictionary;
    NSMutableDictionary *deleteIndexDictionary;
    
    int totalSecitonIndex;
}

@property(nonatomic, copy) NSString *SendId;

@property(nonatomic, assign) int MessageType;

@property(nonatomic, assign) int MaxMessageId;

@end
