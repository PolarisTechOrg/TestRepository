//
//  FAStrategySearchController.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategySearchController.h"

@interface FAStrategySearchController ()

@end

@implementation FAStrategySearchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设定搜索栏ScopeBar隐藏
    [self.barSearchStrategy setShowsScopeBar:NO];
    [self.barSearchStrategy sizeToFit];
    
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"team" ofType:@"plist"];
    //获取属性列表文件中的全部数据
//    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //初次进入查询所有数据
//    [self filterContentForSearchText:@"" scope:-1];
}

- (void)viewDidUnload
{
    [self setBarSearchStrategy:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark Content Filtering
- (void)filterContentForSearchText:(NSString*)searchText  scope:(NSUInteger)scope
{
    
    if([searchText length]==0)
    {
        //查询所有
        self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0: //英文
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            
            break;
        case 1:
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            
            break;
        default:
            //查询所有
            self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
            break;
    }
    
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listFilterTeams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.listFilterTeams objectAtIndex:row];
    cell.textLabel.text =  [rowDict objectForKey:@"name"];
    cell.detailTextLabel.text = [rowDict objectForKey:@"image"];
    
    NSString *imagePath = [rowDict objectForKey:@"image"];
    imagePath = [imagePath stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark --UISearchBarDelegate 协议方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //查询所有
    [self filterContentForSearchText:@"" scope:-1];
}


#pragma mark - UISearchDisplayController Delegate Methods
//当文本内容发生改变时候，向表视图数据源发出重新加载消息
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:self.barSearchStrategy.selectedScopeButtonIndex];
    //YES情况下表视图可以重新加载
    return YES;
}

// 当Scope Bar选择发送变化时候，向表视图数据源发出重新加载消息
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.barSearchStrategy.text  scope:searchOption];
    // YES情况下表视图可以重新加载
    return YES;
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

@end
