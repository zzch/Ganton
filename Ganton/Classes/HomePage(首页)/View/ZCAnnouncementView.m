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
    
    ZCLog(@"%@",announcements);
    
//    
//    UILabel *weatherLabel=[[UILabel alloc] init];
//    weatherLabel.frame=CGRectMake(0, 0, 90, 40);
//    weatherLabel.text=@"今天: 23 ℃";
//    [self addSubview:weatherLabel];
    
    
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, self.frame.size.width, 54);
    [self addSubview:scrollView];
    self.scrollView=scrollView;
    
    scrollView.contentSize = CGSizeMake(0, 3*54);
    scrollView.pagingEnabled = YES;
    
    for (int i=0; i<announcements.count; i++) {
        UIView *view=[[UIView alloc] init];
        view.frame=CGRectMake(0, i*54, self.frame.size.width, 54);
        [self addContentForView:view andAnnouncementModel:announcements[i]];
       
        [scrollView addSubview:view];
        
    }
    
    [self addTimer];

    
    
}

//添加滚动View上的控件
-(void)addContentForView:(UIView *)view andAnnouncementModel:(ZCAnnouncementModel *)announcementModel
{
    UILabel *upLabel=[[UILabel alloc] init];
    upLabel.textColor=[UIColor whiteColor];
    upLabel.font=[UIFont systemFontOfSize:15];
    upLabel.text=announcementModel.title;
    upLabel.frame=CGRectMake(0, 7, self.frame.size.width, 20);
    [view addSubview:upLabel];
    
    
    
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy年MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:announcementModel.published_at];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
    
   

    
    UILabel *downLabel=[[UILabel alloc] init];
    downLabel.textColor=[UIColor whiteColor];
    downLabel.font=[UIFont systemFontOfSize:12];
    downLabel.text=[NSString stringWithFormat:@"%@",nowDateString ];
    downLabel.frame=CGRectMake(0, 30, self.frame.size.width, 17);
    [view addSubview:downLabel];
    
    

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
    CGFloat offsetX = self.page * 54;
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
