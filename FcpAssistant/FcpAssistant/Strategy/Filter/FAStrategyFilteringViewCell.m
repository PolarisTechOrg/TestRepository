//
//  FAStrategyFilterViewCell.m
//  FcpAssistant
//
//  Created by admin on 11/3/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAStrategyFilteringViewCell.h"
#import "FAPriceParten.h"
#import "FAVarieties.h"

@implementation FAStrategyFilteringViewCell

@synthesize pricePartenSource;
@synthesize varietiesSource;
@synthesize parentTableView;


- (void)awakeFromNib
{
}

// single source
- (void)fillingData
{
    if (pricePartenSource)
    {
        NSArray *array = pricePartenSource.allValues;
        for (int i = 0; i < array.count; i++)
        {
            FAPriceParten *p = array[i];
            
            [self setButtonStyle:p.seqId withTitle:p.PartenName inFrame:[self getCGRect:i] selectFlag:p.includeFlag];
        }
    }
    else if (varietiesSource)
    {
        NSArray *array = varietiesSource.allValues;
        for (int i = 0; i < array.count; i++)
        {
            FAVarieties *p = array[i];
            
            [self setButtonStyle:p.seqId withTitle:p.Name inFrame:[self getCGRect:i] selectFlag:p.includeFlag];
        }
    }
    else
    {
        return;
    }
}

- (void)setButtonStyle:(int)tag withTitle:(NSString *)title inFrame:(CGRect)frame selectFlag:(BOOL)flag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = frame;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    if(flag)
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"Strategy_bg_select_single"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_select_normal"] forState:UIControlStateNormal];
    }
    
    [btn addTarget:self action:@selector(choiceUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:btn];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)choiceUp:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSIndexPath *indexPath = [parentTableView indexPathForCell:self];
    
    if (pricePartenSource && indexPath.row == 3)
    {
        FAPriceParten *p = [pricePartenSource objectForKey:[NSNumber numberWithLong:btn.tag]];
        if (p.includeFlag == true)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_select_normal"] forState:UIControlStateNormal];
            p.includeFlag = false;
        }
        else
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"Strategy_bg_select_single"] forState:UIControlStateNormal];
            p.includeFlag = true;
        }
    }
    
    if(varietiesSource && indexPath.row == 1)
    {
        FAVarieties *v = [varietiesSource objectForKey:[NSNumber numberWithLong:btn.tag]];
        if(v.includeFlag == true)
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_select_normal"] forState:UIControlStateNormal];
            v.includeFlag = false;
        }
        else
        {
            [btn setBackgroundImage:[UIImage imageNamed:@"Strategy_bg_select_single"] forState:UIControlStateNormal];
            v.includeFlag = true;
        }           
    }
}

- (CGRect)getCGRect:(int)index
{
    double row = floor(index/4);
    double column = floor(index%4);
    
    CGFloat currX = 10 + column * 75;
    CGFloat currY = 15 + row * 40;
    
    return CGRectMake(currX, currY, 70, 35);
}

- (NSMutableArray *)searchPricePartenList
{
    NSIndexPath *indexPath = [parentTableView indexPathForCell:self];
    if (indexPath.row != 3)
    {
        return nil;
    }
    if(pricePartenSource == nil || pricePartenSource.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *partens = [NSMutableArray arrayWithCapacity:32];
    NSArray *partenArray = [pricePartenSource allValues];
    for (FAPriceParten *p in partenArray)
    {
        if (p.includeFlag == false)
        {
            continue;
        }
        [partens addObject:[NSNumber numberWithInt:p.PartenID]];
    }
    
    return partens;
}

- (NSMutableArray *)searchVarietiesList
{
    NSIndexPath *indexPath = [parentTableView indexPathForCell:self];
    if (indexPath.row != 1)
    {
        return nil;
    }
    if(varietiesSource == nil || varietiesSource.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *varieties = [NSMutableArray arrayWithCapacity:32];
    NSArray *varArray = [varietiesSource allValues];
    for (FAVarieties *p in varArray)
    {
        if (p.includeFlag == false)
        {
            continue;
        }
        [varieties addObject:p.Code];
    }
    
    return varieties;
}
@end
