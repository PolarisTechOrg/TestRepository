//
//  PTFcpOrderTesterViewController.m
//  OptionStrategy
//
//  Created by admin on 11/20/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "PTFcpOrderTesterViewController.h"
#import "PTCtpOrderDriver.h"
#import "PTCtpOrderDriver.h"
#import "PTCtpDataBuffer.h"
#import "PTFcpInvestorBaseInfo.h"

@interface PTFcpOrderTesterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property PTCtpOrderDriver *driver;
@property PTCtpDataBuffer* dataBuffer;
@property NSMutableArray* codeArray;

@end

@implementation PTFcpOrderTesterViewController

extern const double CTP_DBL_MAX;
extern NSString *orderFrontIp;
extern NSString *quoteFrontIp;
extern NSString *BrokerId;
extern NSString *UserId ;
extern NSString *Password ;
extern NSString *InvestorId ;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        NSString* appPath = [self dataFilePath];
        _driver = [[PTCtpOrderDriver alloc] initWithData:appPath brokerId:BrokerId handler:self];
    _dataBuffer = [PTCtpDataBuffer shared];
    
    _codeArray = [NSMutableArray arrayWithObjects:@"IO1412-C-2100", @"IO1412-C-2250", @"IO1412-P-2100", @"IO1412-P-2250", nil];
}

-(int)getRandomNumberBetween:(int)from to:(int)to {

    int rnd = (int)from + arc4random() % (to-from+1);
    NSLog(@"random = %i", rnd);
    
    return rnd;
}

-(NSString*) getCode {
    int count = [_codeArray count];
    int index = [self getRandomNumberBetween:0 to:count - 1];
    NSString* code = [_codeArray objectAtIndex:index];
    return code;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(NSString*) dataFilePath {
    // NSDocumentationDirectory => NSDocumentDirectory
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *docDirectory = path[0];
    
    //return [docDirectory stringByAppendingPathComponent:@"OptionLottoProperties.plist"];
    return docDirectory;
}

- (IBAction)onConnectClick:(UIButton *)sender {
    [sender setEnabled:false];


    [_driver Connect:orderFrontIp];
}

- (IBAction)onPlaceOrderButtonClick:(id)sender {
    NSString* instrumentId = [self getCode];
    NSLog(@"instrumentCode = %@", instrumentId);
    PTFcpInstrument* instrument = [[PTFcpInstrument alloc] initWithData:instrumentId instrumentName:instrumentId market:PTFcpMarketCFFE];
    int qty = 2;
    double price = 300;
    PTFcpOffsetType offsetType = PTFcpOffsetTypeOpen;
    PTFcpOrderSide orderSide = PTFcpOrderSideBuy;
    NSError* error = nil;
    PTFcpOrderNum *orderNum =[_driver PlaceOrder:instrument qty:qty price:price offsetType:offsetType orderSide:orderSide error:&error];
    if(error == nil) {
    NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryAccountButtonClick:(id)sender {
    NSError* error = nil;
    [_driver QryTradingAccount:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onConfirmButtonClick:(id)sender {
    NSError* error = nil;
    [_driver SettlementInfoConfirm:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryMarketData:(UIButton *)sender {
    NSError* error = nil;
    
    NSString* instrumentCode = [self getCode];
    NSLog(@"instrumentCode = %@", instrumentCode);
    
    [_driver QryDepthMarketData:instrumentCode error:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryInstrumentsClick:(id)sender {
    NSError* error = nil;
    
    [_driver QryInstruments:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryInstrumentFeeButtonClick:(id)sender {
    NSError* error = nil;
    NSString* code = [self getCode];
    NSLog(@"instrumentCode = %@", code);
    [_driver QryInstrumentFee:code error:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryInstrumentMarginButtonClick:(id)sender {
    NSError* error = nil;
    NSString* code = [self getCode];
    NSLog(@"instrumentCode = %@", code);
    [_driver QryInstrumentMargin:code error:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryInvestorButtonClick:(id)sender {
    NSError* error = nil;
    NSString* code = [self getCode];
    NSLog(@"instrumentCode = %@", code);
    [_driver QryInvestor:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryInvestorPositionButtonClick:(id)sender {
    NSError* error = nil;
    [_driver QryInvestorPosition:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryInvestorPositionDetailButtonClick:(id)sender {
    
    NSError* error = nil;
    [_driver QryInvestorPositionDetail:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }

}

- (IBAction)onQryOrderBooksButtonClick:(id)sender {
    NSError* error = nil;
    [_driver QryOrderBooks:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}

- (IBAction)onQryTradeBooksButtonClick:(id)sender {
    NSError* error = nil;
    [_driver QryTradeBooks:&error];
    if(error == nil) {
        //NSLog(@"orderNum = %@", [orderNum getOrderString]);
    }
    else {
        NSLog(@"place order: %@", [error localizedDescription]);
    }
}



-(void) appendText:(NSString*) text {
    //NSString* string = [NSString stringWithFormat:@"%@%@", self.outputText.text, text];
    //self.outputText.text = string;
    NSLog(@"%@", text);
}


// handle message
-(void)handleOrderMessage:(PTMessage *)msg {
    NSString* text = nil;
    int what = msg.what;
    int result = 0;
    
    switch (what) {
        case MSG_FRONT_SUCCESS:
        {
            text = [NSString stringWithFormat:@"[Order]%@", @"前置已经连接，发送登录\n"];
            [self appendText:text];
            
            result = [self.driver Login:BrokerId userId:UserId password:Password];
            //result = [self.driver Login:BrokerId userId:UserId password:@"dddd"];
            if(result != 0) {
                text = [NSString stringWithFormat:@"[Order]%@%i", @"登录失败, result = " , result];
                [self appendText:text];
            }
        }
            break;
        case MSG_FRONT_DISCONNECT:
        {
            text = msg.message;
            [self appendText:text];
        }
            break;
        case MSG_LOGIN_SUCCESS:
        {
            text = [NSString stringWithFormat:@"%@", @"[Order]登入成功，查询合约, coding!"];
            [self appendText:text];
            //[NSThread sleepForTimeInterval:1];
        }
            break;
        case MSG_ONRTNORDER:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            NSArray* books = [_dataBuffer GetOrderBooks];
            PTFcpOrderBook* orderBook;
            NSLog(@"new lines: %@", @"PTFcpOrderBook* orderBook");
            for (orderBook in books) {
            NSLog(@"orderBook = %@ qty = %i price = %f status = %i", [orderBook.OrderNum getOrderString], orderBook.OrderQty, orderBook.OrderPrice, orderBook.OrderStatus );
            }
        }
            break;
        case MSG_ONRSPQRYQRDER:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            NSArray* books = [_dataBuffer GetOrderBooks];
            PTFcpOrderBook* orderBook;
            NSLog(@"new lines: %@", @"PTFcpOrderBook* orderBook");
            for (orderBook in books) {
                NSLog(@"MSG_ONRSPQRYQRDER = %@ qty = %i price = %f status = %i", [orderBook.OrderNum getOrderString], orderBook.OrderQty, orderBook.OrderPrice, orderBook.OrderStatus );
            }
        }
            break;
        case MSG_ONRSPQRYTRADE:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            NSArray* books = [_dataBuffer getTradeBooks];
            PTFcpTradeBook* book;
            NSLog(@"new lines: %@", @"PTFcpTradeBook* book");
            for (book in books) {
                NSLog(@"MSG_ONRSPQRYTRADE = %@ qty = %i price = %0.2f Amout = %0.2f", [book.OrderNum getOrderString], book.Qty, book.Price, book.Amount );
            }
        }
            break;
        case MSG_QUOTE_OnRtnDepthMarketData:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            PTFcpMarketData* data = msg.data;
            double askPrice1 = (data.AskPrice1 > CTP_DBL_MAX)? 0.0:data.AskPrice1;      // deal max value
            double bidPrice1 = (data.BidPrice1 > CTP_DBL_MAX)? 0.0:data.BidPrice1;
            
            text = [NSString stringWithFormat:@"code = %@ name = %@ ask = %0.2f bid = %0.2f\n", data.InstrumentID, data.Instrument.instrumentName, askPrice1, bidPrice1];
            [self appendText:text];
        }
            break;
        case MSG_ONRSPQRYDEPTHMARKETDATA:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            PTFcpMarketData* data = msg.data;
            double askPrice1 = (data.AskPrice1 > CTP_DBL_MAX)? 0.0:data.AskPrice1;      // deal max value
            double bidPrice1 = (data.BidPrice1 > CTP_DBL_MAX)? 0.0:data.BidPrice1;
            
            text = [NSString stringWithFormat:@"code = %@ name = %@ ask = %0.2f bid = %0.2f\n", data.InstrumentID, data.Instrument.instrumentName, askPrice1, bidPrice1];
            [self appendText:text];
        }
            break;
        case MSG_REQ_INSTRUMENT_FINSH:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            PTFcpInstrumentDetail* data;
            NSArray* instruments = [_dataBuffer getInstrumentDetails];
            for (data in instruments) {
                text = [NSString stringWithFormat:@"code = %@ name = %@ Varieties = %@ Multiple = %i trading = %i\n", data.Instrument.instrumentCode, data.Instrument.instrumentName, data.Varieties, data.VolumeMultiple, data.IsTrading];
                [self appendText:text];
            }
        }
            break;
        case MSG_FEERATE:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            PTFcpFee* data = [_dataBuffer getInstrumentFee:((PTFcpFee*)msg.data).Instrument];

                text = [NSString stringWithFormat:@"code = %@ name = %@ ByMoney = %f ByVolume = %f\n", data.Instrument.instrumentCode, data.Instrument.instrumentName, data.OpenRatioByMoney, data.OpenRatioByVolume];
                [self appendText:text];
        }
            break;
        case MSG_MARGINRATE:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            PTFcpMargin*data1 = ((PTFcpMargin*)msg.data);
            PTFcpMargin* data = [_dataBuffer getInstrumentMargin:data1.Instrument];
            
            text = [NSString stringWithFormat:@"MSG_MARGINRATE code = %@ name = %@ LongRatio = %f ShortRatio = %f\n", data.Instrument.instrumentCode, data.Instrument.instrumentName, data.ExchangeLongMarginRatio, data.ExchangeShortMarginRatio];
            [self appendText:text];
        }
            break;
        case MSG_ONRSPQRYINVESTOR:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            PTFcpInvestorBaseInfo* data = [_dataBuffer getInvestorInfo];
            
            text = [NSString stringWithFormat:@"MSG_ONRSPQRYINVESTOR brokerName = %@ realName = %@ mobile = %@ openDate = %@\n", data.BrokerName, data.RealName, data.Mobile, data.OpenDate];
            [self appendText:text];
        
        }
            break;
        case MSG_REQ_POSITION_FINSH:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            NSArray* array = [_dataBuffer getPositions];
            for (PTFcpPosition* data in array) {
                text = [NSString stringWithFormat:@"MSG_REQ_POSITION_FINSH code = %@ direction = %i position = %i profit = %f avgPrice = %f\n", data.Instrument.instrumentCode, data.Direction, data.Position, data.PositionProfit, data.AvgPirce];
                [self appendText:text];
            }
        }
            break;
        case MSG_REQ_POSITIONDETAIL_FINSH:
        {
            if(msg.errorId != 0) {
                NSLog(@"errorId = %i errorMsg = %@", msg.errorId, msg.message);
                return;
            }
            if(!msg.isLast) {
                return;
            }
            
            NSArray* array = [_dataBuffer getPositionDetails];
            for (PTFcpPositionDetail* data in array) {
                text = [NSString stringWithFormat:@"MSG_REQ_POSITIONDETAIL_FINSH tradeId = %@ code = %@ direction = %i Volume = %i CloseAmount = %f CloseQty = %i\n", data.TradeID, data.Instrument.instrumentCode, data.Direction, data.Volume, data.CloseAmount, data.CloseQty];
                [self appendText:text];
            }
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

-(void)handleQuoteMessage:(PTMessage *)msg {
    
}


@end
