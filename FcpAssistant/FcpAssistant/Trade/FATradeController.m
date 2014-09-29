//
//  FATradeController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FATradeController.h"
#import "FATradeViewCell.h"
#import "FAStoreManager.h"
#import "FAMyCollectController.h"
#import "FAMyPurchaseController.h"
#import "FAMyPositionController.h"
#import "FAMyOrderBookController.h"
#import "FAMySignalController.h"
#import "FAAccountManager.h"

@interface FATradeController ()

@end

@implementation FATradeController
{
NSString* itemCellIdentifier;
    NSMutableArray *dataSource;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];

    self.navigationItem.title = @"交易";
    self.tableView.sectionFooterHeight = 0.5;
    
    dataSource =[[FAStoreManager shareInstance] getTradeConfigArray];
}

-(void)initializeData
{
    itemCellIdentifier = @"faTradeItemCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FATradeViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//- (UITableView *)tableView
//{
//    self.view
//
//        CGRect tableViewFrame = self.view.bounds;
//        tableViewFrame.size.height -= (self.navigationController.viewControllers.count > 1 ? 0 : (CGRectGetHeight(self.tabBarController.tabBar.bounds))) + [XHFoundationCommon getAdapterHeight];
//        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:self.tableViewStyle];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        if (![self validateSeparatorInset]) {
//            if (self.tableViewStyle == UITableViewStyleGrouped) {
//                UIView *backgroundView = [[UIView alloc] initWithFrame:_tableView.bounds];
//                backgroundView.backgroundColor = _tableView.backgroundColor;
//                _tableView.backgroundView = backgroundView;
//            }
//        }
//    
//    return _tableView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FATradeViewCell * cell = (FATradeViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if(!cell)
    {
        cell = [[FATradeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    

    if(indexPath.section <dataSource.count)
    {
        NSDictionary * tradeDic = dataSource[indexPath.section];
        cell.logoImage.image = [UIImage imageNamed:[tradeDic valueForKey:@"image"][indexPath.row]];
        cell.menuLabel.text = [tradeDic valueForKey:@"title"][indexPath.row];
        cell.backgroundColor =  [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    
    
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
   }

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([FAAccountManager shareInstance].hasLogin == NO)
    {
        
        return;
    }
    
    
    if(indexPath.section ==0 && indexPath.row ==0)
    {
        [self pushNewViewController:[[FAMyCollectController alloc] init]];
    }
    else if(indexPath.section == 1 && indexPath.row ==0)
    {
        [self pushNewViewController:[[FAMyPurchaseController alloc] init]];
    }
    else if(indexPath.section == 2)
    {
        switch (indexPath.row)
        {
            case 0:
                [self  pushNewViewController:[[FAMyPositionController alloc] init]];
                break;
            case 1:
            {
                [self pushNewViewController:[[FAMyOrderBookController alloc] init]];
                break;
            }
            case 2:
            {
                [self pushNewViewController:[[FAMySignalController alloc] init]];
                break;
            }
            default:
                break;
        }
    }
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}

@end
