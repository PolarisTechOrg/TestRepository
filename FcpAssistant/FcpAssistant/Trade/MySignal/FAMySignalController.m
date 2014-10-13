//
//  FAMySignalController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMySignalController.h"
#import "FAMySignalItemHeaderViewCell.h"
#import "FAMySignalItemViewCell.h"

#import "FAMyStrategySignalDto.h"
#import "FAAccountManager.h"
#import "FAFoundation.h"
#import "FAHttpHead.h"
#import "FAHttpUtility.h"
#import "FAJSONSerialization.h"
#import "FAUtility.h"
#import "FAStrategySignalDto.h"
#import "FAFormater.h"

@interface FAMySignalController ()

@end

@implementation FAMySignalController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"信号";
    
    dataSource = [[NSMutableArray alloc] init ];
    
    NSArray *signalList = [self LoadDataFromServer];
    if(signalList != nil && [signalList count] >0)
    {
        [dataSource addObjectsFromArray:signalList];
    }
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
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/MyTrade?strategySignal=&fundAccount=%@&fundAccountType=%d",WEB_URL,selectFundAccount.FundAccount,selectFundAccount.FundAccountType];
        NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
        
        if(error == nil)
        {
            NSArray *dtoObj =[FAJSONSerialization toArray:[FAMyStrategySignalDto class] fromData:replyData];
            return  dtoObj;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"MySignalExeption" reason: [NSString stringWithFormat:@"%d",error.code] userInfo:error.userInfo];
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

-(void)initializeData
{
    itemHeaderIdentifier = @"mySignalHeaderCell";
    itemCellIdentifier = @"mySignalItemCell";
}

-(void)registerXibFile
{
    UINib *itemHeaderCellNib = [UINib nibWithNibName:@"FAMySignalItemHeaderViewCell" bundle:nil];
    [self.tableView registerNib:itemHeaderCellNib forCellReuseIdentifier:itemHeaderIdentifier];

    UINib *itemCellNib = [UINib nibWithNibName:@"FAMySignalItemViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count *2;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger index = section %2;
    if(index ==0)
    {
        return 1;
    }
    else
    {
        FAMyStrategySignalDto *dto = dataSource[section/2];
        return dto.Detail.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section %2 ==0)
    {
        FAMySignalItemHeaderViewCell *cell= (FAMySignalItemHeaderViewCell*)[tableView dequeueReusableCellWithIdentifier:itemHeaderIdentifier];
        
        if (!cell)
        {
            cell = [[FAMySignalItemHeaderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemHeaderIdentifier];
        }
        
        FAMyStrategySignalDto *mySignal = dataSource[indexPath.section/2];
        cell.lblHeaderName.text = mySignal.Description;
        return cell;
    }
    else
    {
    FAMySignalItemViewCell* cell= (FAMySignalItemViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMySignalItemViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    if (indexPath.section/2 < dataSource.count)
    {
        FAMyStrategySignalDto *mySignal = dataSource[indexPath.section/2];
        FAStrategySignalDto *item = mySignal.Detail[indexPath.row];
        
        cell.lblSignalTime.text = [FAFormater toShortTimeStringWithNSDate:item.SignalTime];
        cell.lblSignalSeqNum.text =  [[NSString alloc] initWithFormat:@"%d",item.SignalNumber];
        cell.lblInstrumentCode.text = item.InstrumentCode;
        cell.lblPosition.text = [FAFormater toDecimalStringWithInt:item.Position];
    }
    
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section %2 ==0)
    {
        return 73;
    }
    else
    {
        return 30;
    }
}


//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMySignalItemHeaderView" owner:self options:nil];
////    UIView *headerView = (UIView *) [nib objectAtIndex:0];
////    headerView.frame = CGRectMake(0, 0, 320, 50);
//    FAMySignalItemHeaderView *headView = (FAMySignalItemHeaderView *)[nib objectAtIndex:0];
//    if (section < dataSource.count)
//    {
//        FAMyStrategySignalDto *mySignal = dataSource[section];
//        headView.lblHeaderName.text = mySignal.Description;
//    }
//    
//    return headView;
//}


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
