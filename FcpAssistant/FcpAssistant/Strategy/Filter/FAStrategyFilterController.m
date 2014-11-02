//
//  FAStrategyFilterControllerTableViewController.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyFilterController.h"
#import "FAPricePartenDto.h"
#import "FAVarietiesDto.h"
#import "FAStrategyFilterHeaderViewCell.h"
#import "FAStrategyFilterViewCell.h"
#import "FAPriceParten.h"
#import "FAVarieties.h"

#import "FAJSONSerialization.h"
#import "FAFoundation.h"
#import "FAHttpUtility.h"
#import "FAHttpHead.h"
#import "math.h"

@interface FAStrategyFilterController ()

@end

@implementation FAStrategyFilterController

@synthesize pricePartenSource;
@synthesize varietiesSource;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    [self registerXibFile];
    
    self.navigationItem.title = @"策略筛选";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    pricePartenSource = [self loadPricePartenDataFromServer];
    varietiesSource = [self loadVarietiesDataFromServer];
    
}

- (void)clickRightButton:(id)sender
{
    NSLog(@"click doneButton");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
    {
        return ceil(varietiesSource.count/4)+1;
    }
    else if(section == 1)
    {
        return ceil(pricePartenSource.count/4)+1;
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)showHeader:(UITableView *)tableView withContent:(NSString *)title
{
    FAStrategyFilterHeaderViewCell *headerCell = (FAStrategyFilterHeaderViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
    
    if(!headerCell)
    {
        headerCell = [(FAStrategyFilterHeaderViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemHeaderCellIdentifier];
    }
    
    headerCell.lblTitle.text = title;
    
    return headerCell;
}

- (UITableViewCell *)showPricePatenCell:(UITableView *)tableView withSource:(NSMutableDictionary *)source inLocation:(NSIndexPath *)indexPath
{
    FAStrategyFilterViewCell *cell = (FAStrategyFilterViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
    
    if(cell == nil)
    {
        cell = [(FAStrategyFilterViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    CGFloat ox = cellRect.origin.x;
    CGFloat oy = cellRect.origin.y;
    CGFloat width = 70;
    CGFloat height = 36;
    
    NSArray *array = source.allValues;
    for (int i = 0; i < array.count; i++)
    {
        FAPriceParten *p = array[i];
        if (!p)
        {
            continue;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = [self getCGRect:i orignX:ox orignY:oy rectWidth:width rectHeight:height];
        btn.tag = p.seqId;
        btn.titleLabel.text = p.PartenName;
        [btn addTarget:self action:@selector(choiceUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:btn];
    }
    
    return cell;
}

- (UITableViewCell *)showVaritiesCell:(UITableView *)tableView withSource:(NSMutableDictionary *)source inLocation:(NSIndexPath *)indexPath
{
    FAStrategyFilterViewCell *cell = (FAStrategyFilterViewCell *)[tableView dequeueReusableCellWithIdentifier:itemHeaderCellIdentifier];
    
    if(cell == nil)
    {
        cell = [(FAStrategyFilterViewCell *)[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    CGFloat ox = cellRect.origin.x;
    CGFloat oy = cellRect.origin.y;
    CGFloat width = 70;
    CGFloat height = 36;
    
    NSArray *array = source.allValues;
    for (int i = 0; i < array.count; i++)
    {
        FAVarieties *p = array[i];
        if (!p)
        {
            continue;
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = [self getCGRect:i orignX:ox orignY:oy rectWidth:width rectHeight:height];
        btn.tag = p.seqId;
        btn.titleLabel.text = p.Name;
        [btn addTarget:self action:@selector(choiceUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:btn];
    }
    
    return cell;
}

- (void)choiceUp:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%ld", btn.tag);
}

- (CGRect)getCGRect:(int)index orignX:(CGFloat)x orignY:(CGFloat)y rectWidth:(CGFloat)width rectHeight:(CGFloat)height
{
    double row = floor(index/4);
    
    CGFloat currX = x * index * 75;
    CGFloat currY = y * row * 40;
    
    return CGRectMake(currX, currY, width, height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell = [self showHeader:tableView withContent:@"按品种筛选"];
        }
        else
        {
            cell = [self showPricePatenCell:tableView withSource:pricePartenSource inLocation:indexPath];
        }
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell = [self showHeader:tableView withContent:@"按策略趋势筛选"];
        }
        else
        {
            cell = [self showVaritiesCell:tableView withSource:varietiesSource inLocation:indexPath];
        }
    }
    
    return cell;
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

#pragma mark - Private tool function
-(void)initializeData
{
    itemCellIdentifier = @"FAStrategyFilterCell";
    itemHeaderCellIdentifier = @"FAStrategyFilterHeaderCell";
}

-(void)registerXibFile
{
    UINib *itemHeaderCellNib = [UINib nibWithNibName:@"FAStrategyFilterHeaderViewCell" bundle:nil];
    [self.tableView registerNib:itemHeaderCellNib forCellReuseIdentifier:itemHeaderCellIdentifier];
    
    UINib *itemCellNib = [UINib nibWithNibName:@"FAStrategyFilterViewCell" bundle:nil];
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:itemCellIdentifier];
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
            
            [dtoDict setObject:priceParten forKey:[NSNumber numberWithInt:priceParten.PartenID]];
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
            
            [dtoDict setObject:varieties forKey:varieties.Code];
        }
        
        return dtoDict;
    }
    else
    {
        return nil;
    }
}

@end
