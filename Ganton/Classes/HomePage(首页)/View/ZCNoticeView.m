//
//  ZCNoticeView.m
//  Ganton
//
//  Created by hh on 16/3/17.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//背景公告

#import "ZCNoticeView.h"
#import "ZCAnnouncementView.h"
#import "ZCHomeModel.h"
@interface ZCNoticeView()
@property(nonatomic,weak)UILabel *weatherLabel;
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,strong)ZCAnnouncementView *announcementView;
@property(nonatomic,weak)UIImageView *rightImage;

@end
@implementation ZCNoticeView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=ZCColor(43, 45, 46);
        
        
        
        
        UILabel *weatherLabel=[[UILabel alloc] init];
        weatherLabel.backgroundColor=ZCColor(43, 45, 46);
        weatherLabel.font=[UIFont systemFontOfSize:14];
        weatherLabel.textColor=[UIColor whiteColor];
        weatherLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:weatherLabel];
        self.weatherLabel=weatherLabel;
        
        
        UIView *bjView=[[UIView alloc] init];
        bjView.backgroundColor=[ZCTool colorWithHexString:@"#484848"];;
        [self addSubview:bjView];
        self.bjView=bjView;
        
        
        
        
        ZCAnnouncementView *announcementView=[[ZCAnnouncementView alloc] init];
         [self addSubview:announcementView];
        self.announcementView=announcementView;
       
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.image=[UIImage imageNamed:@"shouye_arrow_icon"];
        [self addSubview:rightImage];
        self.rightImage=rightImage;

        
        
        
        
    }
    return self;
}


-(void)setHomeModel:(ZCHomeModel *)homeModel
{
    _homeModel=homeModel;
    //强制调用布局否则self.announcementView不会显示内容
    [self layoutSubviews];
    
     self.weatherLabel.text=[NSString stringWithFormat:@"%@ %@ ℃",[ZCTool JudgmentIsWhichDay:self.homeModel.date],self.homeModel.maximum_temperature ];
    
    
    self.announcementView.announcements=self.homeModel.announcements;

}




-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.weatherLabel.frame=CGRectMake(0, 0, 90, 53.5);
    self.bjView.frame=CGRectMake(90, 5, 1, 44);
    self.announcementView.frame=CGRectMake(108, 0, self.frame.size.width-115-6-10, 39.5);
    self.rightImage.frame=CGRectMake(self.frame.size.width-6-10, 21.5, 6, 11);
    
}

@end
