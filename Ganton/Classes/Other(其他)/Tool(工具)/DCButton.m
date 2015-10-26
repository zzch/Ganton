//
//  DCButton.m
//  Ganton
//
//  Created by hh on 15/10/21.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "DCButton.h"

@implementation DCButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
    }
    return self;
}

// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

-(void)setSelected:(BOOL)selected
{
    

}


// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height ;
    return CGRectMake(0, 0, imageW, imageH);
}


// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    //    CGFloat titleY = contentRect.size.height * IWTabBarButtonImageRatio;
    //    CGFloat titleW = contentRect.size.width;
    //    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, 0, 0, 0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
