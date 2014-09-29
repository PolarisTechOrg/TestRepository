//
//  FAMemberRegisterController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMemberRegisterController.h"
#import "FAMemberRegistrationModel.h"
#import "FAFoundation.h"
#import "FAHttpHead.h"
#import "FAHttpUtility.h"

@interface FAMemberRegisterController ()

@end

@implementation FAMemberRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelRegister:)];
    self.navItem.leftBarButtonItem = cancleBtn;
    

    UIBarButtonItem* registerBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerMember:)];
    self.navItem.rightBarButtonItem = registerBtn;
    // Do any additional setup after loading the view from its nib.
}

-(void)cancelRegister:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) validateEmail
{
    if(self.txtAccount.text.length <=0)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"擎天期顾助手" message:@"邮件地址不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        return NO;
    }
    
    return YES;
}

-(void)registerMember:(id)sender
{
    if([self validateEmail] == NO)
    {
        return;
    }
    
    @try
    {
        NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/member",WEB_URL];
        NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];
        
        FAMemberRegistrationModel *registerDto = [[FAMemberRegistrationModel alloc] init];
        registerDto.Email = self.txtAccount.text;
        registerDto.MobilePhone = @"12312341234";
        registerDto.Source = 4;
        
        FAHttpHead *httpHeader = [FAHttpHead defaultInstance];
        httpHeader.Method = @"POST";
        
        NSError *error;
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHeader httpBody:registerDto error:error];
        
        NSString *replyMessage = [[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding];
        NSLog(@"Login reply: %@",replyMessage);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    @catch (NSException *exception)
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"擎天期顾助手" message:exception.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }
    @finally
    {
        
    }
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
