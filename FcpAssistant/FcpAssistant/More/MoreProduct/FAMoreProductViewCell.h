//
//  FAMoreProductViewCell.h
//  FcpAssistant
//
//  Created by YangMing on 14-9-12.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAMoreProductViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgProductLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@property (weak, nonatomic) IBOutlet UILabel *lblProductDescription;

@end
