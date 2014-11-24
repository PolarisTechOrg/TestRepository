//
//  PTQuoteTableViewCell.h
//  OptionStrategy
//
//  Created by user01 on 11/24/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTQuoteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btCallBackGroud;
@property (weak, nonatomic) IBOutlet UILabel *lblCallBuyOne;
@property (weak, nonatomic) IBOutlet UILabel *lblCallSaleOne;
@property (weak, nonatomic) IBOutlet UILabel *lblCallVolatility;
@property (weak, nonatomic) IBOutlet UIButton *btPutBackGroud;
@property (weak, nonatomic) IBOutlet UILabel *lblStrikePrice;
@property (weak, nonatomic) IBOutlet UILabel *lblPutBuyOne;
@property (weak, nonatomic) IBOutlet UILabel *lblPutSaleOne;
@property (weak, nonatomic) IBOutlet UILabel *lblPutVolatility;

@end
