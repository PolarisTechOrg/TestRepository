//
//  FAMessageViewCell2.h
//  FcpAssistant
//
//  Created by admin on 9/30/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMessageViewCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconMessageReadFlag;

@property (weak, nonatomic) IBOutlet UIImageView *imgMessageType;

@property (weak, nonatomic) IBOutlet UILabel *lblMessageProvider;

@property (weak, nonatomic) IBOutlet UILabel *lblMessageArriveTime;

@property (weak, nonatomic) IBOutlet UILabel *lblMessageDetail;

@property (nonatomic, copy) NSString *SenderId;

@property (nonatomic, assign) int MessageId;

@end
