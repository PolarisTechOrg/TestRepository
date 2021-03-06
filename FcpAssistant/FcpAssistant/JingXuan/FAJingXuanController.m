//
//  FAJingXuanController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAJingXuanController.h"
#import "FAJingXuanViewCell.h"
#import "FAMyCollectItem.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FAChartDto.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"
#import "FAUtility.h"
#import "FAGeTuiReceiver.h"
@interface FAJingXuanController ()

@end

@implementation FAJingXuanController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"精选";
    
    self.tableView.sectionFooterHeight = 0.1;
    [self loadDataFromServer];
    [self loadChartData:chartIdArray];
    
    [[FAGeTuiReceiver shareInstance] registerMessageReceiver:self];
}

- (void)initializeData
{
    itemCellIdentifier = @"JingXuaViewCell";
}

- (void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAJingXuanViewCell" bundle:nil];
    
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)receivePushMessage:(NSString *)message
{
    NSLog(@"ReceiveMessage:%@",message);
}
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
            NSString *requestStr =[NSString stringWithFormat:@"%@api/ChartData?strategyId=%d&splitDot=%d&lineBorder=%d&width=%d",WEB_URL,item.StrategyId,30,1,118];
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

-(void)loadDataFromServer
{
    chartIdArray = [NSMutableArray arrayWithCapacity:64];
    
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?jingXuan", WEB_URL];
    NSURL * requestUrl = [NSURL URLWithString: requestUrlStr];
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    if(error == nil)
    {
        dataSourceJingXuan = [FAJSONSerialization toArray:[FADummieStrategyDetailViewModel class] fromData:replyData];
        if(dataSourceJingXuan.count > 0)
        {
            [chartIdArray addObjectsFromArray:dataSourceJingXuan];
        }
    }
    replyData = nil;
    error = nil;
    requestUrl = nil;
    requestUrlStr = nil;
    
    requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?priceParten=1", WEB_URL];
    requestUrl = [NSURL URLWithString: requestUrlStr];
    replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    if(error == nil)
    {
        dataSourceQuShi = [FAJSONSerialization toArray:[FADummieStrategyDetailViewModel class] fromData:replyData];
        if(dataSourceQuShi.count > 0)
        {
            [chartIdArray addObjectsFromArray:dataSourceQuShi];
        }
    }
    replyData = nil;
    error = nil;
    requestUrl = nil;
    requestUrlStr = nil;
    
    requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?priceParten=2", WEB_URL];
    requestUrl = [NSURL URLWithString: requestUrlStr];
    replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    if(error == nil)
    {
        dataSourceNiShi = [FAJSONSerialization toArray:[FADummieStrategyDetailViewModel class] fromData:replyData];
        if(dataSourceNiShi.count > 0)
        {
            [chartIdArray addObjectsFromArray:dataSourceNiShi];
        }
    }
    replyData = nil;
    error = nil;
    requestUrl = nil;
    requestUrlStr = nil;
    
    requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?priceParten=3", WEB_URL];
    requestUrl = [NSURL URLWithString: requestUrlStr];
    replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    if(error == nil)
    {
        dataSoruceTaoLi = [FAJSONSerialization toArray:[FADummieStrategyDetailViewModel class] fromData:replyData];
        if(dataSoruceTaoLi.count > 0)
        {
            [chartIdArray addObjectsFromArray:dataSoruceTaoLi];
        }
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

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 1;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 192;
}

//- (void)enterDetailView
//{
//}

- (void)settingCell:(FAJingXuanViewCell *)cell fromData:(NSArray *)data
{
    FADummieStrategyDetailViewModel *jingxuan = (FADummieStrategyDetailViewModel *)data[0];
    cell.strategyId1 = jingxuan.StrategyId;
    [cell.btnStrategyName1 setTitle:jingxuan.StrategyName forState:UIControlStateNormal];
    [cell.btnStrategyName1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    int star = (int)ceil(jingxuan.Star);
    NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
    cell.imgStrategyStar1.image = [UIImage imageNamed:gradeImageName];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    cell.lblUpdateDate1.text = [dateFormat stringFromDate:jingxuan.OnlineDay];
    cell.lblStrategyStatus1.text = (jingxuan.OnlineDay == nil) ? nil : @"上架";
    cell.lblCollectionPeople1.text = [[NSString alloc] initWithFormat:@"%d", jingxuan.FollowNumber];
    cell.lblProviderName1.text = jingxuan.ProviderName;
    cell.lblPerformanceNumber1.text = [NSString stringWithFormat:@"%.1f%%",jingxuan.CumulativeReturnRatio];
    
    [self setProfitBackMap:jingxuan.CumulativeReturnRatio inCell:cell];
    FAChartDto *chartDto = [chartDic objectForKey:[NSString stringWithFormat:@"%d",jingxuan.StrategyId]];
    if (chartDto !=nil && chartDto.Items.count >0)
    {
        cell.profitChartDto1 = chartDto;
        cell.imgStrategyProfit.dataSource = chartDto.Items;
    }
    else
    {
        cell.imgStrategyProfit.dataSource = nil;
    }
    [cell.imgStrategyProfit setNeedsDisplay];
    
    FADummieStrategyDetailViewModel *jingxuan2 = (FADummieStrategyDetailViewModel *)data[1];
    cell.strategyId2 = jingxuan2.StrategyId;
    cell.profitChartDto2 = [chartDic objectForKey:[NSString stringWithFormat:@"%d",jingxuan2.StrategyId]];
    [cell.btnStrategyName2 setTitle:jingxuan2.StrategyName forState:UIControlStateNormal];
    cell.lblCollectionPeople2.text = [[NSString alloc] initWithFormat:@"%d", jingxuan2.CollectionNumber];
    
    FADummieStrategyDetailViewModel *jingxuan3 = (FADummieStrategyDetailViewModel *)data[2];
    cell.strategyId3 = jingxuan3.StrategyId;
    cell.profitChartDto3 = [chartDic objectForKey:[NSString stringWithFormat:@"%d",jingxuan3.StrategyId]];
    [cell.btnStrategyName3 setTitle:jingxuan3.StrategyName forState:UIControlStateNormal];
    cell.lblCollectionPeople3.text = [[NSString alloc] initWithFormat:@"%d", jingxuan3.CollectionNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    FAJingXuanViewCell *cell = (FAJingXuanViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    // Configure the cell...
    if(!cell)
    {
        cell = [[FAJingXuanViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    cell.navigationController = self.navigationController;  // refer navigation

    switch (indexPath.row)
    {
        case 0:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_01"];
            cell.lblTitle.text = @"策略精选";
            
            [self settingCell:cell fromData:dataSourceJingXuan];
        }
            break;
            
        case 1:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_02"];
            cell.lblTitle.text = @"趋势策略";

            [self settingCell:cell fromData:dataSourceQuShi];
        }
            break;
            
        case 2:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_03"];
            cell.lblTitle.text = @"逆势策略";
            
            [self settingCell:cell fromData:dataSourceNiShi];
        }
            break;
            
        case 3:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_04"];
            cell.lblTitle.text = @"套利策略";
            
            [self settingCell:cell fromData:dataSoruceTaoLi];
        }
            break;
            
        default:
            break;
    }
    
    [cell initialNameIdDictionary]; // NameIdDictionary
    
    return cell;
}

- (void)setProfitBackMap:(double)profit inCell:(FAJingXuanViewCell *)cell
{
    if (profit > 0)
    {
        cell.imgPerformanceBackMap1.image = [UIImage imageNamed:@"mycollect_profit_red.png"];
        cell.imgStrategyProfit.backgroundColor = [UIColor colorWithRed:255.0/255 green:218.0/255 blue:210.0/255 alpha:1.0];
        cell.imgStrategyProfit.profitLineColor = [UIColor colorWithRed:204.0/255 green:3.0/255 blue:3.0/255 alpha:1.0];
    }
    else if (profit < 0)
    {
        cell.imgPerformanceBackMap1.image = [UIImage imageNamed:@"mycollect_profit_green.png"];
        cell.imgStrategyProfit.backgroundColor = [UIColor colorWithRed:240.0/255 green:255.0/255 blue:210.0/255 alpha:1.0];
        cell.imgStrategyProfit.profitLineColor = [UIColor colorWithRed:2.0/255 green:71.0/255 blue:2.0/255 alpha:1.0];
    }
    else
    {
        cell.imgPerformanceBackMap1.image = [UIImage imageNamed:@"mycollect_profit_yellow.png"];
        cell.imgStrategyProfit.backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:204.0/255 alpha:1.0];
        cell.imgStrategyProfit.profitLineColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    }
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
