//
//  FAMyPurchaseDetailSignalViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyPurchaseDetailSignalViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblSignalTime;
@property (weak, nonatomic) IBOutlet UILabel *lblSignalSeq;
@property (weak, nonatomic) IBOutlet UILabel *lblInstrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyPosition;

@end
