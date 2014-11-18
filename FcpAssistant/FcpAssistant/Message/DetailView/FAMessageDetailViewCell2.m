//
//  FAMessageDetailViewCell2.m
//  FcpAssistant
//
//  Created by admin on 9/30/14.
//  Copyright (c) 2014 polaris. All rights reserved.
//

#import "FAMessageDetailViewCell2.h"

@implementation FAMessageDetailViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (self.editing)
    {
        if (selected)
        {
            NSLog(@"cell selected tag:%ld", self.tag);
            
            if ([self viewWithTag:self.tag])
            {
                UIImage *image = [UIImage imageNamed:@"message_radio_2"];
                UIImageView *editView = [[UIImageView alloc] initWithImage:image];
                editView.tag = self.tag;
                editView.frame = CGRectMake(12, 29, 22, 22);
                [self addSubview:editView];
            }
        }
        else
        {
            NSLog(@"cell deSelected tag:%ld", self.tag);
            
            if (!self.subviews[0])
            {
                return;
            }
            UIView *editView = (UIView *)self.subviews[0];
            
            for (UIView *subView in editView.subviews)
            {
                if(subView.tag == self.tag)
                {
                    [subView removeFromSuperview];
                }
            }
            
        }
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
//    if (editing)
//    {
//        if(self.editingStyle == (UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete))
//        {
//            if (![self viewWithTag:self.tag])
//            {
//                UIImage *image = [UIImage imageNamed:@""];
//                UIImageView *editView = [[UIImageView alloc] initWithImage:image];
//                editView.tag = self.tag;
//                editView.frame = CGRectMake(10, 15, 20, 20);
//                [self addSubview:editView];
//            }
//        }
//        NSLog(@"cell editing tag:%ld", self.tag);
//    }
//    else
//    {
//        UIView *editView = [self viewWithTag:self.tag];
//        if(editView)
//        {
//            [editView removeFromSuperview];
//        }
//        NSLog(@"cell noEditing tag:%ld", self.tag);
//    }
}

@end
