//
//  ZCMakeAnAppointmentCell.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMakeAnAppointmentCell.h"
@interface ZCMakeAnAppointmentCell()

@property(nonatomic,weak)UILabel *typeLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIButton *cancelButton;

@end
@implementation ZCMakeAnAppointmentCell
+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCMakeAnAppointmentCell";
    ZCMakeAnAppointmentCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCMakeAnAppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.text=@"2015年9月20日 17：19";
        timeLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"高尔夫球场 16号打位";
        nameLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *typeLabel=[[UILabel alloc] init];
        typeLabel.text=@"已完成";
        typeLabel.font=[UIFont systemFontOfSize:15];
        typeLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:typeLabel];
        self.typeLabel=typeLabel;
        
//        UIButton *cancelButton=[[UIButton alloc] init];
//        cancelButton.backgroundColor=[UIColor redColor];
//        [cancelButton setTitle:@"取消预约" forState:UIControlStateNormal];
//        cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
//        [self.contentView addSubview:cancelButton];
//        self.cancelButton=cancelButton;
//        [cancelButton addTarget:self action:@selector(clickTheCancelButton) forControlEvents:UIControlEventTouchUpInside];

    
    }
    return self;
}

//赋值
-(void)setMakeAnAppointmentModel:(ZCMakeAnAppointmentModel *)makeAnAppointmentModel
{
    _makeAnAppointmentModel=makeAnAppointmentModel;
    
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"MM月dd号 HH:mm"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:makeAnAppointmentModel.will_playing_at];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
    
    self.timeLabel.text=nowDateString;
    
    ZCLog(@"%@",makeAnAppointmentModel.name);
    
    self.nameLabel.text=makeAnAppointmentModel.name;
    
    if ([makeAnAppointmentModel.state isEqual:@"submitted"]) {
        self.typeLabel.text=@"待确认";
        self.typeLabel.textColor=ZCColor(252, 76, 27);
        self.nameLabel.textColor=ZCColor(34, 34, 34);
        self.timeLabel.textColor=ZCColor(34, 34, 34);
    }else if ([makeAnAppointmentModel.state isEqual:@"confirmed"]){
        self.typeLabel.text=@"已预约";
        self.typeLabel.textColor=ZCColor(252, 76, 27);
        self.nameLabel.textColor=ZCColor(34, 34, 34);
        self.timeLabel.textColor=ZCColor(34, 34, 34);
    }else if ([makeAnAppointmentModel.state isEqual:@"finished"]){
        self.typeLabel.text=@"已完成";
        self.typeLabel.textColor=ZCColor(153, 153, 153);
        self.nameLabel.textColor=ZCColor(153, 153, 153);
        self.timeLabel.textColor=ZCColor(153, 153, 153);
    }

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat timeLabelX=15;
    CGFloat timeLabelY=15;
    CGFloat timeLabelW=200;
    CGFloat timeLabelH=20;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat contentLabelX=timeLabelX;
    CGFloat contentLabelY=timeLabelY+timeLabelH+10;
    CGFloat contentLabelW=200;
    CGFloat contentLabelH=20;
    self.nameLabel.frame=CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    CGFloat typeLabelW=80;
    CGFloat typeLabelH=30;
    CGFloat typeLabelX=SCREEN_WIDTH-typeLabelW-30;
    CGFloat typeLabelY=(self.frame.size.height-typeLabelH)/2;
    self.typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    
//    CGFloat cancelButtonW=70;
//    CGFloat cancelButtonH=30;
//    CGFloat cancelButtonX=self.frame.size.width-cancelButtonW-15;
//    CGFloat cancelButtonY=(self.frame.size.height-cancelButtonH)/2;
//    self.cancelButton.frame=CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH);

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
