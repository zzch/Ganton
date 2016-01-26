//
//  ZCAppointmentCoachCell.m
//  Ganton
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAppointmentCoachCell.h"
@interface ZCAppointmentCoachCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UIButton *stateButton;
@property(nonatomic,weak)UIImageView *bjImageView;
@end
@implementation ZCAppointmentCoachCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"ZCTeachingCourseCell";
    ZCAppointmentCoachCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCAppointmentCoachCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.textColor=ZCColor(34, 34, 34);
        nameLabel.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.text=@"2015.12.12    2016.15.16";
        timeLabel.textColor=ZCColor(85, 85, 85);
        timeLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.textColor=ZCColor(102, 102, 102);
        numberLabel.text=@"预约人数 (3/6)";
        numberLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        
//        UIImageView *bjImageView=[[UIImageView alloc] init];
//        bjImageView.image=[UIImage imageNamed:@"yy_keyuyue"];
//        [self.contentView addSubview:bjImageView];
//        self.bjImageView=bjImageView;
        
        UIButton *stateButton=[[UIButton alloc] init];
        [stateButton setTitle:@"可预约" forState:UIControlStateNormal];
        [stateButton setBackgroundImage:[UIImage imageNamed:@"yy_keyuyue"] forState:UIControlStateNormal];
        //stateLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yy_keyuyue"]];
        stateButton.titleLabel.font=[UIFont systemFontOfSize:15];
        //stateLabel.textAlignment=NSTextAlignmentCenter;
        //stateLabel.textColor=[UIColor whiteColor];
        [self.contentView addSubview:stateButton];
        self.stateButton=stateButton;
        [stateButton addTarget:self action:@selector(clickTheStateButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}



-(void)setUnstartedLessonsModel:(ZCUnstartedLessonsModel *)unstartedLessonsModel
{
    _unstartedLessonsModel=unstartedLessonsModel;
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",unstartedLessonsModel.name];
    
    
    
    NSDate *started_atDate=[NSDate dateWithTimeIntervalSince1970:unstartedLessonsModel.started_at];
    NSDate *finished_atDate=[NSDate dateWithTimeIntervalSince1970:unstartedLessonsModel.finished_at];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    NSString *started_at = [dateFormatter stringFromDate:started_atDate];
   // NSString *finished_at = [dateFormatter stringFromDate:finished_atDate];

    dateFormatter.dateFormat=@"HH:mm";
    NSString *startStr=[dateFormatter stringFromDate:started_atDate];
   
    NSString *finishStr=[dateFormatter stringFromDate:finished_atDate];
    
    
    self.timeLabel.text=[NSString stringWithFormat:@"%@  %@-%@",started_at,startStr,finishStr];
    
    self.numberLabel.text=[NSString stringWithFormat:@"预约人数 (%@/%@)",unstartedLessonsModel.current_students,unstartedLessonsModel.maximum_students];
    
    if ([unstartedLessonsModel.state isEqual:@"available"]) {
        self.stateButton.enabled=YES;
        [self.stateButton setBackgroundImage:[UIImage imageNamed:@"yy_keyuyue"] forState:UIControlStateNormal];
        [self.stateButton setTitle:@"可预约" forState:UIControlStateNormal];
    }else if ([unstartedLessonsModel.state isEqual:@"full"]){
    
        self.stateButton.enabled=NO;
        [self.stateButton setBackgroundImage:[UIImage imageNamed:@"yy_yiman"] forState:UIControlStateNormal];
        [self.stateButton setTitle:@"已满" forState:UIControlStateNormal];
    }else{
        self.stateButton.enabled=NO;
       [self.stateButton setBackgroundImage:[UIImage imageNamed:@"yy_yiyuyue"] forState:UIControlStateNormal];
        [self.stateButton setTitle:@"已预约" forState:UIControlStateNormal];
    }

}




-(void)clickTheStateButton:(UIButton *)sender
{

    if ([self.delegate respondsToSelector:@selector(clickTheButton:andnName:andUUID:)]) {

        [self.delegate clickTheButton:sender andnName:self.unstartedLessonsModel.name andUUID:self.unstartedLessonsModel.uuid];
    }
    
}





-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat nameLabelX=20;
    CGFloat nameLabelY=15;
    CGFloat nameLabelW=self.frame.size.width-100;
    CGFloat nameLabelH=15;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat timeLabelX=20;
    CGFloat timeLabelY=nameLabelY+nameLabelH+12;
    CGFloat timeLabelW=self.frame.size.width-100;
    CGFloat timeLabelH=15;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat numberLabelX=timeLabelX;
    CGFloat numberLabelY=timeLabelY+timeLabelH+10;
    CGFloat numberLabelW=timeLabelW;
    CGFloat numberLabelH=15;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    CGFloat stateLabelW=74.5;
    CGFloat stateLabelH=30;
    CGFloat stateLabelX=self.frame.size.width-stateLabelW-15;
    CGFloat stateLabelY=(self.frame.size.height-stateLabelH)/2;
    self.stateButton.frame=CGRectMake(stateLabelX, stateLabelY, stateLabelW, stateLabelH);
    
   // self.stateButton.frame=CGRectMake(0, 0, stateLabelW, stateLabelH);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
