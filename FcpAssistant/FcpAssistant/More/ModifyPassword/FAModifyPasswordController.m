//
//  FAModifyPasswordController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAModifyPasswordController.h"
#import "FAUtility.h"
#import "FAAccountManager.h"

@interface FAModifyPasswordController ()

@end

@implementation FAModifyPasswordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    
    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelView:)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    UIBarButtonItem* finishBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishModifyPassword:)];
    self.navigationItem.rightBarButtonItem = finishBtn;
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

-(BOOL)modifyPasswordValidate
{
    if(self.txtOldPassword.text.length <=0)
    {
        [FAUtility showAlterView:@"密码不能为空"];
        return NO;
    }
    
    if(self.txtNewPassword.text.length <=0)
    {
        [FAUtility showAlterView:@"新密码不能为空"];
        return NO;
    }
    if(self.txtConfirmPassword.text.length <=0)
    {
        [FAUtility showAlterView:@"确认密码不能为空"];
        return NO;
    }
    if([self.txtConfirmPassword.text compare:self.txtNewPassword.text] != NSOrderedSame)
    {
        [FAUtility showAlterView:@"确认密码不一致"];
        return NO;
    }
    
    return YES;
}

-(void)finishModifyPassword:(id)sender
{
    if([self modifyPasswordValidate] == NO)
    {
        return;
    }
    
    @try
    {
        [[FAAccountManager shareInstance] modifyPasswor:self.txtOldPassword.text newPassword:self.txtNewPassword.text confirmPassword:self.txtConfirmPassword.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch (NSException *exception)
    {
        [FAUtility showAlterViewWithException:exception];
    }
    @finally
    {
        
    }
}
- (IBAction)backgroundTouchDown:(id)sender
{
    [self.view endEditing:YES];
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
