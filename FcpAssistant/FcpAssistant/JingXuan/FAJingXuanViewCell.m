//
//  FAJingXuanViewCell.m
//  FcpAssistant
//
//  Created by admin on 9/17/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAJingXuanViewCell.h"
#import "FAJingXuanController.h"
#import "FAStrategyDetailController.h"

@implementation FAJingXuanViewCell

@synthesize nameIdDict;
@synthesize navigationController;

@synthesize strategyId1;
@synthesize strategyId2;
@synthesize strategyId3;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// after cell initialization
- (void)initialNameIdDictionary
{
    nameIdDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:strategyId1], _btnStrategyName1.titleLabel.text, [NSNumber numberWithInt:strategyId2], _btnStrategyName2.titleLabel.text, [NSNumber numberWithInt:strategyId3], _btnStrategyName3.titleLabel.text, nil];
}

- (IBAction)strategyNamePressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *txt = btn.titleLabel.text;
    
    
    FAStrategyDetailController *controller = [[FAStrategyDetailController alloc] init];
    controller.strategyId = [[self.nameIdDict objectForKey:txt] intValue];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
