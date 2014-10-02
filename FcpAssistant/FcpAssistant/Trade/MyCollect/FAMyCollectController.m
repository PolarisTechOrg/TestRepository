//
//  FAMyCollectController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyCollectController.h"
#import "FAMyCollectItemViewCell.h"
#import "FAMyCollectItem.h"
#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAWishlistDto.h"
#import "FADummieStrategyDetailViewModel.h"
#import "FAUtility.h"
#import "FAPurchaseProfitView.h"


@interface FAMyCollectController ()

@end

@implementation FAMyCollectController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"收藏";
    self.tableView.sectionFooterHeight = 0.1;
    
    dataSource = [[NSMutableArray alloc] init ];
    
    FAWishlistDto *wishList = [self LoadDataFromServer];
    if(wishList != nil && [wishList.Items count] >0)
    {
        [dataSource addObjectsFromArray:wishList.Items];
    }
  


}

-(FAWishlistDto *) LoadDataFromServer
{
    @try
    {
        NSURL * requestUrl =[NSURL URLWithString:[WEB_URL stringByAppendingString:@"api/wishlist"]];
        
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
        
        if(error == nil)
        {
            FAWishlistDto *dtoObj =[FAJSONSerialization toObject:[FAWishlistDto class] fromData:replyData];
            
            return  dtoObj;
            
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"MyCollectException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
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
    itemCellIdentifier = @"collectItemViewCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMyCollectItemViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    return 104;
}

- (void)enterDetailView
{
//    FAStrategyDetailController * detailController = [[FAStrategyDetailController alloc] init];
//    [self.navigationController pushViewController:detailController animated:YES];
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"取消\r\n收藏";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMyCollectItemViewCell *cell = (FAMyCollectItemViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMyCollectItemViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    if (indexPath.row < dataSource.count)
    {
        FADummieStrategyDetailViewModel* item = (FADummieStrategyDetailViewModel *)dataSource[indexPath.row];
        
        NSLog(@"Item:%@",item);

        NSString* profitBackgroundImageName = @"mycollect_profit_red";
        cell.imgProfitBackground.image = [UIImage imageNamed:profitBackgroundImageName];
        
        cell.lblStrategyName.text = item.StrategyName;
        int star = (int)ceil(item.Star);
        NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
        NSLog(@"gradeImageName:%@",gradeImageName);
        cell.imgStragetyGrade.image = [UIImage imageNamed:gradeImageName];
        cell.lblStrategyProfitRate.text = [NSString stringWithFormat:@"%.1f%%",item.CumulativeReturnRatio *100];
        cell.lblStrategyProvider.text = item.ProviderName;
        cell.lblCollectCount.text = [NSString stringWithFormat:@"%d",item.CollectionNumber];
        
        if(indexPath.row %2 == 0)
        {
        [cell.imgStrategyProfit setBackgroundColor:[UIColor yellowColor]];
        }
        else
        {
        [cell.imgStrategyProfit setBackgroundColor:[UIColor redColor]];
        }
//        FAPurchaseProfitView *profitView = [[FAPurchaseProfitView alloc] initWithFrame:CGRectMake(0, 0, 118, 48)];
//        
//        [cell.imgProfitLine addSubview:profitView];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self enterDetailView];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        FADummieStrategyDetailViewModel* item = dataSource[indexPath.row];
        if([self cancelCollectStrategy:item.StrategyId] == YES)
        {
            [dataSource removeObject:item];
        // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

-(BOOL) cancelCollectStrategy:(int) strategyId
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/wishlist?strategyId=%d",WEB_URL,strategyId];
        NSURL * requestUrl =[NSURL URLWithString:requestUrlStr];
        
        NSError *error;
        FAHttpHead *httpHead = [FAHttpHead defaultInstance];
        httpHead.Method = @"DELETE";
        
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHead httpBody:nil error: &error];
        NSLog(@"%@",[[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding]);
        if(error == nil)
        {
            return YES;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"LoginException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
            @throw ex;
        }
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
        return NO;
    }
    @finally
    {
        
    }
}

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
