//
//  FAMyFcpController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMyFcpController.h"
#import "FAStationAccount.h"
#import "FAAccountManager.h"
#import "FAModifyPasswordController.h"

@interface FAMyFcpController ()

@end

@implementation FAMyFcpController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的期顾";
    self.myScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,800);
    [self showAccount];
}

//展示账户信息
-(void) showAccount
{
    FAStationAccount *fcpAccount = [FAAccountManager shareInstance].currentMember;
    FAStationFundAccount *selectFundAccount = [FAAccountManager shareInstance].selectFundAccount;
    
    self.lblFcpAccount.text = @"";
    self.lblRealFundAccount.text = @"";
    self.lblSimulateFundAccount.text = @"";
    self.imgRealFundAccountCheck.image = nil;
    self.imgSimulateFundAccountCheck.image = nil;
    
    if(fcpAccount != nil)
    {
        self.lblFcpAccount.text = fcpAccount.FcpAccount;
        if(fcpAccount.RealFundAccount !=nil)
        {
            self.lblRealFundAccount.text = fcpAccount.RealFundAccount.FundAccount;
            self.lblRealFundAccount.tag = fcpAccount.RealFundAccount.FundAccountType;
            if(selectFundAccount != nil && selectFundAccount.FundAccount == fcpAccount.RealFundAccount.FundAccount && selectFundAccount.FundAccountType == fcpAccount.RealFundAccount.FundAccountType)
            {
                self.imgRealFundAccountCheck.image = [UIImage imageNamed:@"check_yes.png"];
            }
        }
        if(fcpAccount.SimulateFundAccount != nil)
        {
            self.lblSimulateFundAccount.text = fcpAccount.SimulateFundAccount.FundAccount;
            self.lblSimulateFundAccount.tag = fcpAccount.SimulateFundAccount.FundAccountType;
            if(selectFundAccount != nil && selectFundAccount.FundAccount == fcpAccount.SimulateFundAccount.FundAccount && selectFundAccount.FundAccountType == fcpAccount.SimulateFundAccount.FundAccountType)
            {
                self.imgSimulateFundAccountCheck.image = [UIImage imageNamed:@"check_yes.png"];
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnModifyPassword_Click:(id)sender
{
    FAModifyPasswordController *newViewController =[[FAModifyPasswordController alloc] init];
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (IBAction)btnLogout_Click:(id)sender
{
    @try
    {
        [[FAAccountManager shareInstance] logout];
    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
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
