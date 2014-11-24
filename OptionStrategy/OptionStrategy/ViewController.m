//
//  ViewController.m
//  OptionStrategy
//
//  Created by admin on 11/18/14.
//  Copyright (c) 2014 Polaris Technology. All rights reserved.
//

#import "ViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
