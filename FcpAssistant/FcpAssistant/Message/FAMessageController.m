//
//  FAMessageController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMessageController.h"
#import "FAMessageViewCell2.h"
#import "FAMessageDetailViewController.h"
#import "FAStoreManager.h"
#import "FAClientMessageDto.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"

@interface FAMessageController ()

@end

@implementation FAMessageController

- (id)init
{
    self = [super init];
    if (self)
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"消息";
    
    dataSource = [[NSMutableArray alloc] init];
    NSArray *messageList = [self LoadDataFromServer];
    if(messageList != nil && messageList.count > 0)
    {
        [dataSource addObjectsFromArray:messageList];
    }
}

-(void)initializeData
{
    itemCellIdentifier = @"FAMessageCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMessageViewCell2" bundle:nil];
    
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

-(NSArray *)LoadDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoObjArray =[FAJSONSerialization toArray:[FAClientMessageDto class] fromData:replyData];
        
        return  dtoObjArray;
    }
    else
    {
        return nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    // Return the number of sections.
//    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
//    return [dataSource[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMessageViewCell2 * cell = (FAMessageViewCell2 *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if(!cell)
    {
        cell = [[FAMessageViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    if(indexPath.row < dataSource.count)
    {
        FAClientMessageDto *dto = dataSource[indexPath.row];
            
//        cell.iconMessageReadFlag.image = [UIImage imageNamed:[messageDict valueForKey:@"readFlag"][indexPath.row]];
//        cell.imgMessageType.image = [UIImage imageNamed:[messageDict valueForKey:@"image"][indexPath.row]];
//        cell.lblMessageProvider.text = [messageDict valueForKey:@"provider"][indexPath.row];
//        cell.lblMessageArriveTime.text = [messageDict valueForKey:@"arriveTime"][indexPath.row];
//        cell.lblMessageDetail.text = [messageDict valueForKey:@"body"][indexPath.row];
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here, for example:
//    // Create the next view controller.
//    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
//    
//    // Pass the selected object to the new view controller.
//    
//    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if(indexPath.section ==0 && indexPath.row ==0)
//    {
        FAMessageDetailViewController *subController = [[FAMessageDetailViewController alloc] init];
        subController.hidesBottomBarWhenPushed = YES;
        [self pushNewViewController:subController];
//    }
    
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}

@end
