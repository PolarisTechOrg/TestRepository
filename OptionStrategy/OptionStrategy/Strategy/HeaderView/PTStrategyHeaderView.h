//
//  PTStrategyHeaderView.h
//  OptionStrategy
//
//  Created by user01 on 11/25/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTStrategyHeaderDelegate.h"

@interface PTStrategyHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btVarities;
@property (weak, nonatomic) IBOutlet UIButton *btStrategy;
@property (weak, nonatomic) IBOutlet UILabel *lblInstrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *lblStrikePrice;
@property (weak, nonatomic) IBOutlet UILabel *lblAdd;
@property (weak, nonatomic) IBOutlet UILabel *lblTime1;
@property (weak, nonatomic) IBOutlet UILabel *lblTime2;
@property (weak, nonatomic) IBOutlet UIButton *btSelectDate1;
@property (weak, nonatomic) IBOutlet UIButton *btSelectDate2;
@property (weak, nonatomic) id<PTStrategyHeaderDelegate> headerDelegate;

@end
