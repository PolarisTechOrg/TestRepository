//
//  FAMyCollectController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyCollectController.h"
#import "FAMyCollectItemViewCell.h"
#import "FAMyCollectItem.h"
#import "FAFoundation.h"
#import "FAJSONSerialization.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "FAWishlistDto.h"
#import "FADummieStrategyDetailViewModel.h"

@interface FAMyCollectController ()

@end

@implementation FAMyCollectController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"收藏";
    self.tableView.sectionFooterHeight = 0.1;
    
    dataSource = [[NSMutableArray alloc] init ];
    
    FAWishlistDto *wishList = [self LoadDataFromServer];
    if(wishList != nil && [wishList.Items count] >0)
    {
        [dataSource addObjectsFromArray:wishList.Items];
    }
  


}

-(FAWishlistDto *) LoadDataFromServer
{
    NSURL * requestUrl =[NSURL URLWithString:[WEB_URL stringByAppendingString:@"api/wishlist"]];
    
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:error];
    
    if(error == nil)
    {
        FAWishlistDto *dtoObj =[FAJSONSerialization toObject:[FAWishlistDto class] fromData:replyData];
        
        return  dtoObj;
        
    }
    else
    {
        return nil;
    }

}

-(void)initializeData
{
    itemCellIdentifier = @"collectItemViewCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMyCollectItemViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (void)enterDetailView
{
//    FAStrategyDetailController * detailController = [[FAStrategyDetailController alloc] init];
//    [self.navigationController pushViewController:detailController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAMyCollectItemViewCell *cell = (FAMyCollectItemViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMyCollectItemViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
    }
    
    if (indexPath.row < dataSource.count)
    {
        FADummieStrategyDetailViewModel* item = (FADummieStrategyDetailViewModel *)dataSource[indexPath.row];
        
        NSLog(@"Item:%@",item);

        NSString* profitBackgroundImageName = @"mycollect_profit_red";
        cell.imgProfitBackground.image = [UIImage imageNamed:profitBackgroundImageName];
        
        NSString* profitLineImageName = @"tmp_collect_profit_red";
        cell.imgProfitLine.image = [UIImage imageNamed:profitLineImageName];
        cell.imgProfitLine.image = [self drawPic:cell.imgProfitLine.image];
        cell.lblStrategyName.text = item.StrategyName;
        int star = (int)ceil(item.Star);
        NSString *gradeImageName =[NSString stringWithFormat: @"common_star_%d.png",star];
        NSLog(@"gradeImageName:%@",gradeImageName);
        cell.imgStragetyGrade.image = [UIImage imageNamed:gradeImageName];
        cell.lblStrategyProfitRate.text = [NSString stringWithFormat:@"%.1f%%",item.CumulativeReturnRatio *100];
        cell.lblStrategyProvider.text = item.ProviderName;
        cell.lblCollectCount.text = [NSString stringWithFormat:@"%d",item.FollowNumber];
    }
    
    
    return cell;
}

-(id)drawPic:(UIImage*) image
{
     UIGraphicsBeginImageContext(image.size);
    
    [image drawAtPoint:CGPointZero];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,5);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGPoint first = CGPointMake(0,0);
    CGPoint second = CGPointMake(200, 165);
    
    CGContextMoveToPoint(context,first.x
                         ,first.y);
    CGContextAddLineToPoint(context, second.x, second.y);
    CGContextStrokePath(context);
   
    UIGraphicsEndImageContext();
    return image;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self enterDetailView];
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
