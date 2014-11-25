//
//  PTQuoteTableViewController.m
//  OptionStrategy
//
//  Created by user01 on 11/24/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "PTQuoteTableViewController.h"
#import "PTQuoteTableViewCell.h"
#import "PTQuetoHeaderView.h"

@implementation PTQuoteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    leftButtonsArray = [NSMutableDictionary dictionary];
    rightButtonsArray = [NSMutableDictionary dictionary];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTQuoteTableViewCell *cell = (PTQuoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QuoteTableCell" forIndexPath:indexPath];
    
    NSLog(@"%d",leftButtonsArray.count);
    if(cell){
        cell = [[PTQuoteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"QuoteTableCell"];
    }
    int row = indexPath.row;
    NSString *key = [NSString stringWithFormat:@"%d",row];

    UIButton *button = [[UIButton alloc] init];
    button.tag = row;
    cell.btCallBackGroud.tag = row;
    NSMutableDictionary *obj = [leftButtonsArray objectForKey:key];
    if(obj != nil){
        [leftButtonsArray removeObjectForKey:key];
    }
    [leftButtonsArray setObject:button forKey:key];
    
    cell.btPutBackGroud.tag = row;
    NSMutableDictionary *obj1 = [rightButtonsArray objectForKey:key];
    if(obj1 != nil){
        [rightButtonsArray removeObjectForKey:key];
    }
    [rightButtonsArray setObject:cell.btPutBackGroud forKey:key];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 154;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 33;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"QuetoHeaderView" owner:self options:nil];
    
    PTQuetoHeaderView *headView = (PTQuetoHeaderView *)[nib objectAtIndex:0];
    
    return headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     PTQuoteTableViewCell *cell = (PTQuoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"QuoteTableCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

//点击按钮，设置其他按钮背景颜色
-(void)setButtonBackGround:(NSMutableDictionary *)array button:(UIButton *)button
{
    if(array.count>0)
    {
        for(NSString *key in array)
        {
            UIButton *b = [array objectForKey:key];
            NSLog(@"%d",b.tag);
            b.backgroundColor = [UIColor whiteColor];
        }
    }
    
    button.backgroundColor = [UIColor yellowColor];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(IBAction)leftButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    
    [self setButtonBackGround:leftButtonsArray button:button];
}

-(IBAction)rightButtonClick:(id)sender{
    
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
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
