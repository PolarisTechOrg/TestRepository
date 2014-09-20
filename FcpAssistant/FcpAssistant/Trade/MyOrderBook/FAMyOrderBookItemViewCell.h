//
//  FAMyOrderBookItemViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyOrderBookItemViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblInstrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderQtyAndTradeQty;
@property (weak, nonatomic) IBOutlet UILabel *lblTradePrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderTime;
@end
