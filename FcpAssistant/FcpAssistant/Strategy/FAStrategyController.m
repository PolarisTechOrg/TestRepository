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

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"

@interface FAStrategyController ()

@end

@implementation FAStrategyController

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
    
    dataSource = [[NSMutableArray alloc] init];
    NSArray *strategyList = [self LoadDataFromServer];
    if(strategyList != nil && strategyList.count > 0)
    {
        [dataSource addObjectsFromArray:strategyList];
    }
}

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

-(NSArray *)LoadDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?strategyName=&racerType=1&onlineStatus=1&isOpen=&tradingDirection=&transactionFrequency=&tradeType=&winningProbability=&pageSize=10&pageIndex=1", WEB_URL];
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    FAStrategyDetailController * detailController = [[FAStrategyDetailController alloc] init];
    detailController.strategyId = strategyId;
    
    [self.navigationController pushViewController:detailController animated:YES];
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
        
        NSString* profitBackgroundImageName = @"mycollect_profit_red";
        cell.imgPerformanceBackMap.image = [UIImage imageNamed:profitBackgroundImageName];
        
        NSString* profitLineImageName = @"tmp_collect_profit_red";
        cell.imgPerformanceMap.image = [UIImage imageNamed:profitLineImageName];
        
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FADummieStrategyDetailViewModel *item = dataSource[indexPath.row];
    [self enterDetailView:item.StrategyId];
}

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
