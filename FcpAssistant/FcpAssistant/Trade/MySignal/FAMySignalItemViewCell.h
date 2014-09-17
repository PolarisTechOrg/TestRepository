//
//  FAMySignalItemViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMySignalItemViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *signalTime;
@property (weak, nonatomic) IBOutlet UILabel *signalSeqNum;
@property (weak, nonatomic) IBOutlet UILabel *instrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *strategyPosition;

@end
