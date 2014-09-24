//
//  FAMyPurchaseController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-5.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyPurchaseController.h"
#import "FAMyPurchaseDetailController.h"
#import "FAMyPurchaseViewCell.h"
#import "FABuyedStrategyDto.h"
#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"

@interface FAMyPurchaseController ()

@end

@implementation FAMyPurchaseController


// test
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"订购";

    
    dataSource = [[NSMutableArray alloc] init ];
    
    NSArray *buyedList = [self LoadDataFromServer];
    if(buyedList != nil && [buyedList count] >0)
    {
        [dataSource addObjectsFromArray:buyedList];
    }
}

-(void)initializeData
{
    itemCellIdentifier = @"purchaseViewCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMyPurchaseViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

-(NSArray *) LoadDataFromServer
{
    NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/BuyedStrategyList?fundAccount=%@&fundAcccountType=%@",WEB_URL,@"100146",@"33"];
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];

    
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:error];
    
    if(error == nil)
    {
        NSArray *dtoObj =[FAJSONSerialization toArray:[FABuyedStrategyDto class] fromData:replyData];
        
        return  dtoObj;
        
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (void)enterDetailView:(int) combineStrategyId strategyId:(int) strategyId
{
    FAMyPurchaseDetailController * detailController = [[FAMyPurchaseDetailController alloc] init];
    detailController.strategyId = strategyId;
    detailController.combineStrategyId = combineStrategyId;
    
    [self.navigationController pushViewController:detailController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMyPurchaseViewCell *cell = (FAMyPurchaseViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMyPurchaseViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    if (indexPath.row < dataSource.count)
    {
        FABuyedStrategyDto  *item = dataSource[indexPath.row];
        cell.lblStrategyName.text = item.StrategyName;
        
        cell.lblProfit.text = [FAFormater toDecimalStringWithDouble:item.TodayProfit decimalPlace:2];
        
        NSString* profitBackgroundImageName =@"mypurchase_profit_yellow.png";
        if(item.TodayProfit >0)
        {
            profitBackgroundImageName =@"mypurchase_profit_red.png";
        }
        else if(item.TodayProfit <0)
        {
            profitBackgroundImageName = @"mypurchase_profit_green.png";
        }
        cell.imgProfitBackground.image = [UIImage imageNamed:profitBackgroundImageName];
        
        if(item.CombineStrategyId >0)
        {
            cell.imgSignalOrCombineFlag.image = [UIImage imageNamed:@"common_combineStrategy.png"];
        }
        else
        {
            cell.imgSignalOrCombineFlag.image = [UIImage imageNamed:@"common_singleStrategy.png"];
        }
        
        int star = (int)ceil(item.Star);
        NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
        NSLog(@"gradeImageName:%@",gradeImageName);
        cell.imgStrategyGrade.image = [UIImage imageNamed:gradeImageName];
        
        //持仓标记图片，未完成
        cell.lblPurchaseDate.text =[FAFormater toShortDateStringWithNSDate:item.BuyedTime];
        cell.lblMultipleCount.text =[NSString stringWithFormat:@"%d",item.BuyedQuantity];
        cell.lblTodaySignalCount.text = [NSString stringWithFormat:@"%d",10];

    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FABuyedStrategyDto  *item = dataSource[indexPath.row];
    
    [self enterDetailView:item.CombineStrategyId strategyId:item.StrategyId];
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
