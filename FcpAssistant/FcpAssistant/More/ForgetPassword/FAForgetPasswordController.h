//
//  FAForgetPasswordController.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CHECK_CODE_TAG  @"CheckCode.Code"
#define CHECK_CODE_SIGN  @"CheckCode.Sign"
#define CHECK_CODE_STAMP  @"CheckCode.Stamp"

@interface FAForgetPasswordController : UIViewController
{
@private NSString * headerCode;
@private NSString *headerSign;
@private NSString *headerStamp;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckCode;

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtCheckCode;
@end
