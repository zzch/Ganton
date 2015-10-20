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
@property(nonatomic,weak)UILabel *contentLabel;
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
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *contentLabel=[[UILabel alloc] init];
        contentLabel.text=@"高尔夫球场 16号打位";
        [self.contentView addSubview:contentLabel];
        self.contentLabel=contentLabel;
        
        UILabel *typeLabel=[[UILabel alloc] init];
        typeLabel.text=@"未开始";
        [self.contentView addSubview:typeLabel];
        self.typeLabel=typeLabel;
        
        UIButton *cancelButton=[[UIButton alloc] init];
        cancelButton.backgroundColor=[UIColor redColor];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.contentView addSubview:cancelButton];
        self.cancelButton=cancelButton;
        [cancelButton addTarget:self action:@selector(clickTheCancelButton) forControlEvents:UIControlEventTouchUpInside];

    
    }
    return self;
}

//点击取消
-(void)clickTheCancelButton
{
    

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat timeLabelX=10;
    CGFloat timeLabelY=10;
    CGFloat timeLabelW=200;
    CGFloat timeLabelH=30;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat contentLabelX=timeLabelX;
    CGFloat contentLabelY=timeLabelY+timeLabelH+20;
    CGFloat contentLabelW=200;
    CGFloat contentLabelH=30;
    self.contentLabel.frame=CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    
    CGFloat typeLabelW=80;
    CGFloat typeLabelH=30;
    CGFloat typeLabelX=SCREEN_WIDTH-100;
    CGFloat typeLabelY=timeLabelY;
    self.typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    CGFloat cancelButtonX=typeLabelX;
    CGFloat cancelButtonY=typeLabelY+typeLabelH+20;
    CGFloat cancelButtonW=80;
    CGFloat cancelButtonH=30;
    self.cancelButton.frame=CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH);

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
