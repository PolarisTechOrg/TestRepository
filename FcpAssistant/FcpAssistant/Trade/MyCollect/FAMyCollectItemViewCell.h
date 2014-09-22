//
//  FAMyCollectItemViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-19.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyCollectItemViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgProfitBackground;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfitLine;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyProfitRate;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName;
@property (weak, nonatomic) IBOutlet UIImageView *imgPurchaseFlag;
@property (weak, nonatomic) IBOutlet UIImageView *imgStragetyGrade;
@property (weak, nonatomic) IBOutlet UILabel *lblCollectCount;
@property (weak, nonatomic) IBOutlet UILabel *lblStrategyProvider;

@end
