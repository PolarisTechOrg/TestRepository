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

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"

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

-(void)loadDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?jingXuan", WEB_URL];
    NSURL * requestUrl = [NSURL URLWithString: requestUrlStr];
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    if(error == nil)
    {
        dataSourceJingXuan = [FAJSONSerialization toArray:[FADummieStrategyDetailViewModel class] fromData:replyData];
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
    return 190;//202;
}

//- (void)enterDetailView
//{
//}


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
            
            FADummieStrategyDetailViewModel *jingxuan = (FADummieStrategyDetailViewModel *)dataSourceJingXuan[0];
            cell.strategyId1 = jingxuan.StrategyId;
            cell.btnStrategyName1.titleLabel.text = jingxuan.StrategyName;
//            cell.lblStrategyName1.text = jingxuan.StrategyName;
            int star = (int)ceil(jingxuan.Star);
            NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
            cell.imgStrategyStar1.image = [UIImage imageNamed:gradeImageName];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            cell.lblUpdateDate1.text = [dateFormat stringFromDate:jingxuan.OnlineDay];
            cell.lblStrategyStatus1.text = @"上架";
            cell.lblCollectionPeople1.text = [[NSString alloc] initWithFormat:@"%d", jingxuan.FollowNumber];
            cell.lblProviderName1.text = jingxuan.ProviderName;
            cell.imgPerformanceBackMap1.image = [self GetProfitBackMap:jingxuan.CumulativeReturnRatio];
            NSString* profitLineImageName = @"tmp_collect_profit_red";
            cell.imgPerformanceMap1.image = [UIImage imageNamed:profitLineImageName];
            cell.lblPerformanceNumber1.text = [NSString stringWithFormat:@"%.1f%%",jingxuan.CumulativeReturnRatio *100];
            
            FADummieStrategyDetailViewModel *jingxuan2 = (FADummieStrategyDetailViewModel *)dataSourceJingXuan[1];
            cell.strategyId2 = jingxuan2.StrategyId;
            cell.btnStrategyName2.titleLabel.text = jingxuan2.StrategyName;
//            cell.lblStrategyName2.text = jingxuan2.StrategyName;
            cell.lblCollectionPeople2.text = [[NSString alloc] initWithFormat:@"%d", jingxuan2.FollowNumber];
            
            FADummieStrategyDetailViewModel *jingxuan3 = (FADummieStrategyDetailViewModel *)dataSourceJingXuan[2];
            cell.strategyId3 = jingxuan3.StrategyId;
            cell.btnStrategyName3.titleLabel.text = jingxuan3.StrategyName;
//            cell.lblStrategyName3.text = jingxuan3.StrategyName;
            cell.lblCollectionPeople3.text = [[NSString alloc] initWithFormat:@"%d", jingxuan3.FollowNumber];
        }
            break;
            
        case 1:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_02"];
            cell.lblTitle.text = @"趋势策略";
            
            FADummieStrategyDetailViewModel *qushi = (FADummieStrategyDetailViewModel *)dataSourceQuShi[0];
            cell.strategyId1 = qushi.StrategyId;
            cell.btnStrategyName1.titleLabel.text = qushi.StrategyName;
//            cell.lblStrategyName1.text = qushi.StrategyName;
            int star = (int)ceil(qushi.Star);
            NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
            cell.imgStrategyStar1.image = [UIImage imageNamed:gradeImageName];
            NSDateFormatter *dateFormatQuShi = [[NSDateFormatter alloc] init];
            [dateFormatQuShi setDateFormat:@"yyyy-MM-dd"];
            cell.lblUpdateDate1.text = [dateFormatQuShi stringFromDate:qushi.OnlineDay];
            cell.lblStrategyStatus1.text = @"上架";
            cell.lblCollectionPeople1.text = [[NSString alloc] initWithFormat:@"%d", qushi.FollowNumber];
            cell.lblProviderName1.text = qushi.ProviderName;
            cell.imgPerformanceBackMap1.image = [self GetProfitBackMap:qushi.CumulativeReturnRatio];
            NSString* profitLineImageName = @"tmp_collect_profit_red";
            cell.imgPerformanceMap1.image = [UIImage imageNamed:profitLineImageName];
            cell.lblPerformanceNumber1.text = [NSString stringWithFormat:@"%.1f%%",qushi.CumulativeReturnRatio *100];
            
            FADummieStrategyDetailViewModel *qushi2 = (FADummieStrategyDetailViewModel *)dataSourceQuShi[1];
            cell.strategyId2 = qushi2.StrategyId;
            cell.btnStrategyName2.titleLabel.text = qushi2.StrategyName;
//            cell.lblStrategyName2.text = qushi2.StrategyName;
            cell.lblCollectionPeople2.text = [[NSString alloc] initWithFormat:@"%d", qushi2.FollowNumber];
            
            FADummieStrategyDetailViewModel *qushi3 = (FADummieStrategyDetailViewModel *)dataSourceQuShi[2];
            cell.strategyId3 = qushi3.StrategyId;
            cell.btnStrategyName3.titleLabel.text = qushi3.StrategyName;
//            cell.lblStrategyName3.text = qushi3.StrategyName;
            cell.lblCollectionPeople3.text = [[NSString alloc] initWithFormat:@"%d", qushi3.FollowNumber];
        }
            break;
            
        case 2:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_03"];
            cell.lblTitle.text = @"逆势策略";
            
            FADummieStrategyDetailViewModel *nishi = (FADummieStrategyDetailViewModel *)dataSourceNiShi[0];
            cell.strategyId1 = nishi.StrategyId;
            cell.btnStrategyName1.titleLabel.text = nishi.StrategyName;
//            cell.lblStrategyName1.text = nishi.StrategyName;
            int star = (int)ceil(nishi.Star);
            NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
            cell.imgStrategyStar1.image = [UIImage imageNamed:gradeImageName];
            NSDateFormatter *dateFormatNiShi = [[NSDateFormatter alloc] init];
            [dateFormatNiShi setDateFormat:@"yyyy-MM-dd"];
            cell.lblUpdateDate1.text = [dateFormatNiShi stringFromDate:nishi.OnlineDay];
            cell.lblStrategyStatus1.text = @"上架";
            cell.lblCollectionPeople1.text = [[NSString alloc] initWithFormat:@"%d", nishi.FollowNumber];
            cell.lblProviderName1.text = nishi.ProviderName;
            cell.imgPerformanceBackMap1.image = [self GetProfitBackMap:nishi.CumulativeReturnRatio];
            NSString* profitLineImageName = @"tmp_collect_profit_red";
            cell.imgPerformanceMap1.image = [UIImage imageNamed:profitLineImageName];
            cell.lblPerformanceNumber1.text = [NSString stringWithFormat:@"%.1f%%",nishi.CumulativeReturnRatio *100];
            
            FADummieStrategyDetailViewModel *nishi2 = (FADummieStrategyDetailViewModel *)dataSourceNiShi[1];
            cell.strategyId2 = nishi2.StrategyId;
            cell.btnStrategyName2.titleLabel.text = nishi2.StrategyName;
//            cell.lblStrategyName2.text = nishi2.StrategyName;
            cell.lblCollectionPeople2.text = [[NSString alloc] initWithFormat:@"%d", nishi2.FollowNumber];
            
            FADummieStrategyDetailViewModel *nishi3 = (FADummieStrategyDetailViewModel *)dataSourceNiShi[2];
            cell.strategyId3 = nishi3.StrategyId;
            cell.btnStrategyName3.titleLabel.text = nishi3.StrategyName;
//            cell.lblStrategyName3.text = nishi3.StrategyName;
            cell.lblCollectionPeople3.text = [[NSString alloc] initWithFormat:@"%d", nishi3.FollowNumber];
        }
            break;
            
        case 3:
        {
            cell.imgTitle.image = [UIImage imageNamed:@"JingXuan_icon_index_04"];
            cell.lblTitle.text = @"套利策略";
            
            FADummieStrategyDetailViewModel *taoli = (FADummieStrategyDetailViewModel *)dataSoruceTaoLi[0];
            cell.strategyId1 = taoli.StrategyId;
            cell.btnStrategyName1.titleLabel.text = taoli.StrategyName;
//            cell.lblStrategyName1.text = taoli.StrategyName;
            int star = (int)ceil(taoli.Star);
            NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
            cell.imgStrategyStar1.image = [UIImage imageNamed:gradeImageName];
            NSDateFormatter *dateFormatTaoLi = [[NSDateFormatter alloc] init];
            [dateFormatTaoLi setDateFormat:@"yyyy-MM-dd"];
            cell.lblUpdateDate1.text = [dateFormatTaoLi stringFromDate:taoli.OnlineDay];
            cell.lblStrategyStatus1.text = @"上架";
            cell.lblCollectionPeople1.text = [[NSString alloc] initWithFormat:@"%d", taoli.FollowNumber];
            cell.lblProviderName1.text = taoli.ProviderName;
            cell.imgPerformanceBackMap1.image = [self GetProfitBackMap:taoli.CumulativeReturnRatio];
            NSString* profitLineImageName = @"tmp_collect_profit_red";
            cell.imgPerformanceMap1.image = [UIImage imageNamed:profitLineImageName];
            cell.lblPerformanceNumber1.text = [NSString stringWithFormat:@"%.1f%%",taoli.CumulativeReturnRatio *100];
            
            FADummieStrategyDetailViewModel *taoli2 = (FADummieStrategyDetailViewModel *)dataSoruceTaoLi[1];
            cell.strategyId2 = taoli2.StrategyId;
            cell.btnStrategyName2.titleLabel.text = taoli2.StrategyName;
//            cell.lblStrategyName2.text = taoli2.StrategyName;
            cell.lblCollectionPeople2.text = [[NSString alloc] initWithFormat:@"%d", taoli2.FollowNumber];
            
//            FADummieStrategyDetailViewModel *taoli3 = (FADummieStrategyDetailViewModel *)dataSoruceTaoLi[2];
//            cell.lblStrategyName3.text = taoli3.StrategyName;
//            cell.lblCollectionPeople3.text = [[NSString alloc] initWithFormat:@"%d", taoli3.FollowNumber];
        }
            break;
            
        default:
            break;
    }
    
    [cell initialNameIdDictionary]; // NameIdDictionary
    
    return cell;
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
