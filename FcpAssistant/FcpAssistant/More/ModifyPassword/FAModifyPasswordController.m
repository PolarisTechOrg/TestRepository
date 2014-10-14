//
//  FAModifyPasswordController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAModifyPasswordController.h"
#import "FAUtility.h"

@interface FAModifyPasswordController ()

@end

@implementation FAModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    
    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelView:)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    UIBarButtonItem* finishBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishForgetPaswor:)];
    self.navigationItem.rightBarButtonItem = finishBtn;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
