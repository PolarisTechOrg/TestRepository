//
//  FAMyPurchaseDetailTopViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-9.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMyPurchaseDetailTopViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profitImage;
@property (weak, nonatomic) IBOutlet UILabel *strategyName;
@property (weak, nonatomic) IBOutlet UILabel *purchaseDate;
@property (weak, nonatomic) IBOutlet UILabel *strategyProfit;
@property (weak, nonatomic) IBOutlet UILabel *orderMultiple;
@property (weak, nonatomic) IBOutlet UILabel *yestordayProfit;
@property (weak, nonatomic) IBOutlet UILabel *varieties;

@end
