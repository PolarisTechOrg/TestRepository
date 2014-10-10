//
//  FAMyPurchaseDetailProfitViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-10.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAPurchaseProfitView.h"
@interface FAMyPurchaseDetailProfitViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProfit;
@property (weak, nonatomic) IBOutlet FAPurchaseProfitView *imgPurchaseProfit;

@end
