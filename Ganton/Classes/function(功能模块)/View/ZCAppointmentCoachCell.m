//
//  ZCAppointmentCoachCell.m
//  Ganton
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAppointmentCoachCell.h"
@interface ZCAppointmentCoachCell()
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *stateLabel;
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
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.text=@"2015.12.12    2016.15.16";
        timeLabel.textColor=ZCColor(85, 85, 85);
        timeLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.textColor=ZCColor(34, 34, 34);
        numberLabel.text=@"预约人数 (3/6)";
        numberLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        
        UIImageView *bjImageView=[[UIImageView alloc] init];
        bjImageView.image=[UIImage imageNamed:@"yy_keyuyue"];
        [self.contentView addSubview:bjImageView];
        self.bjImageView=bjImageView;
        
        UILabel *stateLabel=[[UILabel alloc] init];
        stateLabel.text=@"可预约";
        //stateLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yy_keyuyue"]];
        stateLabel.font=[UIFont systemFontOfSize:15];
        stateLabel.textAlignment=NSTextAlignmentCenter;
        stateLabel.textColor=[UIColor whiteColor];
        [bjImageView addSubview:stateLabel];
        self.stateLabel=stateLabel;
    }
    return self;
}







-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat timeLabelX=20;
    CGFloat timeLabelY=17;
    CGFloat timeLabelW=self.frame.size.width-100;
    CGFloat timeLabelH=15;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat numberLabelX=timeLabelX;
    CGFloat numberLabelY=timeLabelY+timeLabelH+15;
    CGFloat numberLabelW=timeLabelW;
    CGFloat numberLabelH=15;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    CGFloat stateLabelW=74.5;
    CGFloat stateLabelH=30;
    CGFloat stateLabelX=self.frame.size.width-stateLabelW-15;
    CGFloat stateLabelY=(self.frame.size.height-stateLabelH)/2;
    self.bjImageView.frame=CGRectMake(stateLabelX, stateLabelY, stateLabelW, stateLabelH);
    
    self.stateLabel.frame=CGRectMake(0, 0, stateLabelW, stateLabelH);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
