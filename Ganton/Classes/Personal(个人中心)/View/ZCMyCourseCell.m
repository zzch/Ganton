//
//  ZCMyCourseCell.m
//  Ganton
//
//  Created by hh on 15/12/21.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//  我的课程

#import "ZCMyCourseCell.h"
@interface ZCMyCourseCell()
@property(nonatomic,weak)UIImageView *bjImageView;
@property(nonatomic,weak)UIImageView *dateImageView;
@property(nonatomic,weak)UILabel *monthLabel;
@property(nonatomic,weak)UILabel *dayLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *courseNameLabel;
@property(nonatomic,weak)UILabel *typeLabel;
@property(nonatomic,weak)UILabel *stadiumLabel;
@property(nonatomic,weak)UILabel *stateLabel;
@end
@implementation ZCMyCourseCell

+(instancetype)CellWithTabaleView:(UITableView *)tableView
{
    static NSString *ID=@"ZCMyCourseCell";
    ZCMyCourseCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCMyCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor=[UIColor clearColor];
        
        UIImageView *bjImageView=[[UIImageView alloc] init];
        bjImageView.image=[ZCTool imagePullLitre:@"wodekecheng_bj"];
        [self.contentView addSubview:bjImageView];
        self.bjImageView=bjImageView;
        
        UIImageView *dateImageView=[[UIImageView alloc] init];
        dateImageView.image=[UIImage imageNamed:@"wodekecheng_rl_bj"];
        [bjImageView addSubview:dateImageView];
        self.dateImageView=dateImageView;
        
        UILabel *monthLabel=[[UILabel alloc] init];
        monthLabel.text=@"12月";
        monthLabel.textColor=[UIColor whiteColor];
        monthLabel.font=[UIFont systemFontOfSize:12];
        [dateImageView addSubview:monthLabel];
        self.monthLabel=monthLabel;
        
        UILabel *dayLabel=[[UILabel alloc] init];
        dayLabel.font=[UIFont systemFontOfSize:25];
        dayLabel.textColor=[UIColor whiteColor];
        dayLabel.text=@"20";
        dayLabel.textAlignment=NSTextAlignmentCenter;
        [dateImageView addSubview:dayLabel];
        self.dayLabel=dayLabel;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.font=[UIFont systemFontOfSize:12];
        timeLabel.textColor=[UIColor whiteColor];
        timeLabel.text=@"14:00";
        timeLabel.textAlignment=NSTextAlignmentCenter;
        [dateImageView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *courseNameLabel=[[UILabel alloc] init];
        courseNameLabel.text=@"青少年套课";
        courseNameLabel.font=[UIFont systemFontOfSize:16];
        [bjImageView addSubview:courseNameLabel];
        self.courseNameLabel=courseNameLabel;
        
        UILabel *typeLabel=[[UILabel alloc] init];
        typeLabel.text=@"精英教练: 王洋";
        typeLabel.font=[UIFont systemFontOfSize:13];
        [bjImageView addSubview:typeLabel];
        self.typeLabel=typeLabel;
        
        UILabel *stadiumLabel=[[UILabel alloc] init];
        stadiumLabel.font=[UIFont systemFontOfSize:13];
        stadiumLabel.text=@"球场: 中创高尔夫";
        [bjImageView addSubview:stadiumLabel];
        self.stadiumLabel=stadiumLabel;
        
        UILabel *stateLabel=[[UILabel alloc] init];
        stateLabel.backgroundColor=[UIColor redColor];
        stateLabel.text=@"等待上课";
        stateLabel.layer.cornerRadius=3;
        stateLabel.layer.masksToBounds=YES;
        stateLabel.textColor=[UIColor whiteColor];
        stateLabel.font=[UIFont systemFontOfSize:13];
        stateLabel.textAlignment=NSTextAlignmentCenter;
        [bjImageView addSubview:stateLabel];
        self.stateLabel=stateLabel;
        
    }
    return self;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bjImageView.frame=CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
    
    CGFloat dateImageViewX=12;
    CGFloat dateImageViewY=10;
    CGFloat dateImageViewW=80;
    CGFloat dateImageViewH=80;
    self.dateImageView.frame=CGRectMake(dateImageViewX, dateImageViewY, dateImageViewW, dateImageViewH);
    
    CGFloat monthLabelX=9;
    CGFloat monthLabelY=9;
    CGFloat monthLabelW=60;
    CGFloat monthLabelH=15;
    self.monthLabel.frame=CGRectMake(monthLabelX, monthLabelY, monthLabelW, monthLabelH);
    
    CGFloat dayLabelW=dateImageViewW;
    CGFloat dayLabelH=30;
    CGFloat dayLabelX=0;
    CGFloat dayLabelY=(dateImageViewH-dayLabelH)/2;
    self.dayLabel.frame=CGRectMake(dayLabelX, dayLabelY, dayLabelW, dayLabelH);
    
    CGFloat timeLabelW=dateImageViewW;
    CGFloat timeLabelH=15;
    CGFloat timeLabelX=0;
    CGFloat timeLabelY=(dateImageViewH-timeLabelH)-9;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    
    CGFloat courseNameLabelX=dateImageViewX+dateImageViewW+5;
    CGFloat courseNameLabelY=15;
    CGFloat courseNameLabelW=self.bjImageView.frame.size.width-90;
    CGFloat courseNameLabelH=20;
    self.courseNameLabel.frame=CGRectMake(courseNameLabelX, courseNameLabelY, courseNameLabelW, courseNameLabelH);
    
    CGFloat typeLabelY=courseNameLabelY+courseNameLabelH+17;
    CGFloat typeLabelW=courseNameLabelW;
    CGFloat typeLabelH=15;
    self.typeLabel.frame=CGRectMake(courseNameLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    CGFloat stadiumLabelY=typeLabelY+typeLabelH+8;
    self.stadiumLabel.frame=CGRectMake(courseNameLabelX, stadiumLabelY, typeLabelW, typeLabelH);
    
    
    CGFloat stateLabelW=75;
    CGFloat stateLabelH=30;
    CGFloat stateLabelX=(self.bjImageView.frame.size.width-stateLabelW)-8;
    CGFloat stateLabelY=8;
    self.stateLabel.frame=CGRectMake(stateLabelX, stateLabelY, stateLabelW, stateLabelH);

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
