//
//  FAStrategyController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-4.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAStrategyController.h"
#import "FAStrategyInfoViewCell.h"
#import "FAStrategyDetailController.h"
#import "FAMyCollectItem.h"

@interface FAStrategyController ()

@end

@implementation FAStrategyController

NSString* itemCellIdentifier;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"策略";
    
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    for(int i=0; i<10; i++)
    {
        FAMyCollectItem *detail = [[FAMyCollectItem alloc] initWithStrategyId:i];
        detail.strategyName = [NSString stringWithFormat:@"赢家%d号", i];
        
        [dataSource addObject:detail];
    }
    
    self.dataSource = dataSource;
}

- (void)initializeData
{
    itemCellIdentifier = @"StrategyViewCell";
}

- (void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAStrategyInfoViewCell" bundle:nil];
    
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (void)enterDetailView:(int) strategyId
{
    FAStrategyDetailController * detailController = [[FAStrategyDetailController alloc] init];
//    detailController.strategyId = strategyId;
    
    [self.navigationController pushViewController:detailController animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     itemCellIdentifier = @"StrategyViewCell";
    FAStrategyInfoViewCell *cell = (FAStrategyInfoViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    // Configure the cell...
    if(!cell)
    {
        cell = [[FAStrategyInfoViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    
//    if(indexPath.row < self.dataSource.count)
//    {
//        FAMyCollectItem *items = (FAMyCollectItem *)self.dataSource[indexPath.row];
//        
//        cell.lblStrategyName.text = items.strategyName;
//    }
    
    if(indexPath.row < 10)
    {
        cell.lblStrategyName.text = @"策略赢家1号测试";
        cell.imgStrategyMarked.image = [UIImage imageNamed:@"common_purchase_flag.png"];
        cell.imgStrategyStar.image = [UIImage imageNamed:@"common_star_5.png"];
        cell.lblCollectionPeopleNumber.text = @"132";
        cell.lblProvider.text = @"常胜将军";
        cell.imgPerformanceBackMap.image = [UIImage imageNamed:@"mycollect_profit_red.png"];
        cell.lblPerformance.text = @"150.5%";
    }
    
    return cell;
}

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
