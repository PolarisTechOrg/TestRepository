//
//  FAStrategyViewCell.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategyDetailTopViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblStrategyName;

@property (weak, nonatomic) IBOutlet UIImageView *imgStrategyStar;

@property (weak, nonatomic) IBOutlet UILabel *lblStrategyOnlineDate;

@property (weak, nonatomic) IBOutlet UILabel *lblRealPerformance;

@property (weak, nonatomic) IBOutlet UILabel *lblWinRatioTwoWeeks;

@property (weak, nonatomic) IBOutlet UILabel *lblOrderPeropleNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblTradeVariety;

@property (weak, nonatomic) IBOutlet UILabel *lblProfitOneWeek;

@property (weak, nonatomic) IBOutlet UILabel *lblSuggestRightMoney;

@property (weak, nonatomic) IBOutlet UILabel *lblCollectionPeopleNumber;

@property (weak, nonatomic) IBOutlet UILabel *lblStrategyProvider;

@end
