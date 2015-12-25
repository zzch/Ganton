//
//  ZCTeachingCourseCell.m
//  Ganton
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//教练教学预约cell

#import "ZCTeachingCourseCell.h"
@interface ZCTeachingCourseCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *appointmentLabel;
@property(nonatomic,weak)UIImageView *rightImage;

@end
@implementation ZCTeachingCourseCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"ZCTeachingCourseCell";
    ZCTeachingCourseCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCTeachingCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.backgroundColor=ZCColor(40, 44, 47);
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
        self.selectedBackgroundView.backgroundColor = ZCColor(54, 56, 57);
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"青少年套课";
        nameLabel.font=[UIFont systemFontOfSize:18];
        nameLabel.textColor=ZCColor(180, 191, 195);
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.text=@"有效期: 2016.01.30";
        timeLabel.font=[UIFont systemFontOfSize:13];
        timeLabel.textColor=ZCColor(180, 191, 195);
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.text=@"02/10";
        numberLabel.font=[UIFont systemFontOfSize:13];
        numberLabel.textColor=ZCColor(180, 191, 195);
        [self.contentView addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        UILabel *appointmentLabel=[[UILabel alloc] init];
        appointmentLabel.text=@"预约";
        appointmentLabel.font=[UIFont systemFontOfSize:18];
        appointmentLabel.textColor=ZCColor(87, 177, 20);
        [self.contentView addSubview:appointmentLabel];
        self.appointmentLabel=appointmentLabel;
        
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.image=[UIImage imageNamed:@"jiaolian_jt"];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
        
        
    }
    return self;
}



-(void)setStudentModel:(ZCStudentModel *)studentModel
{
    _studentModel=studentModel;
    self.nameLabel.text=studentModel.name;
    
     NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:studentModel.expired_at];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
    NSString *selfStr = [dateFormatter stringFromDate:confromTimesp];
    
    self.timeLabel.text=[NSString stringWithFormat:@"有效期: %@",selfStr];

}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=20;
    CGFloat nameLabelW=[ZCTool getFrame:CGSizeMake(1000, 15) content:self.nameLabel.text fontSize:[UIFont systemFontOfSize:18]].size.width;
    CGFloat nameLabelH=15;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat timeLabelX=10;
    CGFloat timeLabelY=nameLabelY+nameLabelH+15;
    CGFloat timeLabelW=200;
    CGFloat timeLabelH=15;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat numberLabelX=nameLabelX+nameLabelW+20;
    CGFloat numberLabelY=nameLabelY;
    CGFloat numberLabelW=100;
    CGFloat numberLabelH=15;
   // self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    
    CGFloat appointmentLabelW=40;
    CGFloat appointmentLabelH=15;
    CGFloat appointmentLabelX=self.frame.size.width-56;
    CGFloat appointmentLabelY=(self.frame.size.height-appointmentLabelH)/2;
    self.appointmentLabel.frame=CGRectMake(appointmentLabelX, appointmentLabelY, appointmentLabelW, appointmentLabelH);
    
    
    CGFloat rightImageW=6;
    CGFloat rightImageH=11;
    CGFloat rightImageX=self.frame.size.width-16;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)/2;
    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
