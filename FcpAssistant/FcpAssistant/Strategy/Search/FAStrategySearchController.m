//
//  FAStrategySearchController.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyDetailController.h"
#import "FAStrategySearchHeaderViewCell.h"
#import "FAStrategySearchViewCell.h"
#import "FAStrategySearchController.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAFoundation.h"


@interface FAStrategySearchController ()

@end

@implementation FAStrategySearchController

@synthesize listTeams;
@synthesize listFilterTeams;
@synthesize barStrategySearch;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    barStrategySearch.delegate = self;
    
    listTeams = [NSMutableArray arrayWithCapacity:32];
    [listTeams addObjectsFromArray:[self loadDataFromServer]];
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
        return 40;
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

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *text = searchBar.text;
    NSLog(@"search button pressed! %@", text);
    
    FAStrategyDetailController *detailController = [[FAStrategyDetailController alloc] init];
    detailController.strategyId = 467;
    
    detailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
        NSArray *dtoArray =[FAJSONSerialization toArray:[NSArray class] fromData:replyData];
        
        return  dtoArray;
    }
    else
    {
        return nil;
    }
}

@end
