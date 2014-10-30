//
//  FAMessageDetailViewController.m
//  FcpAssistant
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAMessageDetailViewController.h"
#import "FAMessageDetailViewCell2.h"
#import "FAMessageDetailHeaderViewCell.h"
#import "FAClientMessageDto.h"
#import "FAMessageDetail.h"
#import "FAMessage.h"

#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAFormater.h"


@interface FAMessageDetailViewController ()

@end

@implementation FAMessageDetailViewController

@synthesize SendId;
@synthesize MessageType;
@synthesize MaxMessageId;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"详情";   
    
    NSMutableArray *dtoArray = [self LoadDataFromServer:SendId withType:MessageType withMessageId:MaxMessageId];
    
    dataDictionary = [self analyzeDataFromServer:dtoArray];
    if (dataSource != nil)
    {
        [dataSource removeAllObjects];
    }
    dataSource = [self formateDataArray:dataDictionary];
    
    // push test
    UIImage *collectionButtonImage = [UIImage imageNamed:@"Strategy_icon_strategy_detail_collection_white"];
    UIBarButtonItem *collectionButton = [[UIBarButtonItem alloc] initWithImage:collectionButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(doCollection)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:collectionButton, nil];
}

// test push
- (void)doCollection
{
    [self viewDidLoad];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


//- (CGSize)getDescriptionHeight:(NSString *)content
//{
//    UIFont *font = [UIFont systemFontOfSize:12];
//    CGSize size = CGSizeMake(320, 100);
//    
//    CGSize labelSize = [content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeCharacterWrap];
//    
//    return labelSize;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return dataSource.count*2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    int curSection = section % 2;
    
    if (curSection == 0)
    {
        return 1;
    }
    else
    {
        FAMessageDetail *detail = (FAMessageDetail *)dataSource[(section-1)/2];
        return detail.DetailList.count;
    }
}

- (void)showHeader:(FAMessageDetailHeaderViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMessageDetail *detail = (FAMessageDetail *)dataSource[(indexPath.section)/2];
    
    if(detail)
    {
        cell.lblMessageDate.text = detail.DateString;
    }
}

- (void)showContent:(FAMessageDetailViewCell2 *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMessageDetail *detail = (FAMessageDetail *)dataSource[(indexPath.section-1)/2];
    
    if (indexPath.row > detail.DetailList.count-1)
    {
        return;
    }
    FAMessage *message = (FAMessage *)detail.DetailList[indexPath.row];
    
    cell.lblTextBody.text = message.Context;
    cell.lblLatedReceiveTime.text = message.MessageTimeString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int curSection = indexPath.section % 2;
    
    if (curSection == 0)
    {
        FAMessageDetailHeaderViewCell *cell = (FAMessageDetailHeaderViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
        
        if(!cell)
        {
            cell = [[FAMessageDetailHeaderViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemHeaderCellIdentifier];
        }
        
        [self showHeader:cell cellForRowAtIndexPath:indexPath];
        return cell;
    }
    else
    {
        FAMessageDetailViewCell2 *cell= (FAMessageDetailViewCell2*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        
        if (!cell)
        {
            cell = [[FAMessageDetailViewCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        }
        
        [self showContent:cell cellForRowAtIndexPath:indexPath];
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int curSection = indexPath.section % 2;
    
    if (curSection == 0)
    {
        return 38;
    }
    else
    {
        return 81;
//        FAMessageDetail *detail = (FAMessageDetail *)dataSource[indexPath.section-1]; // section > 0
//        FAMessage *message = (FAMessage *)detail.DetailList[indexPath.row];
//        return [self getDescriptionHeight:message.Context].height;
    }
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMessageDetailHeaderView" owner:self options:nil];
//    
//    UIView *headerView = (UIView *) [nib objectAtIndex:0];
//    headerView.frame = CGRectMake(0, 0, 320, 50);
//    return headerView;
//}

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
    itemHeaderCellIdentifier = @"FAMessageDetailHeaderCell";
    
    itemCellIdentifier = @"FAMessageDetailCell";
}

-(void)registerXibFile
{
    UINib *headerCellNib = [UINib nibWithNibName:@"FAMessageDetailHeaderViewCell" bundle:nil];
    [self.tableView registerNib:headerCellNib forCellReuseIdentifier:itemHeaderCellIdentifier];
    
    UINib *cellNib = [UINib nibWithNibName:@"FAMessageDetailViewCell2" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:itemCellIdentifier];
}

-(NSMutableArray *)LoadDataFromServer:(NSString *)sendId withType:(int)messageType withMessageId:(int)maxMessageId
{
    NSString *requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message?senderId=%@&messageType=%d&beginId=%d", WEB_URL, sendId, messageType, maxMessageId];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoObjArray =[FAJSONSerialization toArray:[FAClientMessageDto class] fromData:replyData];
        
        return [NSMutableArray arrayWithArray:dtoObjArray];
    }
    else
    {
        return nil;
    }
}

- (NSMutableDictionary *)analyzeDataFromServer:(NSArray *)data
{
    if(dataDictionary == nil)
    {
        dataDictionary = [NSMutableDictionary dictionaryWithCapacity:64];
    }
    
    if (data)
    {
        for(id item in data)
        {
            if(!item)
            {
                continue;
            }
            
            FAClientMessageDto *dtoMessage = (FAClientMessageDto *)item;
            FAMessage *message = [self createMessage:dtoMessage];
            
            NSString *dateString = [FAFormater toShortDateStringWithNSDate:dtoMessage.MessageTime];
            
            FAMessageDetail *detail = nil;
            if([dataDictionary objectForKey:dateString])
            {
                detail = (FAMessageDetail *)[dataDictionary objectForKey:dateString];
                
                [self updateMessageDetail:detail withMessage:message];
            }
            else
            {
                detail = [self createMessageDetail:message];
                
                [dataDictionary setObject:detail forKey:dateString];
            }
            
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"MessageTime" ascending:NO];
            [detail.DetailList sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        }
    }
    
    return dataDictionary;//[NSMutableArray arrayWithArray:[dataDictionary allValues]];
}

- (NSMutableArray *)formateDataArray:(NSMutableDictionary *)dataDict
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[dataDictionary allValues]];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"Date" ascending:NO];
    [array sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    
    return array;
}

- (void)sortArray:(NSArray *)array withKey:(NSString *)key ascending:(BOOL)ascend
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascend];
    [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
}

- (void)updateMessageDetail:(FAMessageDetail *)detail withMessage:(FAMessage *)message
{
    detail.Date = message.MessageTime;
    detail.DateString = [FAFormater toShortDateStringWithNSDate:message.MessageTime];
    [detail.DetailList addObject:message];
    
    [self sortArray:detail.DetailList withKey:@"MessageTime" ascending:NO];
}

- (FAMessageDetail *)createMessageDetail:(FAMessage *)message
{
    FAMessageDetail *detail = [[FAMessageDetail alloc] init];
    
    detail.SenderId = message.SenderId;
    detail.MessageType = message.MessageType;
    detail.Date = message.MessageTime;
    detail.DateString = [FAFormater toShortDateStringWithNSDate:message.MessageTime];
    detail.DetailList = [[NSMutableArray alloc] init];
    [detail.DetailList addObject:message];
    
    return detail;
}

- (FAMessage *)createMessage:(FAClientMessageDto *)dtoMessage
{
    FAMessage *message = [[FAMessage alloc] init];
    
    message.ReadFlag = dtoMessage.ReadFlag;
    message.MessageId = dtoMessage.MessageId;
    message.MessageType = dtoMessage.MessageType;
    message.SenderId = dtoMessage.SenderId;
    message.SenderName = dtoMessage.SenderName;
    message.MessageTime = dtoMessage.MessageTime;
    message.MessageTimeString = [FAFormater toShortTimeStringWithNSDate:dtoMessage.MessageTime];
    message.Context = dtoMessage.Context;
    
    return message;
}

- (void)receivePushMessage:(NSString *)message
{
    [self viewDidLoad];
    [self viewWillAppear:YES];
}

@end
