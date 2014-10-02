//
//  FAMyPositionController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyPositionController.h"
#import "FAMyPositionStrategyViewCell.h"
#import "FAMyPositionStrategyHeaderView.h"
#import "FAAccountManager.h"
#import "FAFoundation.h"
#import "FAHttpHead.h"
#import "FAHttpUtility.h"
#import "FAJSONSerialization.h"
#import "FAUtility.h"
#import "FAMyHoldingPositionDto.h"
#import "FAStrategyHoldingPositionDto.h"
#import "FAFormater.h"

@interface FAMyPositionController ()

@end

@implementation FAMyPositionController

//int totalSecitonIndex = 0;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"持仓";
    
    dataSource = [[NSMutableArray alloc] init ];
    
    NSArray *positionList = [self LoadDataFromServer];
    if(positionList != nil && [positionList count] >0)
    {
        [dataSource addObjectsFromArray:positionList];
    }
}

-(void)initializeData
{
    strategyCellIdentifier = @"myPositonStrategyCell";
}

-(void)registerXibFile
{
    UINib *strategyCellNib = [UINib nibWithNibName:@"FAMyPositionStrategyViewCell" bundle:nil];
    [self.tableView registerNib:strategyCellNib forCellReuseIdentifier:strategyCellIdentifier];
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
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/MyTrade?holdingPosition=&fundAccount=%@&fundAccountType=%d",WEB_URL,selectFundAccount.FundAccount,selectFundAccount.FundAccountType];
        NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
        
        if(error == nil)
        {
            NSArray *dtoObj =[FAJSONSerialization toArray:[FAMyHoldingPositionDto class] fromData:replyData];
            return  dtoObj;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"MyHoldingPositionExeption" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
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
    FAMyHoldingPositionDto *dto = dataSource[section];
    return dto.Detail.count;
}   	

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMyPositionStrategyViewCell* cell= (FAMyPositionStrategyViewCell*)[tableView dequeueReusableCellWithIdentifier:strategyCellIdentifier];
        
     if (!cell)
     {
         cell = [[FAMyPositionStrategyViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strategyCellIdentifier];
     }
    if (indexPath.section < dataSource.count)
    {
        FAMyHoldingPositionDto *myHoldingPosition = dataSource[indexPath.section];
        FAStrategyHoldingPositionDto *item = myHoldingPosition.Detail[indexPath.row];
        
        cell.lblInstrumentCode.text = item.InstrumentCode;
        cell.lblOrderPosition.text = [FAFormater toDecimalStringWithInt:item.OrderPosition];
        cell.lblPositionProfit.text = [FAFormater toDecimalStringWithDouble:item.HoldingProfit  decimalPlace:2];
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


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMyPositionStrategyHeaderView" owner:self options:nil];
        
    FAMyPositionStrategyHeaderView *headView = (FAMyPositionStrategyHeaderView *)[nib objectAtIndex:0];
    if (section < dataSource.count)
    {
        FAMyHoldingPositionDto *myHoldingPosition = dataSource[section];
        headView.lblHeaderName.text = myHoldingPosition.Description;
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
