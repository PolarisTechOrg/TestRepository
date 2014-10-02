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
    NSString *itemCellIdentifier;
    
    NSArray *dataSource;
    
    int totalSecitonIndex;
}

@property(nonatomic, assign) int SendId;

@property(nonatomic, assign) int MessageType;

@end
