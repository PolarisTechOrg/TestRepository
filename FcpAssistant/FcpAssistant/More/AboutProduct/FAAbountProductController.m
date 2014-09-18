//
//  FAAbountProductController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAAbountProductController.h"

@interface FAAbountProductController ()

@end

@implementation FAAbountProductController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationItem.title = @"关于";
    // Do any additional setup after loading the view from its nib.
    
    NSString* productDesc =@"金银岛期货投资顾问平台，是一个全新的营销模式概念，为期货公司业务推广及顾问事业的发展做了一个很好的整并。\n即由降低期货公司客户进入程序化交易的门坎，可以有效提高客户的交易稳定性，达到期货公司稳定成长的目标。";
    NSMutableAttributedString *attrProductDesc = [[NSMutableAttributedString alloc] initWithString:productDesc];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:4];
   
    [attrProductDesc addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [productDesc length])];
    self.lblProductDescription.attributedText = attrProductDesc;
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

@end
