//
//  PTQuetoHeaderView.m
//  OptionStrategy
//
//  Created by user01 on 11/24/14.
//  Copyright (c) 2014年 Polaris Technology. All rights reserved.
//

#import "PTQuetoHeaderView.h"
#import "PTVarietyViewController.h"

@implementation PTQuetoHeaderView

@synthesize headerDelegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(IBAction)selectVarietyClick:(id)sender{
    [self.headerDelegate selectVariety];
}

-(IBAction)selectExpiredTimeClick:(id)sender{
    [self.headerDelegate selectExpiredTime];
}

@end
