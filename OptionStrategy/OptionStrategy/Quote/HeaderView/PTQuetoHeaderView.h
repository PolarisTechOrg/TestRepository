//
//  PTQuetoHeaderView.h
//  OptionStrategy
//
//  Created by user01 on 11/24/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTTableHeaderDelegate.h"

@interface PTQuetoHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btVarities;
@property (weak, nonatomic) IBOutlet UILabel *lblInstrumentCode;
@property (weak, nonatomic) IBOutlet UILabel *lblStrikePrice;
@property (weak, nonatomic) IBOutlet UILabel *lblAdd;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIButton *btSelectDate;
@property (weak, nonatomic) id<PTTableHeaderDelegate> headerDelegate;

@end
