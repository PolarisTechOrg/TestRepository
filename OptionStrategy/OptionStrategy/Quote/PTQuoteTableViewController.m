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
#import "UIColorExtension.h"
#import "PTQuoteHeaderDelegate.h"

@implementation PTQuoteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    itemTableCellIdentifier = @"QuoteTableCell";
    tableViewCellArray = [NSMutableDictionary dictionary];
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
    PTQuoteTableViewCell *cell = (PTQuoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[PTQuoteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemTableCellIdentifier];
    }
    
    int row = indexPath.row;
    NSString *key = [NSString stringWithFormat:@"%d",row];

    cell.btCallBackGroud.tag = row;
    cell.btPutBackGroud.tag = row;
//    if(row%2==1){
//        cell.btCallBackGroud.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//        cell.btPutBackGroud.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//    }
    
    NSMutableDictionary *obj = [tableViewCellArray objectForKey:key];
    if(obj!=nil){
        [tableViewCellArray removeObjectForKey:key];
    }
    
    [tableViewCellArray setObject:cell forKey:key];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 154;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 33;
}

NSString *str = @"2014/11/27▼";
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"QuetoHeaderView" owner:self options:nil];
    
    PTQuetoHeaderView *headView = (PTQuetoHeaderView *)[nib objectAtIndex:0];
    [headView.btSelectDate setTitle:str forState:UIControlStateNormal];
    
    headView.headerDelegate = self;
    return headView;
}

-(void)selectVariety{
    NSLog(@"点击导航");
}

-(void)selectExpiredTime{
    NSLog(@"选择时间");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     PTQuoteTableViewCell *cell = (PTQuoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

//点击按钮，设置其他按钮背景颜色
-(void)setLeftButtonBackGround:(UIButton *)button
{
    for(NSString *key in tableViewCellArray)
    {
        PTQuoteTableViewCell *ptCell = (PTQuoteTableViewCell *)[tableViewCellArray objectForKey:key];
        UIButton *b = ptCell.btCallBackGroud;
        b.backgroundColor = [UIColor whiteColor];
//        int tag = b.tag;
//        NSLog(@"%d,%@",tag,key);
//        if(tag%2==1){
//            b.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//        }else{
//            b.backgroundColor = [UIColor whiteColor];
//        }
    }

    button.backgroundColor = [UIColor yellowColor];
}

//点击按钮，设置其他按钮背景颜色
-(void)setRightButtonBackGround:(UIButton *)button
{
    for(NSString *key in tableViewCellArray)
    {
        PTQuoteTableViewCell *ptCell = (PTQuoteTableViewCell *)[tableViewCellArray objectForKey:key];
        UIButton *b = ptCell.btPutBackGroud;
        int tag = b.tag;
        b.backgroundColor = [UIColor whiteColor];
//        if(tag%2==1){
//            b.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//        }else{
//            b.backgroundColor = [UIColor whiteColor];
//        }
    }
    
    button.backgroundColor = [UIColor yellowColor];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(IBAction)leftButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    [self setLeftButtonBackGround:button];
}

-(IBAction)rightButtonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    [self setRightButtonBackGround:button];
}

@end
