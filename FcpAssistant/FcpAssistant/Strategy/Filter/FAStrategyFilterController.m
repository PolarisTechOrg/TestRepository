//
//  FAStrategyFilterController.m
//  FcpAssistant
//
//  Created by admin on 11/3/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyFilterController.h"
#import "FAStrategyHeadingViewCell.h"
#import "FAStrategyFilteringViewCell.h"
#import "FAPriceParten.h"
#import "FAVarieties.h"

#import "FAJSONSerialization.h"
#import "FAFoundation.h"
#import "FAHttpUtility.h"
#import "FAPricePartenDto.h"
#import "FAVarietiesDto.h"
#import "FAHttpHead.h"
#import "math.h"

@interface FAStrategyFilterController ()

@end

@implementation FAStrategyFilterController

@synthesize pricePartenSource;
@synthesize varietiesSource;
@synthesize strategyController;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"策略筛选";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    pricePartenSource = [self loadPricePartenDataFromServer];
    varietiesSource = [self loadVarietiesDataFromServer];
}

- (void)clickRightButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 35;
    }
    else if(indexPath.row == 1)
    {
        return ceil(varietiesSource.count/4+1)*40+30;
    }
    else if(indexPath.row == 2)
    {
        return 35;
    }
    else
    {
        return ceil(pricePartenSource.count/4+1)*40+30;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        FAStrategyHeadingViewCell *cell = (FAStrategyHeadingViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
        
        if(cell == nil)
        {
            cell = [(FAStrategyHeadingViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemHeaderCellIdentifier];
        }
        
        cell.lblHeadingTitle.text = @"按品种筛选";
        
        return cell;
    }
    else if (indexPath.row == 1)
    {
        FAStrategyFilteringViewCell *cell = (FAStrategyFilteringViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        
        if(cell == nil)
        {
            cell = [(FAStrategyFilteringViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        }
        
        cell.varietiesSource = varietiesSource;
        cell.parentTableView = tableView;
        [cell fillingData];
        
        return cell;
    }
    else if (indexPath.row == 2)
    {
        FAStrategyHeadingViewCell *cell = (FAStrategyHeadingViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
        
        if(cell == nil)
        {
            cell = [(FAStrategyHeadingViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemHeaderCellIdentifier];
        }
        
        cell.lblHeadingTitle.text = @"按策略趋势筛选";
        
        return cell;
    }
    else
    {
        FAStrategyFilteringViewCell *cell = (FAStrategyFilteringViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        
        if(cell == nil)
        {
            cell = [(FAStrategyFilteringViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
        }
        
        cell.pricePartenSource = pricePartenSource;
        cell.parentTableView = tableView;
        [cell fillingData];
        
        return cell;
    }
    
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

-(void)initializeData
{
    itemHeaderCellIdentifier = @"FAStrategyHeadingCell";
    itemCellIdentifier = @"FAStrategyFilteringCell";
}

-(void)registerXibFile
{
    UINib *itemCellNib = [UINib nibWithNibName:@"FAStrategyHeadingViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemHeaderCellIdentifier];
    
    UINib *itemCell2Nib = [UINib nibWithNibName:@"FAStrategyFilteringViewCell" bundle:nil];
    [self.tableView registerNib:itemCell2Nib forCellReuseIdentifier:itemCellIdentifier];
}


- (NSMutableDictionary *)loadPricePartenDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/StrategySearch?priceParten", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    NSMutableDictionary *dtoDict = [NSMutableDictionary dictionaryWithCapacity:32];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoArray =[FAJSONSerialization toArray:[FAPricePartenDto class] fromData:replyData];
        
        if (!dtoArray || dtoArray.count == 0)
        {
            return dtoDict;
        }
        
        for (int i = 0; i < dtoArray.count; i++)
        {
            if (!dtoArray[i])
            {
                continue;
            }
            
            FAPricePartenDto *dto = dtoArray[i];
            FAPriceParten *priceParten = [[FAPriceParten alloc] init];
            
            priceParten.PartenID = dto.PartenID;
            priceParten.PartenName = dto.PartenName;
            priceParten.includeFlag = false;
            priceParten.seqId = i;
            
            [dtoDict setObject:priceParten forKey:[NSNumber numberWithInt:priceParten.seqId]];
        }
        
        return dtoDict;
    }
    else
    {
        return dtoDict;
    }
}

- (NSMutableDictionary *)loadVarietiesDataFromServer
{
    NSString * requestUrlStr = [[NSString alloc] initWithFormat:@"%@api/StrategySearch?varieies", WEB_URL];
    
    NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
    NSMutableDictionary *dtoDict = [NSMutableDictionary dictionaryWithCapacity:32];
    
    NSError *error;
    NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
    
    if(error == nil)
    {
        NSArray *dtoArray =[FAJSONSerialization toArray:[FAVarietiesDto class] fromData:replyData];
        
        if (!dtoArray || dtoArray.count == 0)
        {
            return dtoDict;
        }
        
        for (int i = 0; i < dtoArray.count; i++)
        {
            if (!dtoArray[i])
            {
                continue;
            }
            
            FAVarietiesDto *dto = dtoArray[i];
            FAVarieties *varieties = [[FAVarieties alloc] init];
            
            varieties.Code = dto.Code;
            varieties.Name = dto.Name;
            varieties.includeFlag = false;
            varieties.seqId = i;
            
            [dtoDict setObject:varieties forKey:[NSNumber numberWithInt:varieties.seqId]];
        }
        
        return dtoDict;
    }
    else
    {
        return nil;
    }
}
@end
