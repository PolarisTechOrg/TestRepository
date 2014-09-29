//
//  FAMoreController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMoreController.h"
#import "FAMoreViewCell.h"
#import "FAStoreManager.h"
#import "FAMyFcpController.h"
#import "FAMeberLoginController.h"
#import "FAFeddbackController.h"
#import "FAMoreProductController.h"
#import "FAAbountProductController.h"
#import "FAAccountManager.h"

@interface FAMoreController ()

@end

@implementation FAMoreController

NSString* itemCellIdentifier;
NSMutableArray *dataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"更多";
    self.tableView.sectionFooterHeight = 0;
    
    dataSource =[[FAStoreManager shareInstance] getMoreConfigureArray];
}

-(void)initializeData
{
    itemCellIdentifier = @"faMoreItemCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMoreViewCell" bundle:nil];
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
    
    FAMoreViewCell * cell = (FAMoreViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if(!cell)
    {
        cell = [[FAMoreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
        
    }
    
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.section <dataSource.count)
    {
        NSDictionary *moreDictionary = dataSource[indexPath.section];
        cell.logoImage.image = [UIImage imageNamed:[moreDictionary valueForKey:@"image"][indexPath.row]];
        cell.menuTitle.text = [moreDictionary valueForKey:@"title"][indexPath.row];
        cell.menuSubTitle.text = [moreDictionary valueForKey:@"subTitle"][indexPath.row];
        
//        NSDictionary * tradeDic = self.dataSource[indexPath.row];
//        cell.logoImage.image = [UIImage imageNamed:[tradeDic valueForKey:@"image"][0]];
//        cell.menuLabel.text = [tradeDic valueForKey:@"title"][0];
    }
    NSLog(@"cellForRowAtIndexPath");
    
    
    // Configure the cell...
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        if([FAAccountManager shareInstance].hasLogin)
        {
            [self pushNewViewController:[[FAMyFcpController alloc] init]];
        }
        else
        {
            [self presentViewController:[[FAMeberLoginController alloc] init] animated:YES completion:nil];

        }
    }
    else if(indexPath.section == 1 && indexPath.row ==0)
    {
        //分享产品
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
        [self pushNewViewController:[[FAFeddbackController alloc] init]];
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        [self pushNewViewController:[[FAMoreProductController alloc] init]];
    }
    else if(indexPath.section ==2 && indexPath.row == 0)
    {
        //联系我们
    }
    else if(indexPath.section == 2 && indexPath.row == 1)
    {
        //检查更新
    }
    else if (indexPath.section == 2 && indexPath.row == 2)
    {
        [self pushNewViewController:[[FAAbountProductController alloc] init]];
    }
}

- (void)pushNewViewController:(UIViewController *)newViewController
{
    [self.navigationController pushViewController:newViewController animated:YES];
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
