//
//  ViewController.m
//  OptionStrategy
//
//  Created by admin on 11/18/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "ViewController.h"
#import "PTOptionTPrice.h"
#import "PTOptionTPriceItemViewModel.h"
#import "PTCtpQuoteDriver.h"
#import "PTCtpOrderDriver.h"

@interface ViewController ()

@property PTOptionTPrice* tPrice;
@property NSArray* expireDateArray;

@end

@implementation ViewController

const double CTP_DBL_MAX = 0.1 * DBL_MAX;  //

NSString *orderFrontIp = @"tcp://124.160.109.58:51205";
NSString *quoteFrontIp = @"tcp://115.238.53.139:51213";
NSString *BrokerId  = @"1032";
NSString *UserId = @"101301004";
NSString *Password = @"115046";
NSString *InvestorId = @"101301004";
PTCtpQuoteDriver* quoteDriver;
PTCtpOrderDriver* orderDriver;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString* appPath = [self dataFilePath];
    quoteDriver = [[PTCtpQuoteDriver alloc] initWithData:appPath brokerId:BrokerId handler:self];
    [quoteDriver Connect:quoteFrontIp];
}

-(NSString*) dataFilePath {
    // NSDocumentationDirectory => NSDocumentDirectory
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *docDirectory = path[0];
    
    //return [docDirectory stringByAppendingPathComponent:@"OptionLottoProperties.plist"];
    return docDirectory;
}
- (IBAction)onConnectButtonClick:(id)sender {
    NSString* text = nil;
    int result = [quoteDriver Login:@"9093920" password:@"11111"];
    if(result != 0) {
        text = [NSString stringWithFormat:@"%@%i", @"登录失败, result = " , result];
        [self appendText:text];
    }
    
}

- (IBAction)onTPriceButtonClick:(id)sender {
     _tPrice = [[PTOptionTPrice alloc] initWithData:@"HO"];

     _expireDateArray = [_tPrice getExpireDates];
            for (NSDate* date in _expireDateArray) {
                NSLog(@"date = %@", date);
            }
    NSDate* date = [_expireDateArray objectAtIndex:0];
    NSArray* items = [_tPrice getItems:date];
            for (PTOptionTPriceItemViewModel* model in items) {
                NSString* c = model.cInstrumentCode;
                NSString* p = model.pInstrumentCode;
                if(!c) c = @"";
                if(!p)p = @"";
    
                NSLog(@"strikePrice = %i c = %@ p = %@ expire = %@", model.strikePrice, c, p, model.expireDate);
            }
    [_tPrice Subscribe:date];
}

-(void) handleQuoteMessage:(PTMessage*) msg{
    NSString* text = @"";
    int result = -1;
    
    int what = msg.what;
    if(what == MSG_LOGIN_SUCCESS)
       {
           text = [NSString stringWithFormat:@"%@", @"登入成功，订阅深度行情"];
           [self appendText:text];
       }
    else if(what == MSG_QUOTE_OnRtnDepthMarketData) {
        NSDate* date = [_expireDateArray objectAtIndex:0];
        int index = [_tPrice updateMarketData:date data:msg.data];
        NSLog(@"updated price index = %i", index);  // 每一行会跟新两次，call, put
    }
}

-(void) appendText:(NSString*) text {
    //NSString* string = [NSString stringWithFormat:@"%@%@", self.outputText.text, text];
    //self.outputText.text = string;
    NSLog(@"%@", text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
