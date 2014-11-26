////
////  PTStrategyViewController.m
////  OptionStrategy
////
////  Created by user01 on 11/25/14.
////  Copyright (c) 2014年 Polaris Technology. All rights reserved.
////
//
//#import "PTStrategyViewController.h"
//#import "PTStrategyHeaderDelegate.h"
//#import "PTStrategyTableViewCell.h"
//#import "PTStrategyHeaderView.h"
//
//@interface PTStrategyViewController ()
//
//@end
//
//@implementation PTStrategyViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    itemTableCellIdentifier = @"StrategyTableCell";
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PTStrategyTableViewCell *cell = (PTStrategyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier forIndexPath:indexPath];
//    
//    if(!cell){
//        cell = [[PTStrategyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemTableCellIdentifier];
//    }
//    
//    int row = indexPath.row;
//    NSString *key = [NSString stringWithFormat:@"%d",row];
//    
//    cell.btLeftBackGroud.tag = row;
//    cell.btLeftRadio.tag = row;
//    cell.btRightBackGroud.tag = row;
//    cell.btRightRadio.tag = row;
//    //    if(row%2==1){
//    //        cell.btCallBackGroud.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//    //        cell.btPutBackGroud.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//    //    }
//    
//    NSMutableDictionary *obj = [tableViewCellArray objectForKey:key];
//    if(obj!=nil){
//        [tableViewCellArray removeObjectForKey:key];
//    }
//    
//    [tableViewCellArray setObject:cell forKey:key];
//    
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 154;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 33;
//}
//
//NSString *str = @"2014/11/27▼";
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"StrategyHeaderView" owner:self options:nil];
//    
//    PTStrategyHeaderView *headView = (PTStrategyHeaderView *)[nib objectAtIndex:0];
//    [headView.btSelectDate1 setTitle:str forState:UIControlStateNormal];
//    
//    headView.headerDelegate = self;
//    return headView;
//}
//
//-(void)selectVariety{
//    NSLog(@"点击导航");
//}
//
//-(void)selectStrategy{
//    NSLog(@"选择策略");
//}
//
//-(void)selectLeftExpiredTime{
//    NSLog(@"选择时间1");
//}
//
//-(void)selectRightExpiredTime{
//    NSLog(@"选择时间2");
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PTStrategyTableViewCell *cell = (PTStrategyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier forIndexPath:indexPath];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//}
//
////点击按钮，设置其他按钮背景颜色
//-(void)setLeftButtonBackGround:(UIButton *)button
//{
//    for(NSString *key in tableViewCellArray)
//    {
//        PTStrategyTableViewCell *ptCell = (PTStrategyTableViewCell *)[tableViewCellArray objectForKey:key];
//        UIButton *b = ptCell.btLeftBackGroud;
//        b.backgroundColor = [UIColor whiteColor];
//        //        int tag = b.tag;
//        //        NSLog(@"%d,%@",tag,key);
//        //        if(tag%2==1){
//        //            b.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//        //        }else{
//        //            b.backgroundColor = [UIColor whiteColor];
//        //        }
//    }
//    
//    button.backgroundColor = [UIColor yellowColor];
//}
//
////点击按钮，设置其他按钮背景颜色
//-(void)setRightButtonBackGround:(UIButton *)button
//{
//    for(NSString *key in tableViewCellArray)
//    {
//        PTStrategyTableViewCell *ptCell = (PTStrategyTableViewCell *)[tableViewCellArray objectForKey:key];
//        UIButton *b = ptCell.btRightBackGroud;
//        int tag = b.tag;
//        b.backgroundColor = [UIColor whiteColor];
//        //        if(tag%2==1){
//        //            b.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
//        //        }else{
//        //            b.backgroundColor = [UIColor whiteColor];
//        //        }
//    }
//    
//    button.backgroundColor = [UIColor yellowColor];
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
//}
//
//-(IBAction)leftButtonClick:(id)sender{
//    UIButton *button = (UIButton *)sender;
//    [self setLeftButtonBackGround:button];
//}
//
//-(IBAction)rightButtonClick:(id)sender{
//    UIButton *button = (UIButton *)sender;
//    [self setRightButtonBackGround:button];
//}
//
//@end
