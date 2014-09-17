//
//  FAMyPurchaseDetailSignalViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyPurchaseDetailSignalViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *signalTime;
@property (weak, nonatomic) IBOutlet UILabel *signalSeq;
@property (weak, nonatomic) IBOutlet UILabel *instrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *strategyPositon;

@end
