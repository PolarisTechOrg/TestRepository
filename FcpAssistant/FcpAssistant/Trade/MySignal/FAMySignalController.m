//
//  FAMySignalController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMySignalController.h"
#import "FAMySignalItemHeaderView.h"
#import "FAMySignalItemViewCell.h"

@interface FAMySignalController ()

@end

@implementation FAMySignalController

NSString* itemCellIdentifier;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"信号";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initializeData
{
    itemCellIdentifier = @"mySignalItemCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAMySignalItemViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 3;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FAMySignalItemViewCell* cell= (FAMySignalItemViewCell*)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    
    if (!cell)
    {
        cell = [[FAMySignalItemViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 47;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FAMySignalItemHeaderView" owner:self options:nil];
    
    UIView *headerView = (UIView *) [nib objectAtIndex:0];
    headerView.frame = CGRectMake(0, 0, 320, 50);
    return headerView;
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
