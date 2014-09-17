//
//  FAForgetPasswordController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAForgetPasswordController.h"

@interface FAForgetPasswordController ()

@end

@implementation FAForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    
    UIBarButtonItem* finishBtn = [[UIBarButtonItem alloc] init];
    finishBtn.title = @"完成";
    self.navigationItem.rightBarButtonItem = finishBtn;
    
    // Do any additional setup after loading the view from its nib.
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
