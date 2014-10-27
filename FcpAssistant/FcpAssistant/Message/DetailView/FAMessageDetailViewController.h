//
//  FAMessageDetailViewController.h
//  FcpAssistant
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMessageDetailViewController : UITableViewController
{
    NSString *itemHeaderCellIdentifier;
    NSString *itemCellIdentifier;
    
    NSArray *dataSource;
    
    int totalSecitonIndex;
}

@property(nonatomic, copy) NSString *SendId;

@property(nonatomic, assign) int MessageType;

@end
