//
//  FAMyPurchaseDetailController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyPurchaseDetailController.h"

#import "FAMyPurchaseDetailTopViewCell.h"
#import "FAMyPurchaseDetailPositionViewCell.h"
#import "FAMyPurchaseDetailSignalViewCell.h"
#import "FAMyPurchaseDetailOrderViewCell.h"
#import "FAMyPurchaseDetailProfitViewCell.h"

#import "FAMyPurchaseDetailPositionHeaderView.h"
#import "FAMyPurchaseDetailSignalHeaderView.h"
#import "FAMyPurchaseDetailOrderHeaderView.h"
#import "FAMyPurchaseDetailProfitHeaderView.h"
#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"
#import "FAUnderlyingViewModel.h"
#import "FAStrategyHoldingPositionDto.h"
#import "FAStrategySignalDto.h"
#import "FAStrategyOrderBookDto.h"
#import "FAStrategyProfitDto.h"


@interface FAMyPurchaseDetailController ()

@end

@implementation FAMyPurchaseDetailController

//组合策略ID
@synthesize combineStrategyId;
//策略ID
@synthesize strategyId;

const int topSecitonIndex =0;
const int positionSectionIndex =1;
const int signalSectionIndex =2;
const int orderSectionIndex =3;
const int profitSectionIndex =4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title =@"策略跟单状态";
    UIBarButtonItem* shareBtn = [[UIBarButtonItem alloc] init];
    shareBtn.title = @"分享";
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    
    dataSource = [self LoadDataFromServer];
    if(dataSource == nil)
    {
        dataSource = [[FABuyedStrategyDetailDto alloc] init];
    }
    
    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 1;
}

-(void)initializeData
{
    topCellIdentifier = @"purchaseDetailTopCell";
    positionCellIdentifier = @"purchaseDetailPositionCell";
    signalCellIdentifier = @"purchaseDetailSignalCell";
    orderCellIdentifier = @"purchaseDetailOrderCell";
    profitCellIdentifier = @"purchaseDetailProfitCell";
}

-(void)registerXibFile
{
    UINib *topCellNib = [UINib nibWithNibName:@"FAMyPurchaseDetailTopViewCell" bundle:nil];
    [self.tableView registerNib:topCellNib forCellReuseIdentifier:topCellIdentifier];
    
    UINib *positionCellNib = [UINib nibWithNibName:@"FAMyPurchaseDetailPositionViewCell" bundle:nil];
    [self.tableView registerNib:positionCellNib forCellReuseIdentifier:positionCellIdentifier];
    
    UINib *signalCellNib = [UINib nibWithNibName:@"FAMyPurchaseDetailSignalViewCell" bundle:nil];
    [self.tableView registerNib:signalCellNib forCellReuseIdentifier:signalCellIdentifier];
    
    UINib *orderCellNib = [UINib nibWithNibName:@"FAMyPurchaseDetailOrderViewCell" bundle:nil];
    [self.tableView registerNib:orderCellNib forCellReuseIdentifier:orderCellIdentifier];
    
    UINib *profitCellNib = [UINib nibWithNibName:@"FAMyPurchaseDetailProfitViewCell" bundle:nil];
    [self.tableView registerNib:profitCellNib forCellReuseIdentifier:profitCellIdentifier];
}

-(FABuyedStrategyDetailDto *) LoadDataFromServer
{
    NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/BuyedStrategyDetail?fundAccount=%@&fundAcccountType=%@&combineStrategyId=%d&strategyId=%d",WEB_URL,@"100146",@"33",self.combineStrategyId,self.strategyId];
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:error];
    
    if(error == nil)
    {
        FABuyedStrategyDetailDto *dtoObj =[FAJSONSerialization toObject:[FABuyedStrategyDetailDto class] fromData:replyData];
        
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case topSecitonIndex :
            return 1;
        case positionSectionIndex:
            return dataSource.HoldingPositionList.count;
        case signalSectionIndex:
            return dataSource.SignalList.count;
        case orderSectionIndex:
            return dataSource.OrderBookList.count;
        case profitSectionIndex:
            return dataSource.HistoryProfitList.count;
        default: return 0;
    }
    return 0;
}


-(void)showTopViewCell:(FAMyPurchaseDetailTopViewCell *)cell
{
    FABuyedStrategyDto *strategy = dataSource.Strategy;
    cell.lblStrategyName.text = strategy.StrategyName;
    
    int star = (int)ceil(strategy.Star);
    NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
    cell.imgStrategyGrade.image = [UIImage imageNamed:gradeImageName];
    cell.lblPurchaseDate.text = [FAFormater toShortDateStringWithNSDate:strategy.BuyedTime];
    cell.lblTodayProfit.text =  [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.TodayProfit]];
    if(strategy.Underlyings != nil && [strategy.Underlyings count] >1)
    {
        cell.lblVarieties.text = @"多合约";
    }
    else if(strategy.Underlyings != nil && [strategy.Underlyings count] ==1)
    {
        FAUnderlyingViewModel *underlying =[strategy.Underlyings objectAtIndex:0];
        cell.lblVarieties.text = underlying.UnderName;
    }
    cell.lblStrategyProfit.text = [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.StrategyProfit]];
    cell.lblOrderMultiple.text = [NSString stringWithFormat:@"%d",strategy.BuyedQuantity];
    cell.lblYestordayProfit.text = [FAFormater toDecimalStringWithDouble:strategy.YesterdayProfit  decimalPlace:2];
}

-(void)showPositionViewCell:(FAMyPurchaseDetailPositionViewCell *)cell rowIndex:(NSInteger) rowIndex
{
    NSArray *positionList = dataSource.HoldingPositionList;
    
    FAStrategyHoldingPositionDto *positionDto = positionList[rowIndex];
    cell.lblInstrumentCode.text = positionDto.InstrumentCode;
    cell.lblOrderPosition.text = [FAFormater toDecimalStringWithInt:positionDto.OrderPosition];
    cell.lblPositionProfit.text = [FAFormater toDecimalStringWithDouble:positionDto.HoldingProfit decimalPlace:2];
}

-(void)showSignalViewCell:(FAMyPurchaseDetailSignalViewCell *)cell rowIndex:(NSInteger) rowIndex
{
    NSArray *signalList = dataSource.SignalList;
    
    FAStrategySignalDto *signalDto = signalList[rowIndex];
    cell.lblInstrumentCode.text = signalDto.InstrumentCode;
    cell.lblSignalSeq.text = [FAFormater toDecimalStringWithInt:signalDto.SignalNumber];
    cell.lblSignalTime.text =[FAFormater toShortTimeStringWithNSDate:signalDto.SignalTime];
    cell.lblStrategyPosition.text = [FAFormater toDecimalStringWithInt:signalDto.Position];
}

-(void)showOrderViewCell:(FAMyPurchaseDetailOrderViewCell *)cell rowIndex:(NSInteger) rowIndex
{
    NSArray *orderBookList = dataSource.OrderBookList;
    
    FAStrategyOrderBookDto *orderBookDto = orderBookList[rowIndex];
    cell.lblInstrumentCode.text = orderBookDto.InstrumentCode;
    cell.lblOrderQty.text = [FAFormater toDecimalStringWithInt:orderBookDto.OrderQty];
    cell.lblTradeQty.text = [FAFormater toDecimalStringWithInt:orderBookDto.TradeQty];
    cell.lblTradePrice.text = [FAFormater toDecimalStringWithDouble:orderBookDto.TradePrice decimalPlace:2];
    cell.lblOrderTime.text = [FAFormater toShortTimeStringWithNSDate:orderBookDto.OrderTime];
}

-(void)showProfitViewCell:(FAMyPurchaseDetailProfitViewCell *)cell rowIndex:(NSInteger) rowIndex
{
//    cell.imageView
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case topSecitonIndex:
        {
            FAMyPurchaseDetailTopViewCell * cell= (FAMyPurchaseDetailTopViewCell*)[tableView dequeueReusableCellWithIdentifier:topCellIdentifier];
            if (!cell)
            {
                cell = [[FAMyPurchaseDetailTopViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:topCellIdentifier];

            }
            [self showTopViewCell:cell];
            return cell;
        }
        case positionSectionIndex:
        {
            FAMyPurchaseDetailPositionViewCell * cell= (FAMyPurchaseDetailPositionViewCell*)[tableView dequeueReusableCellWithIdentifier:positionCellIdentifier];
            if (!cell)
            {
                cell = [[FAMyPurchaseDetailPositionViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:positionCellIdentifier];
            }
            [self showPositionViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case signalSectionIndex:
        {
            FAMyPurchaseDetailSignalViewCell * cell= (FAMyPurchaseDetailSignalViewCell*)[tableView dequeueReusableCellWithIdentifier:signalCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAMyPurchaseDetailSignalViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:signalCellIdentifier];
            }
            [self showSignalViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case orderSectionIndex:
        {
            FAMyPurchaseDetailOrderViewCell * cell= (FAMyPurchaseDetailOrderViewCell*)[tableView dequeueReusableCellWithIdentifier:orderCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAMyPurchaseDetailOrderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:orderCellIdentifier];
            }
            [self showOrderViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case profitSectionIndex:
        {
            FAMyPurchaseDetailProfitViewCell * cell= (FAMyPurchaseDetailProfitViewCell*)[tableView dequeueReusableCellWithIdentifier:profitCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAMyPurchaseDetailProfitViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:profitCellIdentifier];
            }
            [self showProfitViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
            
        default:
            break;
    }
    
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFotterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case topSecitonIndex: return 0.1;
        case positionSectionIndex: return 73;
        case signalSectionIndex: return 73;
        case orderSectionIndex: return 73;
        case profitSectionIndex: return 38;
        default: return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case topSecitonIndex: return 146;
        case positionSectionIndex:return 30;
        case signalSectionIndex:return 30;
        case orderSectionIndex:return 30;
        case profitSectionIndex:return 170;
        default:return 0;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (section)
    {
        case topSecitonIndex:
        {
           return [super tableView:tableView viewForHeaderInSection:section];
        }
        case positionSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMyPurchaseDetailPositionHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
        }
        case signalSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMyPurchaseDetailSignalHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
        }
        case orderSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMyPurchaseDetailOrderHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
        }
        case profitSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMyPurchaseDetailProfitHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
            break;
        }
        default:
            return [super tableView:tableView viewForHeaderInSection:section];
            break;
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
