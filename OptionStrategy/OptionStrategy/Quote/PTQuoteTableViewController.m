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
#import "PTCtpQuoteDriver.h"
#import "PTStrategyService.h"
#import "PTOptionTPriceItemViewModel.h"
#import "PTOptionTPrice.h"
#import "Converter.h"
#import "KxMenu.h"

@interface PTQuoteTableViewController ()

@property PTCtpQuoteDriver *driver;
@property NSMutableArray* codeArray;
@property NSDate* selectDate;
@property NSArray* expireDateArray;
@end

@implementation PTQuoteTableViewController

extern const double CTP_DBL_MAX;
extern NSString *orderFrontIp;
extern NSString *quoteFrontIp;
extern NSString *BrokerId;
extern NSString *UserId ;
extern NSString *Password ;
extern NSString *InvestorId ;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    itemTableCellIdentifier = @"QuoteTableCell";
    tableViewCellArray = [NSMutableDictionary dictionary];
    [self loadData:@"HO"];
    
    NSString* appPath = [self dataFilePath];
    _driver = [[PTCtpQuoteDriver alloc] initWithData:appPath brokerId:BrokerId handler:self];
}

-(void)loadData:(NSString*)varieties{
    PTOptionTPrice* tPrice = [[PTOptionTPrice alloc] initWithData:varieties];
    
    _expireDateArray = [tPrice getExpireDates];
    _selectDate = (NSDate*)_expireDateArray[0];
    for (NSDate* date in _expireDateArray) {
        NSLog(@"date = %@", date);
    }
    quoteArray = [tPrice getItems:[_expireDateArray objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*) dataFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *docDirectory = path[0];
    
    return docDirectory;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return quoteArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PTQuoteTableViewCell *cell = (PTQuoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier forIndexPath:indexPath];
    
    if(!cell){
        cell = [[PTQuoteTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemTableCellIdentifier];
    }
    
    if(quoteArray.count==0)return cell;
    PTOptionTPriceItemViewModel *model = (PTOptionTPriceItemViewModel *)quoteArray[indexPath.row];
    cell.lblCallBuyOne.text = [NSString stringWithFormat:@"%f",model.cBidPrice1];
    cell.lblCallSaleOne.text = [NSString stringWithFormat:@"%f",model.cAskPrice1];
    cell.lblCallVolatility.text = [NSString stringWithFormat:@"%f",model.cVolatility];
    cell.lblStrikePrice.text = [NSString stringWithFormat:@"%d",model.strikePrice];
    
    cell.lblPutBuyOne.text = [NSString stringWithFormat:@"%f",model.bBidPrice1];
    cell.lblPutSaleOne.text = [NSString stringWithFormat:@"%f",model.bAskPrice1];
    cell.lblPutVolatility.text = [NSString stringWithFormat:@"%f",model.bVolatility];

    
    int row = indexPath.row;
    NSString *key = [NSString stringWithFormat:@"%d",row];

    cell.btCallBackGroud.tag = row;
    cell.btPutBackGroud.tag = row;
    if(row%2==1){
        cell.btCallBackGroud.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
        cell.btPutBackGroud.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
    }
    
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"QuetoHeaderView" owner:self options:nil];
    
    PTQuetoHeaderView *headView = (PTQuetoHeaderView *)[nib objectAtIndex:0];
    NSString* str = [Converter asDateStringWithFormat:_selectDate format:@"yyyy/MM/dd"];
    [headView.btSelectDate setTitle:str forState:UIControlStateNormal];
    
    headView.headerDelegate = self;
    return headView;
}

-(void)selectVariety{
    NSLog(@"点击导航");
}

-(void)selectExpiredTime{

}

- (void)showMenu:(UIButton *)sender
{
//    NSArray *menuItems =
//    @[
//      
//      [KxMenuItem menuItem:@"ACTION MENU"
//                     image:nil
//                    target:nil
//                    action:NULL],
//      
//      [KxMenuItem menuItem:@"Share this"
//                     image:[UIImage imageNamed:@"action_icon"]
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"Check menu"
//                     image:[UIImage imageNamed:@"check_icon"]
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"Reload page"
//                     image:[UIImage imageNamed:@"reload"]
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"Search"
//                     image:[UIImage imageNamed:@"search_icon"]
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      
//      [KxMenuItem menuItem:@"Go home"
//                     image:[UIImage imageNamed:@"home_icon"]
//                    target:self
//                    action:@selector(pushMenuItem:)],
//      ];
//    
//    KxMenuItem *first = menuItems[0];
//    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
//    first.alignment = NSTextAlignmentCenter;
//    
//    [KxMenu showMenuInView:self.view
//                  fromRect:sender.frame
//                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     PTQuoteTableViewCell *cell = (PTQuoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemTableCellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint piont = [touch locationInView:self.view];
//    NSLog(@"%d",piont);
//}

//点击按钮，设置其他按钮背景颜色
-(void)setLeftButtonBackGround:(UIButton *)button
{
//    for(NSString *key in tableViewCellArray)
//    {
//        PTQuoteTableViewCell *ptCell = (PTQuoteTableViewCell *)[tableViewCellArray objectForKey:key];
//        UIButton *b = ptCell.btCallBackGroud;
//        b.backgroundColor = [UIColor whiteColor];
////        int tag = b.tag;
////        NSLog(@"%d,%@",tag,key);
////        if(tag%2==1){
////            b.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
////        }else{
////            b.backgroundColor = [UIColor whiteColor];
////        }
//    }
//
//    button.backgroundColor = [UIColor yellowColor];
}

//点击按钮，设置其他按钮背景颜色
-(void)setRightButtonBackGround:(UIButton *)button
{
//    for(NSString *key in tableViewCellArray)
//    {
//        PTQuoteTableViewCell *ptCell = (PTQuoteTableViewCell *)[tableViewCellArray objectForKey:key];
//        UIButton *b = ptCell.btPutBackGroud;
//        int tag = b.tag;
//        b.backgroundColor = [UIColor whiteColor];
////        if(tag%2==1){
////            b.backgroundColor = [UIColor fromRGB:255 green:254 blue:233 alpha:1];
////        }else{
////            b.backgroundColor = [UIColor whiteColor];
////        }
//    }
//    
//    button.backgroundColor = [UIColor yellowColor];
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

-(void) appendText:(NSString*) text {
    //NSString* string = [NSString stringWithFormat:@"%@%@", self.outputText.text, text];
    //self.outputText.text = string;
    NSLog(@"%@", text);
}

// handle message
-(void)handleOrderMessage:(PTMessage *)msg {
    
}

-(void)handleQuoteMessage:(PTMessage *)msg {
    NSString* text = nil;
    int what = msg.what;
    int result = 0;
    
    switch (what) {
        case MSG_FRONT_SUCCESS:
        {
            text = [NSString stringWithFormat:@"%@", @"前置已经连接，发送登录\n"];
            [self appendText:text];
            
            result = [self.driver Login:@"9093920" password:@"11111"];
            if(result != 0) {
                text = [NSString stringWithFormat:@"%@%i", @"登录失败, result = " , result];
                [self appendText:text];
            }
        }
            break;
        case MSG_LOGIN_SUCCESS:
        {
            text = [NSString stringWithFormat:@"%@", @"登入成功，订阅深度行情"];
            [self appendText:text];
            result = [self.driver SubscribeMarketData:_codeArray];
            if(result != 0) {
                text = [NSString stringWithFormat:@"%@%i", @"订阅深度行情失败, result = " , result];
                [self appendText:text];
            }
        }
            break;
        case MSG_QUOTE_OnRtnDepthMarketData:
        {
            text = [NSString stringWithFormat:@"%@", @"订阅深度行情，数据返回！"];
            [self appendText:text];
            
            [NSThread sleepForTimeInterval:1];
            PTFcpMarketData* data = msg.data;
            
            [self.tableView reloadData];
            double askPrice1 = (data.AskPrice1 > CTP_DBL_MAX)? 0.0:data.AskPrice1;      // deal max value
            text = [NSString stringWithFormat:@"code = %@ name = %@ askPrice = %0.2f\n", data.InstrumentID, data.Instrument.instrumentName, askPrice1];
            [self appendText:text];
        }
            break;
        case MSG_ONRSPERR:
        {
            text = [NSString stringWithFormat:@"ONRSPERR: errorId = %i errorMsg = %@", msg.errorId, msg.message ];
            [self appendText:text];
        }
            break;
        case MSG_ERROR:
        {
            text = [NSString stringWithFormat:@"ERROR: errorId = %i errorMsg = %@", msg.errorId, msg.message ];
            [self appendText:text];
        }
            break;
        default:
            break;
    }
}

@end
