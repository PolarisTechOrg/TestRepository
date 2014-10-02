//
//  FAStrategyProfitView.h
//  FcpAssistant
//
//  Created by YangMing on 14-10-2.
//  Copyright (c) 2014年 polaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAStrategyProfitView : UIView
{
   UIColor *backgroundColor;
}

-(void)setBackgroundColor:(UIColor *) backColor;
-(UIColor *) getBackgroundColor;


@property(nonatomic,retain) NSMutableArray *dataSource;
@end
