//
//  FAMyFcpController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyFcpController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblFcpAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblRealFundAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblSimulateFundAccount;
@property (weak, nonatomic) IBOutlet UIImageView *imgRealFundAccountCheck;
@property (weak, nonatomic) IBOutlet UIImageView *imgSimulateFundAccountCheck;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end
