//
//  ZCScrollCardView.m
//  Ganton
//
//  Created by hh on 16/3/17.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//会员卡块

#import "ZCScrollCardView.h"
#import "ZCMembershipCardView.h"
@interface ZCScrollCardView()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end
@implementation ZCScrollCardView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
    }
    return self;

}




-(void)setHomeModel:(ZCHomeModel *)homeModel
{
    _homeModel=homeModel;
    
    ZCLog(@"%f",self.frame.size.width);
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    scrollView.delegate=self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    
    [self addSubview:scrollView];
    self.scrollView=scrollView;
    
    
    for (int i=0; i<self.homeModel.members.count; i++) {
        ZCMembershipCardView *imageView=[[ZCMembershipCardView alloc] init];
        
        
        imageView.frame=CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView addSubview:imageView];
        
       
        //新版本
        [imageView setMemberModel:self.homeModel.members[i] andHomeModel:self.homeModel];
        
        
        [imageView addTarget:self action:@selector(clickTheMembershipCardView) forControlEvents:UIControlEventTouchUpInside];
        
        self.scrollView.contentSize=CGSizeMake((i+1)*self.frame.size.width, 0);
        
       
        [self setupPageControl];
        
    }


    
    
    
}


/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    if (self.homeModel.members.count==1) {
        return ;
    }else{
        
        // 1.添加
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.homeModel.members.count;
        CGFloat centerX = self.frame.size.width * 0.5;
        CGFloat centerY = self.frame.size.height-13 ;
        pageControl.center = CGPointMake(centerX, centerY);
        pageControl.bounds = CGRectMake(0, 0, 100, 23);
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        //pageControl.backgroundColor=[UIColor redColor];
        
        //    // 2.设置圆点的颜色
        //    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shouye_xuanzhong_icon"]];
        //    pageControl.pageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"shouye_moren_icon"]];
        
        
        // 2.设置圆点的颜色ZCColor(102, 102, 102)
        pageControl.currentPageIndicatorTintColor = ZCColor(203, 203, 203);
        pageControl.pageIndicatorTintColor = ZCColor(102, 102, 102);
    }
}

/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
    
    //    if (pageInt==2) {
    //        self.pageControl.hidden=YES ;
    //    }else
    //    {
    //        self.pageControl.hidden=NO;
    //    }
}




//点击会员卡
-(void)clickTheMembershipCardView
{
    if ([self.delegate respondsToSelector:@selector(scrollCardView:clickTheCardUuid:)]) {
       // int index= self.homeModel.members[self.pageControl.currentPage];
        
        [self.delegate scrollCardView:self clickTheCardUuid:[self.homeModel.members[self.pageControl.currentPage] uuid]];
    }
    
    
}



@end
