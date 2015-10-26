//
//  UIView+addShadow.m
//  WeWish
//
//  Created by 刘宇 on 15/8/6.
//  Copyright (c) 2015年 WeWish. All rights reserved.
//

#import "UIView+addShadow.h"

@implementation UIView (addShadow)

- (void)addShadow
{
    //添加阴影效果
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 2;
}

@end
