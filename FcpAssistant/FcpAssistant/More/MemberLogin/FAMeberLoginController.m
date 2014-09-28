//
//  FAMeberLoginController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMeberLoginController.h"
#import "FAAccountManager.h"

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
    self.txtAccount.text = @"100411";
    self.txtPassword.text = @"100411";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnRegister_Click:(id)sender
{
    NSLog(@"Register click");
}

- (IBAction)btnLogin_Click:(id)sender
{
    NSLog(@"Login click");
    NSString *account = self.txtAccount.text;
    NSString *password = self.txtPassword.text;
    NSString *clientId = @"ios1234455";
    //账户密码校验
    [[FAAccountManager shareInstance] Login:account withPassword:password clientId:clientId];
    
   
    
}

@end
