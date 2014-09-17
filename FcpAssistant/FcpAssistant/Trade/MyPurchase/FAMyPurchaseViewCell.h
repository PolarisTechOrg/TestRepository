//
//  FAMyPurchaseViewCellTableViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyPurchaseViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *strategyName;
@property (weak, nonatomic) IBOutlet UILabel *purchaseDate;
@property (weak, nonatomic) IBOutlet UILabel *orderMultiple;
@property (weak, nonatomic) IBOutlet UILabel *todaySignalCount;

@end
