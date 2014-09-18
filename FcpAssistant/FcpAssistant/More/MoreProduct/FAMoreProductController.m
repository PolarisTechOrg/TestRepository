//
//  FAMoreProductController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMoreProductController.h"
#import "FAMoreProductViewCell.h"
#import "FAStoreManager.h"
@interface FAMoreProductController ()

@end

@implementation FAMoreProductController

NSString* itemCellIdentifier;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    self.navigationItem.title = @"更多产品";

    dataSource = [[FAStoreManager shareInstance] getMoreProductConfigureArray];
}

-(void)initializeData
{
    itemCellIdentifier = @"faMoreProductItemCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMoreProductViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMoreProductViewCell * cell = (FAMoreProductViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if(!cell)
    {
        cell = [[FAMoreProductViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
        
    }
    
    if(indexPath.section <dataSource.count)
    {
        NSDictionary *moreProductDictionary = dataSource[indexPath.section];
        cell.imgProductLogo.image = [UIImage imageNamed:[moreProductDictionary valueForKey:@"image"][indexPath.row]];
        cell.lblProductName.text = [moreProductDictionary valueForKey:@"title"][indexPath.row];
        cell.lblVersion.text = [moreProductDictionary valueForKey:@"version"][indexPath.row];
        cell.lblProductDescription.text = [moreProductDictionary valueForKey:@"description"][indexPath.row];
    }
 
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
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
