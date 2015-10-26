//
//  ZCAnnouncementView.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnnouncementView.h"
@interface ZCAnnouncementView()
/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,assign)int page;
@end
@implementation ZCAnnouncementView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
           }
    return self;
}


-(void)setAnnouncements:(NSMutableArray *)announcements
{
    _announcements=announcements;
    
//    
//    UILabel *weatherLabel=[[UILabel alloc] init];
//    weatherLabel.frame=CGRectMake(0, 0, 90, 40);
//    weatherLabel.text=@"今天: 23 ℃";
//    [self addSubview:weatherLabel];
    
    
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, self.frame.size.width, 40);
    [self addSubview:scrollView];
    self.scrollView=scrollView;
    
    scrollView.contentSize = CGSizeMake(0, 3*40);
    scrollView.pagingEnabled = YES;
    
    for (int i=0; i<announcements.count; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(0, i*40, self.frame.size.width, 40);
        label.text=[NSString stringWithFormat:@"%@",[announcements[i] title]];
        label.font=[UIFont systemFontOfSize:14];
        [scrollView addSubview:label];
        
    }
    
    [self addTimer];

    
    
}


/**
 *  添加定时器
 */
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 代理方法
/**
 *  当scrollView正在滚动就会调用
 */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 根据scrollView的滚动位置决定pageControl显示第几页
//    CGFloat scrollW = scrollView.frame.size.width;
//    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
//    self.pageControl.currentPage = page;
//}


- (void)nextImage
{
//    // 1.增加pageControl的页码
//    int page = 0;
//    if (self.pageControl.currentPage == 3 - 1) {
//        page = 0;
//    } else {
//        page = self.pageControl.currentPage + 1;
//    }
    
    
    if (self.page==_announcements.count-1) {
        self.page=0;
    }else{
    self.page++;
    }
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = self.page * 40;
    CGPoint offset = CGPointMake(0, offsetX);
    [self.scrollView setContentOffset:offset animated:YES];
}


/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}





@end
