//
//  FAStrategySearchController.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategySearchController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITextFieldDelegate>
{
    NSString *itemHeaderCellIdentifier;
    NSString *itemCellIdentifier;
}

@property (nonatomic, strong) NSMutableArray *listTeams;

@property (weak, nonatomic) IBOutlet UISearchBar *barStrategySearch;

@end
