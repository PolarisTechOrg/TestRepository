//
//  FAStrategySearchController.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategySearchController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *listTeams;
@property (nonatomic, strong) NSMutableArray *listFilterTeams;

@property (weak, nonatomic) IBOutlet UISearchBar *barStrategySearch;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;
@end
