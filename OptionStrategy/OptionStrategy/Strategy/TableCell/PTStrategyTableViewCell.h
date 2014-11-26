//
//  PTStrategyTableViewCell.h
//  OptionStrategy
//
//  Created by user01 on 11/25/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTStrategyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *btLeftBackGroud;
@property (strong, nonatomic) IBOutlet UIButton *btLeftRadio;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftBuyOne;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftSaleOne;
@property (weak, nonatomic) IBOutlet UILabel *lblLeftVolatility;

@property (weak, nonatomic) IBOutlet UILabel *lblStrikePrice;

@property (strong, nonatomic) IBOutlet UIButton *btRightBackGroud;
@property (strong, nonatomic) IBOutlet UIButton *btRightRadio;
@property (weak, nonatomic) IBOutlet UILabel *lblRightBuyOne;
@property (weak, nonatomic) IBOutlet UILabel *lblRightSaleOne;
@property (weak, nonatomic) IBOutlet UILabel *lblRightVolatility;

@end
