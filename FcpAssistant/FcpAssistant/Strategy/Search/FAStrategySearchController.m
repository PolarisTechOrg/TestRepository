//
//  FAStrategySearchController.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyController.h"
#import "FAStrategySearchHeaderViewCell.h"
#import "FAStrategySearchViewCell.h"
#import "FAStrategySearchController.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAFoundation.h"

#import "FAStrategySearchDto.h"
#import "FADummieStrategyDetailViewModel.h"


@interface FAStrategySearchController ()

@end

@implementation FAStrategySearchController

@synthesize listTeams;
@synthesize barStrategySearch;
@synthesize strategyController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    barStrategySearch.delegate = self;
    
    listTeams = [NSMutableArray arrayWithCapacity:32];
    [listTeams addObject:@"热搜词"];
    [listTeams addObjectsFromArray:[self loadDataFromServer]];
    
    searchDto = [FAStrategySearchDto instance];
}


#pragma mark --Table View data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listTeams count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 35;
    }
    else
    {
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        FAStrategySearchHeaderViewCell *headerCell = (FAStrategySearchHeaderViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
        
        if(headerCell == nil)
        {
            headerCell = [(FAStrategySearchHeaderViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemHeaderCellIdentifier];
        }
        
        return headerCell;
    }
    else
    {
        FAStrategySearchViewCell *cell = (FAStrategySearchViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        
        if (cell == nil)
        {
            cell = (FAStrategySearchViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        }
        
        cell.lblStrategyHotSearchContext.text = listTeams[indexPath.row];
        cell.lblStrategyHotSearchContext.textAlignment = NSTextAlignmentLeft;
        
        return cell;
    }
}

#pragma mark --UISearchBarDelegate 协议方法

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.text = @" ";
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text && searchBar.text.length > 0)
    {
        searchDto.RacerType = 0;
    }
    searchDto.SearchText = searchBar.text;
    [strategyController searchData:searchDto];
    [self.navigationController popToViewController:strategyController animated:YES];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return;
    }
    
    NSString *searchText = listTeams[indexPath.row];
    if (searchText && searchText.length > 0)
    {
        searchDto.RacerType = 0;
    }
    searchDto.SearchText = searchText;
    [strategyController searchData:searchDto];
    [self.navigationController popToViewController:strategyController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private tool function
-(void)initializeData
{
    itemCellIdentifier = @"FAStrategySearchCell";
    itemHeaderCellIdentifier = @"FAStrategySearchHeaderCell";
}

-(void)registerXibFile
{    
    UINib *itemHeaderCellNib = [UINib nibWithNibName:@"FAStrategySearchHeaderViewCell" bundle:nil];
    [self.tableView registerNib:itemHeaderCellNib forCellReuseIdentifier:itemHeaderCellIdentifier];
    
    UINib *itemCellNib = [UINib nibWithNibName:@"FAStrategySearchViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (NSArray *)loadDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/StrategySearch?hotwords", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoArray =[FAJSONSerialization toArray:nil fromData:replyData];
        
        return  dtoArray;
    }
    else
    {
        return nil;
    }
}

//- (NSArray *)searchStrategyData:(NSString *)content
//{
//    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/strategy?search", WEB_URL];
//    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
//    
//    FAHttpHead *head = [FAHttpHead defaultInstance];
//    head.Method = @"POST";
//    
//    FAStrategySearchDto *body = [[FAStrategySearchDto alloc] init];
//    body.SearchText = content;
//    
//    NSError *error;
//    NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:head httpBody:body error:&error];
//    
//    if(error == nil)
//    {
//        NSArray *dtoArray =[FAJSONSerialization toArray:[FADummieStrategyDetailViewModel class] fromData:replyData];
//        
//        return  dtoArray;
//    }
//    else
//    {
//        return nil;
//    }
//}

//- (void)doSearch:(NSString *)content
//{
//    
//    NSMutableArray *strategySource = [NSMutableArray arrayWithArray:[self searchStrategyData:content]];
//    
//    FAStrategyController *controller = [[FAStrategyController alloc] init];
//    controller.dataSource = strategySource;
//    
//    //    controller.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:controller animated:YES];
//}

@end
