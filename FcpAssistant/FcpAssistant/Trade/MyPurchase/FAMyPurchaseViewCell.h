//
//  FAMyPurchaseViewCellTableViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyPurchaseViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProfitBackground;
@property (weak, nonatomic) IBOutlet UILabel *lblProfit;
@property (weak, nonatomic) IBOutlet UIImageView *imgSignalOrCombineFlag;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgHoldingFlag;
@property (weak, nonatomic) IBOutlet UIImageView *imgStrategyGrade;
@property (weak, nonatomic) IBOutlet UILabel *lblPurchaseDate;
@property (weak, nonatomic) IBOutlet UILabel *lblMultipleCount;
@property (weak, nonatomic) IBOutlet UILabel *lblTodaySignalCount;

@end
