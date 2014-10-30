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
#import "FAMainController.h"
#import "FAMeberLoginController.h"
#import "FAMessageEntry.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"
#import "FAUtility.h"
#import "FAAccountManager.h"
#import "FAGeTuiReceiver.h"

@interface FAMessageController ()

@end

@implementation FAMessageController

@synthesize unReadCount;

@synthesize maxMessageId;


- (id)init
{
    if ([super init])
    {
        unReadCount = 0;
        maxMessageId = 0;
        
        [self loadUnReadMessageCount];
        
        [[FAGeTuiReceiver shareInstance] registerMessageReceiver:self]; // register push
    }
    return self;
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = unReadCount == 0 ? @"消息" : [NSMutableString stringWithFormat:@"消息(%d)", unReadCount];
    
    if(!dataDictionary)
    {
        dataDictionary = [NSMutableDictionary dictionaryWithCapacity:8];
    }
    dataSource = [[NSMutableArray alloc] init];
    
    NSMutableArray *messageList = [self LoadMessageDataFromServer];
    NSMutableArray *entryList = [self analyzeDataFromServer:messageList];
    
    [dataSource removeAllObjects];
    [dataSource addObjectsFromArray:entryList];
    
    // push test
    UIImage *collectionButtonImage = [UIImage imageNamed:@"Strategy_icon_strategy_detail_collection_white"];
    UIBarButtonItem *collectionButton = [[UIBarButtonItem alloc] initWithImage:collectionButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(doCollection)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:collectionButton, nil];
}

// test push
- (void)doCollection
{
    [self viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if(![self checkLoginStatus])
    {
        return;
    }
    
    [self loadUnReadMessageCount];
    [self viewDidLoad];
    
    [self.tableView reloadData];
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
        FAMessageEntry *messageEntry = dataSource[indexPath.row];
       
        if(!messageEntry)
        {
            return cell;
        }

        if(messageEntry.ReadFlag)
        {
            cell.iconMessageReadFlag.image = [UIImage imageNamed:nil];
        }
        else
        {
            cell.iconMessageReadFlag.image = [UIImage imageNamed:@"message_icon_dot_red.png"];
        }
        switch (messageEntry.MessageType) {
                
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
        cell.lblMessageProvider.text = messageEntry.SenderName;
        cell.lblMessageDetail.text = messageEntry.Context;
        cell.lblMessageArriveTime.text = [FAFormater toShortTimeStringWithNSDate:messageEntry.Date];
        cell.SenderId = messageEntry.SenderId;
        cell.MessageId = messageEntry.MessageId;
    }
    
    return cell;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
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
        FAMessageEntry *item = dataSource[indexPath.row];
        if([self deleteAllMessage:item.SenderId withType:item.MessageType])
        {
            if (!item.ReadFlag)
            {
                [self loadUnReadMessageCount];
                [self refreshUnReadCount];
            }
            
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
    
    FAMessageEntry *item = dataSource[indexPath.row];
    if([self readAllMessage:item.SenderId withType:item.MessageType])
    {
        item.ReadFlag = YES;
        
        [self loadUnReadMessageCount];
        [self refreshUnReadCount];
    }
    
    FAMessageViewCell2 *cell = (FAMessageViewCell2 *)[tableView cellForRowAtIndexPath:indexPath];
    cell.iconMessageReadFlag.image = nil;
    
    FAMessageDetailViewController *subController = [[FAMessageDetailViewController alloc] init];subController.hidesBottomBarWhenPushed = YES;
    subController.SendId = item.SenderId;
    subController.MessageType = item.MessageType;
    [self pushNewViewController:subController];
    
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}


#pragma mark - Private tool function

-(void)initializeData
{
    itemCellIdentifier = @"FAMessageCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMessageViewCell2" bundle:nil];
    
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

-(NSMutableArray *)LoadMessageDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message?all=&beginId=%d", WEB_URL, maxMessageId];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoObjArray =[FAJSONSerialization toArray:[FAClientMessageDto class] fromData:replyData];
        
        NSMutableArray *dtoMessageArray = [NSMutableArray arrayWithCapacity:128];
        for(id dto in dtoObjArray)
        {
            if(!dto)
            {
                continue;
            }
            
            FAClientMessageDto *dtoMessage = (FAClientMessageDto *)dto;
            [dtoMessageArray addObject:dtoMessage];
        }
        
        return  dtoMessageArray;
    }
    else
    {
        return nil;
    }
}

// <MessageType, <SenderId, FAMessageEntry>>
- (NSMutableArray *)analyzeDataFromServer:(NSArray *)data
{
    if(data)
    {
        for(id item in data)
        {
            if(!item)
            {
                continue;
            }
            
            FAMessageEntry *entry = nil;
            NSMutableDictionary *senderDict = nil;
            FAClientMessageDto *dtoMessage = (FAClientMessageDto *)item;
            NSNumber *typeKey = [NSNumber numberWithInt:(int)dtoMessage.MessageType];
            
            // update maxMessageId
            if (maxMessageId < dtoMessage.MessageId)
            {
                maxMessageId = dtoMessage.MessageId;
            }
            
            // update dictionary and array
            if([dataDictionary objectForKey:typeKey])
            {
                senderDict = (NSMutableDictionary *)[dataDictionary objectForKey:typeKey];
                
                entry = (FAMessageEntry *)[senderDict objectForKey:dtoMessage.SenderId];
                if (entry)
                {
                    if(dtoMessage.MessageTime > entry.Date)
                    {
                        [self updateEntry:entry withDtoMessage:dtoMessage];
                        [senderDict setObject:entry forKey:entry.SenderId];
                    }
                }
                else
                {
                    entry = [self createEntry:dtoMessage];
                    [senderDict setObject:entry forKey:entry.SenderId];
                }
            }
            else
            {
                entry = [self createEntry:dtoMessage];
                senderDict = [NSMutableDictionary dictionaryWithCapacity:32];
                [senderDict setObject:entry forKey:entry.SenderId];
                
                [dataDictionary setObject:senderDict forKey:typeKey];
            }
        }
    }
    
    // to entryArray
    NSMutableArray *entryArray = [self formateDataArray:dataDictionary];
    
    // sort
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"Date" ascending:NO];
    [entryArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    return entryArray;
}

- (NSMutableArray *)formateDataArray:(NSMutableDictionary *)dataDict
{
    NSMutableArray *entryArray = [NSMutableArray arrayWithCapacity:32];
    
    NSArray *keys = [dataDict allKeys];
    if ((NSNull *)keys == [NSNull null])
    {
        return entryArray;
    }
    
    for (NSNumber *messageType in keys)
    {
        NSMutableDictionary *subDict = (NSMutableDictionary *)[dataDict objectForKey:messageType];
        
        if ((NSNull *)subDict == [NSNull null])
        {
            continue;
        }
        
        NSArray *subKeys = [subDict allKeys];
        if((NSNull *)subKeys == [NSNull null])
        {
            continue;
        }
        
        for (NSString *senderId in subKeys)
        {
            FAMessageEntry *entry = (FAMessageEntry *)[subDict objectForKey:senderId];
            if (entry == nil)
            {
                continue;
            }
            
            [entryArray addObject:entry];
        }
    }
    
    return entryArray;
}

- (FAMessageEntry *)createEntry:(FAClientMessageDto *)dtoMessage
{
    FAMessageEntry *entry = [[FAMessageEntry alloc] init];
    entry.SenderId = dtoMessage.SenderId;
    entry.MessageType = dtoMessage.MessageType;
    entry.MessageId = dtoMessage.MessageId;
    entry.Date = dtoMessage.MessageTime;
    entry.DateString = [FAFormater toShortTimeStringWithNSDate:dtoMessage.MessageTime];
    entry.SenderName = dtoMessage.SenderName;
    entry.Context= dtoMessage.Context;
    entry.ReadFlag = dtoMessage.ReadFlag;
    
    return entry;
}

- (void)updateEntry:(FAMessageEntry *)entry withDtoMessage:(FAClientMessageDto *)dtoMessage
{
    entry.MessageId = dtoMessage.MessageId;
    entry.ReadFlag = dtoMessage.ReadFlag;
    entry.Date = dtoMessage.MessageTime;
    entry.DateString = [FAFormater toShortTimeStringWithNSDate:dtoMessage.MessageTime];
    entry.SenderName = dtoMessage.SenderName;
    entry.Context = dtoMessage.Context;
}

- (BOOL)checkLoginStatus
{
    BOOL hasLogin = [[FAAccountManager shareInstance] hasLogin];
    
    if (!hasLogin)
    {
        BOOL hasLogin = [[FAAccountManager shareInstance] hasLogin];
        
        if (!hasLogin)
        {
            [self presentViewController:[[FAMeberLoginController alloc] init] animated:YES completion:^{
                NSLog(@"FINISH LOGIN VIEW");
            }];
            
            [self viewDidAppear:YES];
        }
    }
    
    return hasLogin;
}

- (void)loadUnReadMessageCount
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message?unRead", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        unReadCount = [[FAJSONSerialization toObject:nil fromData:replyData] intValue];
    }
    else
    {
        unReadCount = 0;
    }
    
    if (unReadCount > 0)
    {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unReadCount];
    }
    else
    {
        self.tabBarItem.badgeValue = nil;
    }
}

- (void)refreshUnReadCount
{
    if(unReadCount == 0)
    {
        self.navigationItem.title = @"消息";
        self.tabBarItem.badgeValue = nil;
    }
    else
    {
        self.navigationItem.title = [NSMutableString stringWithFormat:@"消息(%d)", unReadCount];
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", unReadCount];
    }
}

-(BOOL) deleteMessageItem:(int) messageId
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Message?delete=&messageId=%d",WEB_URL, messageId];
        NSURL * requestUrl =[NSURL URLWithString:requestUrlStr];
        
        NSError *error;
        FAHttpHead *httpHead = [FAHttpHead defaultInstance];
        
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

-(BOOL) deleteAllMessage:(NSString *)senderId withType:(int)messageType
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Message?delete=&senderId=%@&messageType=%d",WEB_URL, senderId, messageType];
        NSURL * requestUrl =[NSURL URLWithString:requestUrlStr];
        
        NSError *error;
        FAHttpHead *httpHead = [FAHttpHead defaultInstance];
        
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

- (BOOL)readMessage:(int)messageId
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Message?read=&messageId=%d",WEB_URL, messageId];
        NSURL * requestUrl =[NSURL URLWithString:requestUrlStr];
        
        NSError *error;
        FAHttpHead *httpHead = [FAHttpHead defaultInstance];
        
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHead httpBody:nil error: &error];
        NSLog(@"%@",[[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding]);
        if(error == nil)
        {
            return YES;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"GETException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
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

- (BOOL)readAllMessage:(NSString *)senderId withType:(int)messageType
{
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/Message?read=&senderId=%@&messageType=%d", WEB_URL, senderId, messageType];
        
        NSURL * requestUrl =[NSURL URLWithString:requestUrlStr];
        
        NSError *error;
        FAHttpHead *httpHead = [FAHttpHead defaultInstance];
        
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHead httpBody:nil error: &error];
        NSLog(@"%@",[[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding]);
        if(error == nil)
        {
            return YES;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"GETException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
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

- (void)receivePushMessage:(NSString *)message
{
    [self viewWillAppear:YES];
}

@end
