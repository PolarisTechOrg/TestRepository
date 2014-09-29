//
//  FAMeberLoginController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMeberLoginController.h"
#import "FAAccountManager.h"
#import "FAMemberRegisterController.h"

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

    
    UIBarButtonItem* sendBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelLogin:)];
//initWithTitle:@"取消" style:UIBarButtonItemStyle arks target:self action];
    sendBtn.title = @"取消";
    self.navItem.leftBarButtonItem = sendBtn;
    self.navItem.title = @"会员登陆";

    self.txtAccount.text = @"100411";
    self.txtPassword.text = @"100411";
}

-(void)cancelLogin:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnRegister_Click:(id)sender
{
    FAMemberRegisterController *registerController = [[FAMemberRegisterController alloc] init];
    [self presentViewController:registerController animated:YES completion:nil];
    
//[self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)btnLogin_Click:(id)sender
{
    if([self loginValidate] == NO)
    {
        return;
    }
    
    NSString *account = self.txtAccount.text;
    NSString *password = self.txtPassword.text;
    NSString *clientId = @"ios1234455";
    //账户密码校验
    [[FAAccountManager shareInstance] Login:account withPassword:password clientId:clientId];
}
-(BOOL) loginValidate
{
    if(self.txtAccount.text.length <=0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"擎天期顾助手" message:@"账号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        return NO;
    }
    
    if(self.txtPassword.text.length <=0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"擎天期顾助手" message:@"密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        return NO;
    }
    
    return YES;
}

@end
