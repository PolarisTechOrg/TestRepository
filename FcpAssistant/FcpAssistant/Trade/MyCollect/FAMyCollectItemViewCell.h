//
//  FAMyCollectItemViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-19.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAStrategyProfitView.h"

@interface FAMyCollectItemViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgProfitBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfitLine;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyProfitRate;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPurchaseFlag;
@property (weak, nonatomic) IBOutlet UIImageView *imgStragetyGrade;
@property (weak, nonatomic) IBOutlet UILabel *lblFollowNum;

@property (weak, nonatomic) IBOutlet UILabel *lblStrategyProvider;
@property (weak, nonatomic) IBOutlet FAStrategyProfitView *imgStrategyProfit;

@end
