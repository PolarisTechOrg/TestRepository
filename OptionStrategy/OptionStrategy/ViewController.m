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

@interface ViewController ()

@end

@implementation ViewController

const double CTP_DBL_MAX = 0.1 * DBL_MAX;  //

NSString *orderFrontIp = @"tcp://124.160.109.58:51205";
NSString *quoteFrontIp = @"tcp://115.238.53.139:51213";
NSString *BrokerId  = @"1032";
NSString *UserId = @"101301004";
NSString *Password = @"115046";
NSString *InvestorId = @"101301004";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (IBAction)onTPriceButtonClick:(id)sender {
    PTOptionTPrice* tPrice = [[PTOptionTPrice alloc] initWithData:@"HO"];

    NSArray* expireDateArray = [tPrice getExpireDates];
            for (NSDate* date in expireDateArray) {
                NSLog(@"date = %@", date);
            }
    NSArray* items = [tPrice getItems:[expireDateArray objectAtIndex:0]];
            for (PTOptionTPriceItemViewModel* model in items) {
                NSString* c = model.cInstrumentCode;
                NSString* p = model.pInstrumentCode;
                if(!c) c = @"";
                if(!p)p = @"";
    
                NSLog(@"strikePrice = %i c = %@ p = %@ expire = %@", model.strikePrice, c, p, model.expireDate);
            }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
