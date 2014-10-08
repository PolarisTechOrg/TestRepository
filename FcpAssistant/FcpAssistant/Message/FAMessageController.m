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
#import "FAMessage.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"
#import "FAUtility.h"

@interface FAMessageController ()

@end

@implementation FAMessageController

- (int)loadUnReadMessageCount
{NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message?unRead", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        return [[FAJSONSerialization toObject:nil fromData:replyData] intValue];
    }
    else
    {
        return 0;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    int unReadCount = [self loadUnReadMessageCount];
    self.navigationItem.title = [NSMutableString stringWithFormat:@"消息(%d)", unReadCount];
    
    dataSource = [[NSMutableArray alloc] init];
    NSArray *messageList = [self LoadMessageDataFromServer];
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

-(NSArray *)LoadMessageDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoObjArray =[FAJSONSerialization toArray:[FAClientMessageDto class] fromData:replyData];
        
        NSMutableArray *messageArray = [NSMutableArray arrayWithCapacity:128];
        for(id dto in dtoObjArray)
        {
            if(!dto)
            {
                continue;
            }
            
            FAClientMessageDto *dtoMessage = (FAClientMessageDto *)dto;
            FAMessage *message = [[FAMessage alloc] init];
            message.ReadFlag = dtoMessage.ReadFlag;
            message.MessageId = dtoMessage.MessageId;
            message.MessageType = dtoMessage.MessageType;
            message.SenderId = dtoMessage.SenderId;
            message.SenderName = dtoMessage.SenderName;
            message.MessageTime = dtoMessage.MessageTime;
            message.Context = dtoMessage.Context;
            
            [messageArray addObject:message];
        }
        
        // sort
//        [messageArray sortUsingSelector:@selector(compareDate:)];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"MessageTime" ascending:YES];
        [messageArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        return  messageArray;
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMessageViewCell2 * cell = (FAMessageViewCell2 *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if(!cell)
    {
        cell = [[FAMessageViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row < dataSource.count)
    {
        FAClientMessageDto *dto = dataSource[indexPath.row];
       
        if(!dto)
        {
            return cell;
        }

        if(!dto.ReadFlag)
        {
            cell.iconMessageReadFlag.image = [UIImage imageNamed:nil];
        }
        else
        {
            cell.iconMessageReadFlag.image = [UIImage imageNamed:@"message_icon_dot_red.png"];
        }
        switch (dto.MessageType) {
                
            case SystemMessage:
                cell.imgMessageType.image = [UIImage imageNamed:@"message_icon_message_03.png"];
                break;
                
            case StrategyMessage:
                cell.imgMessageType.image = [UIImage imageNamed:@"message_icon_message_01.png"];
                break;
                
            case ProviderMessage:
                cell.imgMessageType.image = [UIImage imageNamed:@"message_icon_message_02.png"];
                break;
                
            default:
                break;
        }
        cell.lblMessageProvider.text = dto.SenderName;
        cell.lblMessageDetail.text = dto.Context;
        cell.lblMessageArriveTime.text = [self localizateMessageTime:dto.MessageTime];
        cell.SenderId = dto.SenderId;
        cell.MessageId = dto.MessageId;
    }
    
    return cell;
}

- (NSString *)localizateMessageTime:(NSDate *)messageTime
{
    NSString *des = [messageTime description];
    des = [des substringFromIndex:11];
    return des;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(BOOL) deleteMessageItem:(int) messageId
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Message?delete=&messageId=%d",WEB_URL, messageId];
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
            NSException *ex = [[NSException alloc] initWithName:@"DeleteException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
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
        FAMessage* item = dataSource[indexPath.row];
        if([self deleteMessageItem:item.MessageId] == YES)
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
