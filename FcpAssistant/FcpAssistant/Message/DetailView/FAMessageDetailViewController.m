//
//  FAMessageDetailViewController.m
//  FcpAssistant
//
//  Created by admin on 9/20/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAMessageDetailViewController.h"
#import "FAMessageDetailViewCell2.h"
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


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"详情";   
    
    dataSource = [self LoadDataFromServer:SendId withType:MessageType];
}


-(void)initializeData
{
    itemCellIdentifier = @"FAMessageDetailCell";
}

-(void)registerXibFile
{
    UINib *cellNib = [UINib nibWithNibName:@"FAMessageDetailViewCell2" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)LoadDataFromServer:(int)sendId withType:(int)messageType
{
    NSString *requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/Message?sendId=%d&messageType=%d", WEB_URL, sendId, messageType];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoObjArray =[FAJSONSerialization toArray:[FAClientMessageDto class] fromData:replyData];
        NSArray *messageArray = [self analyzeDataFromServer:dtoObjArray];
        
        // sort
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"MessageTime" ascending:YES];
        [messageArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
        
        return  messageArray;
    }
    else
    {
        return nil;
    }
}

- (NSArray *)analyzeDataFromServer:(NSArray *)data
{
    if(data == nil || data.count == 0)
    {
        return nil;
    }
    
//    NSMutableArray *detailArray = [NSMutableArray arrayWithCapacity:128];
    NSMutableDictionary *detailDict = [NSMutableDictionary dictionaryWithCapacity:128];
    
    for(id item in data)
    {
        if(!item)
        {
            continue;
        }
        
        FAClientMessageDto *dtoMessage = (FAClientMessageDto *)item;
        FAMessage *message = [[FAMessage alloc] init];
        message.ReadFlag = dtoMessage.ReadFlag;
        message.MessageId = dtoMessage.MessageId;
        message.MessageType = dtoMessage.MessageType;
        message.SenderId = dtoMessage.SenderId;
        message.SenderName = dtoMessage.SenderName;
        message.MessageTime = dtoMessage.MessageTime;
        message.Context = dtoMessage.Context;
        
        NSString *dateString = [self generateDate:dtoMessage.MessageTime];
        
        if([detailDict objectForKey:dateString])
        {
            FAMessageDetail *detailTemp = (FAMessageDetail *)[detailDict objectForKey:dateString];
            [detailTemp.DetailList addObject:message];
        }
        else
        {
            FAMessageDetail *detail = [[FAMessageDetail alloc] init];
            detail.SenderId = message.SenderId;
            detail.MessageType = message.MessageType;
            detail.Date = message.MessageTime;
            detail.DateString = dateString;
            detail.DetailList = [[NSMutableArray alloc] init];
            [detail.DetailList addObject:message];
            
            [detailDict setObject:detail forKey:dateString];
        }
    }
    
    return [detailDict allValues];
}

- (NSString *)generateDate:(NSDate *)date
{
    //    NSMutableString *retString = nil;
    //
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        unsigned units = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
//        NSDateComponents *comps = [calendar components:units fromDate:date];
//    //
//        NSInteger year = [comps year];
    //    [retString appendFormat:@"%ld", [comps year]];
    //    [retString appendString:@"-"];
    //    [retString appendFormat:@"%ld", [comps month]];
    //    [retString appendString:@"-"];
    //    [retString appendFormat:@"%ld", [comps day]];
    //    
    //    return retString;
    
    return [[date description] substringToIndex:10];
}

- (BOOL)compareDate:(NSDate *)first withAnother:(NSDate *)last
{
    bool isEquel = YES;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps1 = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:first];
    
    NSDateComponents *comps2 = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:last];
    
    if([comps1 year] != [comps2 year])
    {
        return NO;
    }
    if([comps1 month] != [comps2 month])
    {
        return NO;
    }
    if([comps1 day] != [comps2 day])
    {
        return NO;
    }
    
    return isEquel;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    FAMessageDetail *detail = (FAMessageDetail *)dataSource[section];
    return detail.DetailList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    FAMessageDetailViewCell2 *cell= (FAMessageDetailViewCell2*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMessageDetailViewCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        cell.lblTextBody.numberOfLines = 0;
        cell.lblTextBody.adjustsFontSizeToFitWidth = YES;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    FAMessageDetailViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGFloat height = cell.lblTextBody.frame.size.height + cell.lblLatedReceiveTime.frame.size.height;
    
    return 81;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMessageDetailHeaderView" owner:self options:nil];
    
    UIView *headerView = (UIView *) [nib objectAtIndex:0];
    headerView.frame = CGRectMake(0, 0, 320, 50);
    return headerView;
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
