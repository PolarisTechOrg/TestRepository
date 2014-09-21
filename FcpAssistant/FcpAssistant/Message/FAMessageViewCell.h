//
//  FAMessageViewCell.h
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMessageViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconMessageReadFlag;
@property (weak, nonatomic) IBOutlet UIImageView *imgMessageProvider;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageProvider;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblMessageArriveTime;


@end
