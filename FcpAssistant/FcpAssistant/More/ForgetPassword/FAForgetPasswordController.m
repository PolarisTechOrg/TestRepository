//
//  FAForgetPasswordController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAForgetPasswordController.h"
#import "FAUtility.h"

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

-(void)finishForgetPaswor:(id)sender
{
    @try
    {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
