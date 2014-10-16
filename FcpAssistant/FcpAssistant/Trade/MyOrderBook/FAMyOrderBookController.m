//
//  FAMyOrderBookController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyOrderBookController.h"
#import "FAMyOrderBookItemHeaderView.h"
#import "FAMyOrderBookItemViewCell.h"
#import "FAAccountManager.h"
#import "FAFoundation.h"
#import "FAHttpHead.h"
#import "FAHttpUtility.h"
#import "FAJSONSerialization.h"
#import "FAUtility.h"
#import "FAStrategyOrderBookDto.h"
#import "FAMyOrderBookDto.h"
#import "FAFormater.h"
#import "FAMyOrderBookItemHeaderView.h"

@interface FAMyOrderBookController ()

@end

@implementation FAMyOrderBookController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    self.navigationItem.title = @"委托";
    self.tableView.sectionFooterHeight = 0;
    
    dataSource = [[NSMutableArray alloc] init ];
    
    NSArray *orderBookList = [self LoadDataFromServer];
    if(orderBookList != nil && [orderBookList count] >0)
    {
        [dataSource addObjectsFromArray:orderBookList];
    }
}


-(void)initializeData
{
    itemCellIdentifier = @"myOrderBookItemCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMyOrderBookItemViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

-(NSArray *) LoadDataFromServer
{
    FAStationFundAccount *selectFundAccount = [FAAccountManager shareInstance].selectFundAccount;
    
    if(selectFundAccount == nil)
    {
        return [[NSArray alloc]init];
    }
    
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/MyTrade?orderBook=&fundAccount=%@&fundAccountType=%d",WEB_URL,selectFundAccount.FundAccount,selectFundAccount.FundAccountType];
        NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
        
        if(error == nil)
        {
            NSArray *dtoObj =[FAJSONSerialization toArray:[FAMyOrderBookDto class] fromData:replyData];
            return  dtoObj;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"MyOrderBookExeption" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
            @throw ex;
        }
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
        return nil;
    }
    @finally
    {
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FAMyOrderBookDto *dto = dataSource[section];
    return dto.Detail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    FAMyOrderBookItemViewCell* cell= (FAMyOrderBookItemViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMyOrderBookItemViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    if (indexPath.section < dataSource.count)
    {
        FAMyOrderBookDto *myOrderBook = dataSource[indexPath.section];
        FAStrategyOrderBookDto *item = myOrderBook.Detail[indexPath.row];
        
        cell.lblInstrumentCode.text = item.InstrumentCode;
        cell.lblOrderQtyAndTradeQty.text = [[NSString alloc] initWithFormat:@"%d/%d",item.TradeQty,item.OrderQty];
        cell.lblTradePrice.text = [FAFormater toDecimalStringWithDouble:item.TradePrice decimalPlace:2];
        cell.lblOrderStatus.text = @"";
        cell.lblOrderTime.text = [FAFormater toShortTimeStringWithNSDate:item.OrderTime];
        cell.indentationWidth =0;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 73;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.	tableView)
    {
        CGFloat sectionHeaderHeight = 73; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMyOrderBookItemHeaderView" owner:self options:nil];
    
    FAMyOrderBookItemHeaderView *headView = (FAMyOrderBookItemHeaderView *)[nib objectAtIndex:0];
    if (section < dataSource.count)
    {
        FAMyOrderBookDto *myOrderBook = dataSource[section];
        headView.lblHeaderName.text = myOrderBook.Description;
    }
    
    return headView;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
