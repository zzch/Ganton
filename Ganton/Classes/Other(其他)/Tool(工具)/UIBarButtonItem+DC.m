//
//  UIBarButtonItem+DC.m
//
//
//  Created by 夜天 on 15/3/31.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
// 返回按钮  调用传进图片

#import "UIBarButtonItem+DC.h"

@implementation UIBarButtonItem (DC)
+ (UIBarButtonItem *)barBtnItemWithNormalImageName:(NSString *)normImageName hightImageName:(NSString *)hightIamgeName action:(SEL)action target:(id)target withBtnName:(NSString *)btnName
{
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:normImageName] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:hightIamgeName] forState:UIControlStateHighlighted];
    btn1.frame = (CGRect){{-5,0},btn1.currentImage.size};
    [btn1 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (btnName.length > 0)
    {
        [btn1 setTitle:btnName forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn1.frame = CGRectMake(-10, 0, 50, 50);
    }
    return [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
}

@end
