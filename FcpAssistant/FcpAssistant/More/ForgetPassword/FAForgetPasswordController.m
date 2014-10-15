//
//  FAForgetPasswordController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAForgetPasswordController.h"
#import "FAUtility.h"
#import "FAHttpHead.h"
#import "FAHttpUtility.h"
#import "FAForgotPasswordModel.h"
#import "FAFoundation.h"

@interface FAForgetPasswordController ()

@end

@implementation FAForgetPasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
    
    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelView:)];
    self.navItem.leftBarButtonItem = cancelBtn;
    
    UIBarButtonItem* finishBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishForgetPaswor:)];
    self.navItem.rightBarButtonItem = finishBtn;
    
    self.navItem.title = @"忘记密码";
    
    [self changCheckCode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)txtFieldDidEndOnExit:(id)sender
{
    [sender resignFirstResponder];
}

-(void)cancelView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnChangeCodeTouchDown:(id)sender
{
    [self changCheckCode];
}

-(BOOL) forgetPasswordValidate
{
    if(self.txtUserName.text.length <=0)
    {
        [FAUtility showAlterView:@"账号不能为空"];
        return NO;
    }
    
    if(self.txtCheckCode.text.length <=0)
    {
        [FAUtility showAlterView:@"验证码不能为空"];
        return NO;
    }
    
    return YES;
}

- (void)changCheckCode
{
    @try
    {
        NSString *requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/checkcode?temp=12343&newcode=der4&checknumber=abcd",WEB_URL];
        NSURL *requestUrl =[NSURL URLWithString: requestUrlStr];
        
        NSError *error;
        
        NSData *replyData = [FAHttpUtility sendRequest:requestUrl error:&error];
        
        if(error == nil)
        {
            self.imgCheckCode.image = [UIImage imageWithData:replyData];
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"ForgetPasswordException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
            @throw ex;
        }
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
    }
    @finally
    {
        
    }
}

-(void)finishForgetPaswor:(id)sender
{
    if([self forgetPasswordValidate] == NO)
    {
        return;
    }
    
    @try
    {
        NSString *requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/password",WEB_URL];
        NSURL *requestUrl =[NSURL URLWithString: requestUrlStr];
        
        NSError *error;
        FAHttpHead *header = [FAHttpHead defaultInstance];
        header.Method = @"POST";
        
        FAForgotPasswordModel *parameter = [[FAForgotPasswordModel alloc]init];
        parameter.UserName = self.txtUserName.text;
        parameter.CheckCode = self.txtCheckCode.text;
        
        [FAHttpUtility sendRequest:requestUrl withHead:header httpBody:parameter error:&error];
        
        if(error == nil)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        else
        {
            NSException *ex = [[NSException alloc] initWithName:@"ForgetPasswordException" reason: [NSString stringWithFormat:@"%ld",error.code] userInfo:error.userInfo];
            @throw ex;
        }
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
    }
    @finally
    {
        
    }
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
