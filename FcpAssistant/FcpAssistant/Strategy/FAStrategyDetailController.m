//
//  FAStrategyDetailController.m
//  FcpAssistant
//
//  Created by admin on 9/23/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyDetailController.h"
#import "FAStrategyDetailDescribHeaderView.h"
#import "FAStrategyDetailProfitHeaderView.h"
#import "FAStrategyDetailLatedRecordHeaderView.h"
#import "FAStrategyDetailTopViewCell.h"
#import "FADescribHeaderViewCell.h"
#import "FAStrategyDetailDescribViewCell.h"
#import "FAProfitHeaderViewCell.h"
#import "FAStrategyDetailProfitViewCell.h"
#import "FALatedRecordHeaderViewCell.h"
#import "FAStrategyDetailLatedRecordViewCell.h"

#import "FADummieStrategyDetailDto.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FADummieStrategyDetail2ViewModel.h"
#import "FAStrategyDescriptionViewModel.h"
#import "FAStrategyPerformanceViewModel.h"
#import "FAStrategyModel.h"
#import "FAWinLossView.h"
#import "FAWinLossViewModel.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"


@interface FAStrategyDetailController ()

@end

@implementation FAStrategyDetailController

@synthesize strategyId;
@synthesize profitCharDto;
//@synthesize latedWinlosses;

const int topSectionIndex = 0;
const int describHeaderSectionIndex = 1;
const int describSectionIndex = 2;
const int profitsHeaderSectionIndex = 3;
const int profitsSectionIndex = 4;
const int latedRecordHeaderSectionIndex = 5;
const int latedRecordSectionIndex = 6;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"策略详情";
    
    UIBarButtonItem* shareBtn = [[UIBarButtonItem alloc] init];
    shareBtn.title = @"分享";
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    dataSource = [self LoadDataFromServer];
    if(dataSource == nil)
    {
        dataSource = [[FADummieStrategyDetailDto alloc] init];
        dataSource = [self LoadDataFromServer];
    }
    
    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 1;
}

-(void)initializeData
{
    topCellIdentifier = @"strategyDetailTopCell";
    describCellIdentifier = @"strategyDetailDescribCell";
    profitCellIdentifier = @"strategyDetailProfitCell";
    latedRecordCellIdentifier = @"strategyDetailLatedRecordCell";
    
    describHeaderCellIdentifier = @"strategyDetailDescribHeaderCell";
    profitHeaderCellIdentifier = @"strategyDetailProfitHeaderCell";
    latedRecordHeaderCellIdentifier = @"strategyDetailLatedRecordHeaderCell";
}

-(void)registerXibFile
{
    UINib *topCellNib = [UINib nibWithNibName:@"FAStrategyDetailTopViewCell" bundle:nil];
    [self.tableView registerNib:topCellNib forCellReuseIdentifier:topCellIdentifier];
    
    UINib *describHeaderCellNib = [UINib nibWithNibName:@"FADescribHeaderViewCell" bundle:nil];
    [self.tableView registerNib:describHeaderCellNib forCellReuseIdentifier:describHeaderCellIdentifier];
    UINib *describCellNib = [UINib nibWithNibName:@"FAStrategyDetailDescribViewCell" bundle:nil];
    [self.tableView registerNib:describCellNib forCellReuseIdentifier:describCellIdentifier];
    
    UINib *profitHeaderCellNib = [UINib nibWithNibName:@"FAProfitHeaderViewCell" bundle:nil];
    [self.tableView registerNib:profitHeaderCellNib forCellReuseIdentifier:profitHeaderCellIdentifier];
    UINib *profitCellNib = [UINib nibWithNibName:@"FAStrategyDetailProfitViewCell" bundle:nil];
    [self.tableView registerNib:profitCellNib forCellReuseIdentifier:profitCellIdentifier];
    
    UINib *latedRecordHeaderCellNib = [UINib nibWithNibName:@"FALatedRecordHeaderViewCell" bundle:nil];
    [self.tableView registerNib:latedRecordHeaderCellNib forCellReuseIdentifier:latedRecordHeaderCellIdentifier];
    UINib *latedRecordCellNib = [UINib nibWithNibName:@"FAStrategyDetailLatedRecordViewCell" bundle:nil];
    [self.tableView registerNib:latedRecordCellNib forCellReuseIdentifier:latedRecordCellIdentifier];
}

-(FADummieStrategyDetailDto *) LoadDataFromServer
{
    NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/strategy?strategyId=%d",WEB_URL,self.strategyId];
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        FADummieStrategyDetailDto *dtoObj =[FAJSONSerialization toObject:[FADummieStrategyDetailDto class] fromData:replyData];
        
        return  dtoObj;
        
    }
    else
    {
        return nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    switch (section) {
        case topSectionIndex:
            return 1;
            break;
            
            case describHeaderSectionIndex:
            return 1;
            case describSectionIndex:
            return 1;
            
            case profitsHeaderSectionIndex:
            return 1;
            case profitsSectionIndex:
            return 1;
            
            case latedRecordHeaderSectionIndex:
            return 1;
            case latedRecordSectionIndex:
            return 1;
            
        default:
            return 0;
    }
    
    return 0;
}

-(void)showTopViewCell:(FAStrategyDetailTopViewCell *)cell
{
    FADummieStrategyDetail2ViewModel *strategy = dataSource.StrategySelection;
    cell.lblStrategyName.text = strategy.StrategyName;
    
    int star = (int)ceil(strategy.Star);
    NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
    cell.imgStrategyStar.image = [UIImage imageNamed:gradeImageName];
    
    
    cell.lblStrategyOnlineDate.text = [FAFormater toShortDateStringWithNSDate:strategy.OnlineDay];
    
    cell.lblRealPerformance.text = [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.CumulativeNetProfit]];
    
    cell.lblProfitOneWeek.text = [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.WeeklyReturn]];
    
    cell.lblWinRatioTwoWeeks.text = [FAFormater toDecimalStringWithDouble:strategy.WinningProbability  decimalPlace:2];
    
    cell.lblCollectionPeopleNumber.text = [NSString stringWithFormat:@"%d", strategy.CollectionNumber];
    
    cell.lblOrderPeropleNumber.text = [NSString stringWithFormat:@"%d", strategy.FollowNumber];
    
    cell.lblSuggestRightMoney.text = [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.MarginNeeds]];
    
    cell.lblTradeVariety.text = strategy.UnderName;
    
    cell.lblStrategyProvider.text = strategy.ProviderName;
}

- (void)showDescribViewCell:(FAStrategyDetailDescribViewCell *)cell rowIndex:(NSInteger) rowIndex
{
    FAStrategyDescriptionViewModel *strategy = dataSource.StrategyDescription;
    
    if(strategy.Description == nil || strategy.Description.length == 0 || [strategy.Description isEqualToString:@"NA"])
    {
        cell.lblStrategyDetailDescription.text = [cell.lblStrategyDetailDescription.text stringByAppendingString:@"暂无\n "];
        cell.lblStrategyDetailDescription.textAlignment = UITextAlignmentCenter;
    }
    else
    {
        cell.lblStrategyDetailDescription.text = [cell.lblStrategyDetailDescription.text stringByAppendingString:[NSString stringWithFormat:@"        %@\n ", strategy.Description]];
    }
}

- (void)showProfitViewCell:(FAStrategyDetailProfitViewCell *)cell rowIndex:(NSInteger) rowIndex
{
    cell.imgStrategyDetailProfitView.dataSource = profitCharDto.Items;
    [cell.imgStrategyDetailProfitView setNeedsDisplay];
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
        sortedArray = [NSMutableArray arrayWithArray:[sortedArray subarrayWithRange:range]];
    }
    
    return sortedArray;
}

- (void)showLatedRecordViewCell:(FAStrategyDetailLatedRecordViewCell *)cell rowIndex:(NSInteger) rowIndex
{
    cell.imgWinLoss.dataSource = [self sortWinLosses:dataSource.WinLosses];
    [cell.imgWinLoss setNeedsDisplay];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section)
    {
        case topSectionIndex:
        {
            FAStrategyDetailTopViewCell * cell= (FAStrategyDetailTopViewCell*)[tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
            if (!cell)
            {
                cell = [[FAStrategyDetailTopViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:topCellIdentifier];
                
            }
            [self showTopViewCell:cell];
            return cell;
        }
        case describHeaderSectionIndex:
        {
            FADescribHeaderViewCell * cell= (FADescribHeaderViewCell*)[tableView dequeueReusableCellWithIdentifier:describHeaderCellIdentifier];
            if (!cell)
            {
                cell = [[FADescribHeaderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:describHeaderCellIdentifier];
            }
            return cell;
        }
        case describSectionIndex:
        {
            FAStrategyDetailDescribViewCell * cell= (FAStrategyDetailDescribViewCell*)[tableView dequeueReusableCellWithIdentifier:describCellIdentifier];
            if (!cell)
            {
                cell = [[FAStrategyDetailDescribViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:describCellIdentifier];
            }
            [self showDescribViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case profitsHeaderSectionIndex:
        {
            FAProfitHeaderViewCell * cell= (FAProfitHeaderViewCell*)[tableView dequeueReusableCellWithIdentifier:profitHeaderCellIdentifier];
            if (!cell)
            {
                cell = [[FAProfitHeaderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:profitHeaderCellIdentifier];
            }
            return cell;
        }
        case profitsSectionIndex:
        {
            FAStrategyDetailProfitViewCell * cell= (FAStrategyDetailProfitViewCell*)[tableView dequeueReusableCellWithIdentifier:profitCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAStrategyDetailProfitViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:profitCellIdentifier];
            }
            [self showProfitViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case latedRecordHeaderSectionIndex:
        {
            FALatedRecordHeaderViewCell * cell= (FALatedRecordHeaderViewCell*)[tableView dequeueReusableCellWithIdentifier:latedRecordHeaderCellIdentifier];
            if (!cell)
            {
                cell = [[FALatedRecordHeaderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:latedRecordHeaderCellIdentifier];
            }
            return cell;
        }
        case latedRecordSectionIndex:
        {
            FAStrategyDetailLatedRecordViewCell * cell= (FAStrategyDetailLatedRecordViewCell*)[tableView dequeueReusableCellWithIdentifier:latedRecordCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAStrategyDetailLatedRecordViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:latedRecordCellIdentifier];
            }
            [self showLatedRecordViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
            
        default:
            break;
    }
    
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFotterInSection:(NSInteger)section
//{
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
//    switch (section)
//    {
//        case topSectionIndex: return 0.1;
//        case describSectionIndex: return 38;
//        case profitsSectionIndex: return 38;
//        case latedRecordSectionIndex:return 38;
//        default: return 60;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case topSectionIndex: return 180;
        case describHeaderSectionIndex:return 38;
        case describSectionIndex:return 90;
        case profitsHeaderSectionIndex:return 38;
        case profitsSectionIndex:return 170;
        case latedRecordHeaderSectionIndex:return 38;
        case latedRecordSectionIndex:return 170;
        default:return 0;
    }
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    switch (section)
//    {
//        case topSectionIndex:
//        {
//            return [super tableView:tableView viewForHeaderInSection:section];
//        }
//        case describSectionIndex:
//        {
//            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAStrategyDetailDescribHeaderView" owner:self options:nil];
//            
//            UIView *headerView = (UIView *) [nib objectAtIndex:0];
//            headerView.frame = CGRectMake(0, 0, 320, 50);
//            return headerView;
//        }
//        case profitsSectionIndex:
//        {
//            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAStrategyDetailProfitHeaderView" owner:self options:nil];
//            
//            UIView *headerView = (UIView *) [nib objectAtIndex:0];
//            headerView.frame = CGRectMake(0, 0, 320, 50);
//            return headerView;
//            break;
//        }
//        case latedRecordSectionIndex:
//        {
//            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAStrategyDetailLatedRecordHeaderView" owner:self options:nil];
//            
//            UIView *headerView = (UIView *) [nib objectAtIndex:0];
//            headerView.frame = CGRectMake(0, 0, 320, 50);
//            return headerView;
//        }
//        default:
//            return [super tableView:tableView viewForHeaderInSection:section];
//            break;
//    }    
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
