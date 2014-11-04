//
//  FAStrategySearchController.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAStrategyController.h"
#import "FAStrategySearchDto.h"

@interface FAStrategySearchController : UITableViewController <UISearchBarDelegate,  UISearchDisplayDelegate, UITextFieldDelegate, UITextViewDelegate>
{
    NSString *itemHeaderCellIdentifier;
    NSString *itemCellIdentifier;
    
    FAStrategyController *strategyController;
    FAStrategySearchDto *searchDto;
}

@property (nonatomic, strong) NSMutableArray *listTeams;

@property (weak, nonatomic) IBOutlet UISearchBar *barStrategySearch;

@property (nonatomic, retain) FAStrategyController *strategyController;

@end
