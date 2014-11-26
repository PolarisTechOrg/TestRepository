//
//  PTQuoteTableViewController.h
//  OptionStrategy
//
//  Created by user01 on 11/24/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTCtpSpiHandlerDelegate.h"

@interface PTQuoteTableViewController : UITableViewController<PTCtpSpiHandlerDelegate>
{
    NSString *itemTableCellIdentifier;
    @private NSMutableDictionary *tableViewCellArray;
    @private NSArray *quoteArray;
}

@end
