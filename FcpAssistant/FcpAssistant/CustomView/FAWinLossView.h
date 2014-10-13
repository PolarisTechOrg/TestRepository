//
//  FAWinLossView.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-11.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PI 3.14159265358979323846

@interface FAWinLossView : UIView
{
@private CGFloat leftMargin;
@private CGFloat topMargin;
    
@private CGFloat itemXInterval;
@private CGFloat itemYInterval;
@private CGFloat itemRadius;
    
@private CGColorRef winItemColor;
@private CGColorRef drawItemColor;
@private CGColorRef lossItemColor;
}

@property(nonatomic,retain) NSArray *dataSource;
@end
