//
//  PTFcpQuoteTesterViewController.m
//  OptionStrategy
//
//  Created by admin on 11/18/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "PTFcpQuoteTesterViewController.h"
#import "PTCtpQuoteDriver.h"

extern PTCtpQuoteDriver* quoteDriver;

@interface PTFcpQuoteTesterViewController ()
@property (weak, nonatomic) IBOutlet UITextView *outputText;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property NSMutableArray* codeArray;

@end

@implementation PTFcpQuoteTesterViewController

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
        _codeArray = [NSMutableArray arrayWithObjects:@"IO1412-C-2100", @"IO1412-C-2250", @"IO1412-P-2100", @"IO1412-P-2250", nil];
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

- (IBAction)onConnectClick:(UIButton*)sender {
    [sender setEnabled:false];
//    NSString* appPath = [self dataFilePath];
//    _driver = [[PTCtpQuoteDriver alloc] initWithData:appPath brokerId:BrokerId handler:self];
//    [_driver Connect:quoteFrontIp];
    [quoteDriver RegisterHandler:self];
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
            
            result = [quoteDriver Login:@"9093920" password:@"11111"];
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

            result = [quoteDriver SubscribeMarketData:_codeArray];
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
