//
//  FAStrategyController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyController.h"
#import "FAStrategyInfoViewCell.h"
#import "FAStrategyDetailController.h"
#import "FAPaginatedDto.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FAStrategySearchController.h"
#import "FAStrategyFilterController.h"
#import "MJRefresh.h"
#import "FAChartDto.h"
#import "FADrawedReturnViewModel.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FAWinLossViewModel.h"

#import "FAQueue.h"
#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"
#import "FAUtility.h"

@interface FAStrategyController ()

@end

@implementation FAStrategyController

#pragma mark - custom function
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"策略";
    
    UIImage *searchButtonImage = [UIImage imageNamed:@"Strategy_icon_strategy_search_white"];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:searchButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(doSearch)];
    
    UIImage *filterButtonImage = [UIImage imageNamed:@"Strategy_icon_strategy_menu_white"];
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithImage:filterButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(doFilter)];

    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:filterButton, searchButton, nil];
    
    // Load data
    currentPageIndex = 1;
    
    dataSource = [[NSMutableArray alloc] init];
    NSArray *strategyList = [self loadDataFromServer:currentPageIndex];
    if(strategyList != nil && strategyList.count > 0)
    {
        [dataSource addObjectsFromArray:strategyList];
    }
    
//    [self initialChartIdArray:dataSource];
    [self loadChartData:dataSource];
    
    [self setupRefresh];
}

/*
// fill chart
- (void)loadChartData
{
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithCapacity:36];
    
    
    [self performSelectorOnMainThread:@selector(fillStrategyProfit:) withObject:dataDict waitUntilDone:NO];
}

- (void)fillStrategyProfit:(NSDictionary *)dict
{
}

- (void)setupThread:(NSArray *)userInfo
{
    // enqueue
    
    [self performSelectorInBackground:@selector(loadChartData) withObject:nil];
}
 */

// refresh
- (void)setupRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)footerRereshing
{
    // 添加新数据
    currentPageIndex++;
    
    NSArray *strtegyList = [self loadDataFromServer:currentPageIndex];
    if(strtegyList != nil && strtegyList.count > 0)
    {
        [dataSource addObjectsFromArray:strtegyList];
        [self loadChartData:dataSource];
    }
    
    // 刷新表格UI
    [self.tableView reloadData];
    
    // (在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}

// initial view
- (void)doSearch
{
    FAStrategySearchController *controller = [[FAStrategySearchController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)doFilter
{
    FAStrategyFilterController *controller = [[FAStrategyFilterController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)initializeData
{
    itemCellIdentifier = @"StrategyViewCell";
}

- (void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAStrategyInfoViewCell" bundle:nil];
    
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

// load data
- (NSArray *)loadDataFromServer:(int)pageIndex
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?strategyName=&racerType=1&onlineStatus=1&isOpen=&tradingDirection=&transactionFrequency=&tradeType=&winningProbability=&pageSize=5&pageIndex=%@", WEB_URL, [NSNumber numberWithInt:pageIndex]];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        FAPaginatedDto *dtoObj =[FAJSONSerialization toObject:[FAPaginatedDto class] fromData:replyData];
        
        return  dtoObj.Items;
    }
    else
    {
        return nil;
    }
}

//- (NSMutableArray *)initialChartIdArray:(NSArray *)strategyArray
//{
//    if(strategyArray == nil || strategyArray.count == 0)
//    {
//        return nil;
//    }
//    
//    chartIdArray = [NSMutableArray arrayWithCapacity:64];
//    
//    for (FADummieStrategyDetailViewModel *item in strategyArray)
//    {
//        if (item == nil)
//        {
//            continue;
//        }
//        [chartIdArray addObject:[NSNumber numberWithInt:item.StrategyId]];
//    }
//    
//    return chartIdArray;
//}

-(void) loadChartData:(NSArray *) strategies
{
    chartDic = [[NSMutableDictionary alloc]initWithCapacity:10];
    
    if(strategies == nil || strategies.count <=0)
    {
        return;
    }
    
    for (FADummieStrategyDetailViewModel *item in strategies)
    {
        
        @try
        {
            NSString *requestStr =[NSString stringWithFormat:@"%@api/ChartData?strategyId=%d&splitDot=%d&lineBorder=%d&width=%d",WEB_URL,item.StrategyId,3,6,118];
            NSURL * requestUrl =[NSURL URLWithString:requestStr];
            
            NSError *error;
            NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
            
            if(error == nil)
            {
                FAChartDto *dtoObj =[FAJSONSerialization toObject:[FAChartDto class] fromData:replyData];
                [chartDic setValue:dtoObj forKey:[NSString stringWithFormat:@"%d",item.StrategyId]];
                
            }
            else
            {
                NSException *ex = [[NSException alloc] initWithName:@"JingXuanException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
                @throw ex;
            }
        }
        @catch (NSException *exception)
        {
            [FAUtility showAlterViewWithException:exception];
        }
        @finally
        {
            
        }
    }    
}

//- (NSArray *)loadChartDataFromServer:(int)strategyId splitDot:(int)split lineBorder:(int)border wholeWidth:(int)width
//{
//    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/chartdata?strategyId=%d&splitDot=%d&lineBorder=%d&width=%d", WEB_URL, strategyId, split, border, width];
//    
//    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
//    
//    NSError *error;
//    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
//    
//    if(error == nil)
//    {
//        FAChartDto *dtoObj =[FAJSONSerialization toObject:[FAChartDto class] fromData:replyData];
//        
//        return  dtoObj.Items;
//    }
//    else
//    {
//        return nil;
//    }
//}

#pragma mark - Table view data source
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (void)enterDetailView:(int) strategyId
{
}

- (UIImage *)GetProfitBackMap:(double)profit
{
    if (profit > 0)
    {
        return [UIImage imageNamed:@"mycollect_profit_red.png"];
    }
    else if (profit < 0)
    {
        return [UIImage imageNamed:@"mycollect_profit_green.png"];
    }
    else
    {
        return [UIImage imageNamed:@"mycollect_profit_yellow.png"];
    }
}

- (void)setProfitBackMap:(double)profit inCell:(FAStrategyInfoViewCell *)cell
{
    if (profit > 0)
    {
        cell.imgPerformanceBackMap.image = [UIImage imageNamed:@"mycollect_profit_red.png"];
        cell.imgStrategyProfit.backgroundColor = [UIColor colorWithRed:255.0/255 green:218.0/255 blue:210.0/255 alpha:1.0];
        cell.imgStrategyProfit.profitLineColor = [UIColor colorWithRed:204.0/255 green:3.0/255 blue:3.0/255 alpha:1.0];
    }
    else if (profit < 0)
    {
        cell.imgPerformanceBackMap.image = [UIImage imageNamed:@"mycollect_profit_green.png"];
        cell.imgStrategyProfit.backgroundColor = [UIColor colorWithRed:240.0/255 green:255.0/255 blue:210.0/255 alpha:1.0];
        cell.imgStrategyProfit.profitLineColor = [UIColor colorWithRed:2.0/255 green:71.0/255 blue:2.0/255 alpha:1.0];
    }
    else
    {
        cell.imgPerformanceBackMap.image = [UIImage imageNamed:@"mycollect_profit_yellow.png"];
        cell.imgStrategyProfit.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:204.0/255 alpha:1.0];
        cell.imgStrategyProfit.profitLineColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAStrategyInfoViewCell *cell = (FAStrategyInfoViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    // Configure the cell...
    if(!cell)
    {
        cell = [[FAStrategyInfoViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    if (indexPath.row < dataSource.count)
    {
        FADummieStrategyDetailViewModel  *item = dataSource[indexPath.row];
        
        cell.StrategyId = item.StrategyId;
        
//        cell.imgPerformanceBackMap.image = [self GetProfitBackMap:item.CumulativeReturnRatio];
        [self setProfitBackMap:item.CumulativeReturnRatio inCell:cell];
        
//        NSString* profitLineImageName = @"tmp_collect_profit_red";
//        cell.imgPerformanceMap.image = [UIImage imageNamed:profitLineImageName];
        FAChartDto *chartDto = [chartDic objectForKey:[NSString stringWithFormat:@"%d",item.StrategyId]];
        if (chartDto !=nil && chartDto.Items.count >0)
        {
            cell.imgStrategyProfit.dataSource = chartDto.Items;
        }
        else
        {
            cell.imgStrategyProfit.dataSource = nil;
        }
        [cell.imgStrategyProfit setNeedsDisplay];
        
        cell.lblPerformance.text = [NSString stringWithFormat:@"%.1f%%",item.CumulativeReturnRatio *100];
        
        cell.lblStrategyName.text = item.StrategyName;
        
        if(item.InWishList)
        {
            cell.imgStrategyMarked.image = [UIImage imageNamed:@"common_collect_flag.png"];
        }
        
        int star = (int)ceil(item.Star);
        NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
        cell.imgStrategyStar.image = [UIImage imageNamed:gradeImageName];
        
        cell.lblCollectionPeopleNumber.text = [NSString stringWithFormat:@"%d", item.FollowNumber];
        
        cell.lblProvider.text = item.ProviderName;
    }
    
    return cell;
}

- (NSArray *)sortWinLosses:(NSArray *)winLosses
{
    if(winLosses == nil || winLosses.count == 0)
    {
        return nil;
    }
    
    ProfitType preProfit = Unknown; // 确保数组能够初始化
    ProfitType curProfit = Unknown;
    unsigned long length = winLosses.count;
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:64];
    NSMutableArray *sortedNestArray;
    
    for (unsigned long i = 0; i < length; i++)
    {
        FAWinLossViewModel *item = (FAWinLossViewModel *)winLosses[i];
        if (item == nil)
        {
            continue;
        }
        
        if (item.Profit > 0)
        {
            curProfit = Profit;
        }
        else if (item.Profit < 0)
        {
            curProfit = Loss;
        }
        else
        {
            curProfit = Balance;
        }
        
        if(curProfit == preProfit && sortedNestArray.count < 8)
        {
            [sortedNestArray addObject:item];
        }
        else
        {
            sortedNestArray = [NSMutableArray arrayWithCapacity:32];
            [sortedNestArray addObject:item];
            [sortedArray addObject:sortedNestArray];
        }
        preProfit = curProfit;
    }
    
    if (sortedArray.count > 8) {
        NSRange range = NSMakeRange(sortedArray.count - 8, 8);
        sortedArray = [sortedArray subarrayWithRange:range];
    }
    
    return sortedArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FADummieStrategyDetailViewModel *item = dataSource[indexPath.row];
    
    FAStrategyDetailController * detailController = [[FAStrategyDetailController alloc] init];
    detailController.strategyId = item.StrategyId;
    detailController.profitCharDto = [chartDic valueForKey:[NSString stringWithFormat:@"%d", item.StrategyId]];
    detailController.latedWinlosses = [self sortWinLosses:item.WinLosses];
    
    [self.navigationController pushViewController:detailController animated:YES];
}

// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        FADummieStrategyDetailViewModel* item = dataSource[indexPath.row];
//        if([self deleteMessageItem:item.StrategyId] == YES)
//        {
//            [dataSource removeObject:item];
//            // Delete the row from the data source
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        }
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert)
//    {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

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
