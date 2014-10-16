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
#import "FAUtility.h"

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
    [self.btnRealFundAccount setTitle:@"" forState:UIControlStateNormal];
    [self.btnSimulateFundAccount setTitle:@"" forState:UIControlStateNormal];
    self.imgRealFundAccountCheck.image = nil;
    self.imgSimulateFundAccountCheck.image = nil;
    
    if(fcpAccount != nil)
    {
        self.lblFcpAccount.text = fcpAccount.FcpAccount;
        if(fcpAccount.RealFundAccount !=nil)
        {
            [self.btnRealFundAccount setTitle:fcpAccount.RealFundAccount.FundAccount forState:UIControlStateNormal];
            self.btnRealFundAccount.tag = fcpAccount.RealFundAccount.FundAccountType;
            
            if(selectFundAccount != nil && selectFundAccount.FundAccount == fcpAccount.RealFundAccount.FundAccount && selectFundAccount.FundAccountType == fcpAccount.RealFundAccount.FundAccountType)
            {
                self.imgRealFundAccountCheck.image = [UIImage imageNamed:@"check_yes.png"];
            }
        }
        if(fcpAccount.SimulateFundAccount != nil)
        {
            [self.btnSimulateFundAccount setTitle:fcpAccount.SimulateFundAccount.FundAccount forState:UIControlStateNormal];
            self.btnSimulateFundAccount.tag = fcpAccount.SimulateFundAccount.FundAccountType;
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
        [FAUtility showAlterViewWithException:exception];
    }
    @finally
    {
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRealFundAccountTouchDown:(id)sender
{
    if (self.btnRealFundAccount.currentTitle.length >0)
    {
        NSString *fundAccount = self.btnRealFundAccount.currentTitle;
        NSInteger fundAccountType = self.btnRealFundAccount.tag;
        [[FAAccountManager shareInstance] changeFundAccount:fundAccount fundAccountType:(int)fundAccountType];
        self.imgRealFundAccountCheck.image = [UIImage imageNamed:@"check_yes.png"];
        self.imgSimulateFundAccountCheck.image = nil;
    }
}

- (IBAction)btnSimulateFundAccountTouchDown:(id)sender
{
    if (self.btnSimulateFundAccount.currentTitle.length >0)
    {
        NSString *fundAccount = self.btnSimulateFundAccount.currentTitle;
        NSInteger fundAccountType = self.btnSimulateFundAccount.tag;
        [[FAAccountManager shareInstance] changeFundAccount:fundAccount fundAccountType:(int)fundAccountType];
        self.imgSimulateFundAccountCheck.image = [UIImage imageNamed:@"check_yes.png"];
        self.imgRealFundAccountCheck.image = nil;
    }
}

@end
