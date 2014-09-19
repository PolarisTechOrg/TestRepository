//
//  FAMyPurchaseDetailOrderViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyPurchaseDetailOrderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblInstrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderQty;
@property (weak, nonatomic) IBOutlet UILabel *lblTradeQty;
@property (weak, nonatomic) IBOutlet UILabel *lblTradePrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderTime;

@end
