//
//  FAMeberLoginController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMeberLoginController.h"

@implementation FAMeberLoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"会员登陆";

    UIBarButtonItem* sendBtn = [[UIBarButtonItem alloc] init];
    sendBtn.title = @"发送";
    self.navigationItem.rightBarButtonItem = sendBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
