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
#import "FAStrategyDetailDescribViewCell.h"
#import "FAStrategyDetailProfitViewCell.h"
#import "FAStrategyDetailLatedRecordViewCell.h"

#import "FADummieStrategyDetailDto.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FADummieStrategyDetail2ViewModel.h"
#import "FAStrategyDescriptionViewModel.h"
#import "FAStrategyPerformanceViewModel.h"
#import "FAStrategyModel.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"


@interface FAStrategyDetailController ()

@end

@implementation FAStrategyDetailController

@synthesize strategyId;

const int topSectionIndex = 0;
const int describSectionIndex = 1;
const int profitsSectionIndex = 2;
const int latedRecordSectionIndex = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"策略详情";
    
    UIBarButtonItem* shareBtn = [[UIBarButtonItem alloc] init];
    shareBtn.title = @"分享";
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 1;
    
    dataSource = [self LoadDataFromServer];
    if(dataSource == nil)
    {
        dataSource = [[FADummieStrategyDetailDto alloc] init];
    }
}

-(void)initializeData
{
    topCellIdentifier = @"strategyDetailTopCell";
    describCellIdentifier = @"strategyDetailDescribCell";
    profitCellIdentifier = @"strategyDetailProfitCell";
    latedRecordCellIdentifier = @"strategyDetailLatedRecordCell";
}

-(void)registerXibFile
{
    UINib *topCellNib = [UINib nibWithNibName:@"FAStrategyDetailTopViewCell" bundle:nil];
    [self.tableView registerNib:topCellNib forCellReuseIdentifier:topCellIdentifier];
    
    UINib *describCellNib = [UINib nibWithNibName:@"FAStrategyDetailDescribViewCell" bundle:nil];
    [self.tableView registerNib:describCellNib forCellReuseIdentifier:describCellIdentifier];
    
    UINib *profitCellNib = [UINib nibWithNibName:@"FAStrategyDetailProfitViewCell" bundle:nil];
    [self.tableView registerNib:profitCellNib forCellReuseIdentifier:profitCellIdentifier];
    
    UINib *latedRecordCellNib = [UINib nibWithNibName:@"FAStrategyDetailLatedRecordViewCell" bundle:nil];
    [self.tableView registerNib:latedRecordCellNib forCellReuseIdentifier:latedRecordCellIdentifier];
}

-(FADummieStrategyDetailDto *) LoadDataFromServer
{
    NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/strategy?strategyId=%d",WEB_URL,self.strategyId];
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:error];
    
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    switch (section) {
        case topSectionIndex:
            return 1;
            break;
            
            case describSectionIndex:
            return 1;
            
            case profitsSectionIndex:
            return 1;
            
            case latedRecordSectionIndex:
            return 1;
            
        default:
            return 0;
    }
    
    return 0;
}

//-(void)showTopViewCell:(FAStrategyDetailTopViewCell *)cell
//{
//    FAStrategyDescriptionViewModel *strategy = dataSource.StrategyDescription;
//    cell.lbl = ;
//    
//    int star = (int)ceil(strategy.Star);
//    NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
//    cell.imgStrategyGrade.image = [UIImage imageNamed:gradeImageName];
//    cell.lblPurchaseDate.text = [FAFormater toShortDateStringWithNSDate:strategy.BuyedTime];
//    cell.lblTodayProfit.text =  [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.TodayProfit]];
//    if(strategy.Underlyings != nil && [strategy.Underlyings count] >1)
//    {
//        cell.lblVarieties.text = @"多合约";
//    }
//    else if(strategy.Underlyings != nil && [strategy.Underlyings count] ==1)
//    {
//        FAUnderlyingViewModel *underlying =[strategy.Underlyings objectAtIndex:0];
//        cell.lblVarieties.text = underlying.UnderName;
//    }
//    cell.lblStrategyProfit.text = [[FAFormater decimalFormater] stringForObjectValue:[NSNumber numberWithDouble:strategy.StrategyProfit]];
//    cell.lblOrderMultiple.text = [NSString stringWithFormat:@"%d",strategy.BuyedQuantity];
//    cell.lblYestordayProfit.text = [FAFormater toDecimalStringWithDouble:strategy.YesterdayProfit  decimalPlace:2];
//}

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
            //[self showTopViewCell:cell];
            return cell;
        }
        case describSectionIndex:
        {
            FAStrategyDetailDescribViewCell * cell= (FAStrategyDetailDescribViewCell*)[tableView dequeueReusableCellWithIdentifier:describCellIdentifier];
            if (!cell)
            {
                cell = [[FAStrategyDetailDescribViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:describCellIdentifier];
            }
//            [self showPositionViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case profitsSectionIndex:
        {
            FAStrategyDetailProfitViewCell * cell= (FAStrategyDetailProfitViewCell*)[tableView dequeueReusableCellWithIdentifier:profitCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAStrategyDetailProfitViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:profitCellIdentifier];
            }
//            [self showProfitViewCell:cell rowIndex:indexPath.row];
            return cell;
        }
        case latedRecordSectionIndex:
        {
            FAStrategyDetailLatedRecordViewCell * cell= (FAStrategyDetailLatedRecordViewCell*)[tableView dequeueReusableCellWithIdentifier:latedRecordCellIdentifier];
            
            if (!cell)
            {
                cell = [[FAStrategyDetailLatedRecordViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:latedRecordCellIdentifier];
            }
//            [self showSignalViewCell:cell rowIndex:indexPath.row];
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
        case topSectionIndex: return 0.1;
        case describSectionIndex: return 73;
        case profitsSectionIndex: return 38;
        case latedRecordSectionIndex:return 38;
        default: return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case topSectionIndex: return 146;
        case describSectionIndex:return 30;
        case profitsSectionIndex:return 170;
        case latedRecordSectionIndex:return 170;
        default:return 0;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    switch (section)
    {
        case topSectionIndex:
        {
            return [super tableView:tableView viewForHeaderInSection:section];
        }
        case describSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAStrategyDetailDescribHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
        }
        case profitsSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAStrategyDetailProfitHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
            break;
        }
        case latedRecordSectionIndex:
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAStrategyDetailLatedRecordHeaderView" owner:self options:nil];
            
            UIView *headerView = (UIView *) [nib objectAtIndex:0];
            headerView.frame = CGRectMake(0, 0, 320, 50);
            return headerView;
        }
        default:
            return [super tableView:tableView viewForHeaderInSection:section];
            break;
    }    
}


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
