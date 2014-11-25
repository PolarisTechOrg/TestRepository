//
//  PTVarietyTableViewCell.h
//  OptionStrategy
//
//  Created by user01 on 11/25/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTVarietyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *varietyMainView;
@property (weak, nonatomic) IBOutlet UILabel *exchangeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *varietyCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *varietyNameLabel;

@end
