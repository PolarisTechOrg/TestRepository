//
//  FALargeProfitController.m
//  FcpAssistant
//
//  Created by admin on 10/16/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FALargeProfitController.h"
#import "FAStrategyDetailProfitViewCell.h"
#import "FAStrategyDetailController.h"

@interface FALargeProfitController ()

@end

@implementation FALargeProfitController

@synthesize strategyId;
@synthesize profitChartDto;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wantsFullScreenLayout = YES;
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    FAStrategyDetailProfitView *profitView = [[FAStrategyDetailProfitView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.view addSubview:profitView];
    self.imgLargeProfitView = profitView;
    
    self.imgLargeProfitView.dataSource = profitChartDto.Items;
    [self.imgLargeProfitView setNeedsDisplay];
    
    // double click
    doubleClickExitGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleClickExit:)];
    doubleClickExitGR.numberOfTouchesRequired = 1;
    doubleClickExitGR.numberOfTapsRequired = 2;
    
    self.imgLargeProfitView.userInteractionEnabled = YES;
    [self.imgLargeProfitView addGestureRecognizer:doubleClickExitGR];
}

- (void)doDoubleClickExit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return ((toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft));
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
