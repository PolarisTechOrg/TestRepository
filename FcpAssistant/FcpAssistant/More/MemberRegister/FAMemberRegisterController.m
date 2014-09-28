//
//  FAMemberRegisterController.m
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import "FAMemberRegisterController.h"

@interface FAMemberRegisterController ()

@end

@implementation FAMemberRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title = @"加入会员";
    UIBarButtonItem* registerBtn = [[UIBarButtonItem alloc] init];
    registerBtn.title = @"注册";
    self.navigationItem.rightBarButtonItem = registerBtn;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//NSString * requestUrlStr =[[NSString alloc] initWithFormat:@"%@api/member",WEB_URL];
//NSURL * requestUrl =[NSURL URLWithString: requestUrlStr];

//FAStationLoginModelDto *loginDto = [[FAStationLoginModelDto alloc] init];
//loginDto.Account = account;
//loginDto.Password = encryptPwd;
//loginDto.RememberMe = YES;
//loginDto.Auto = NO;
//loginDto.Sign = saltDto.Sign;
//loginDto.MobileClientId = clientId;
//loginDto.DeviceType = 2;
//
//FAHttpHead *httpHeader = [FAHttpHead defaultInstance];
//httpHeader.Method = @"POST";
//
//NSError *error;
//NSData *replyData = [FAHttpUtility sendRequest:requestUrl withHead:httpHeader httpBody:loginDto error:error];
//
//NSString *replyMessage = [[NSString alloc] initWithData:replyData encoding:NSUTF8StringEncoding];
//NSLog(@"Login reply: %@",replyMessage);


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
