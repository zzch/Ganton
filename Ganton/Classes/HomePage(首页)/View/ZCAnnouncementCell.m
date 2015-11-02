//
//  ZCAnnouncementCell.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnnouncementCell.h"
@interface ZCAnnouncementCell()
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *detailsLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UIImageView *rightImage;

@end
@implementation ZCAnnouncementCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCAnnouncementCell";
    ZCAnnouncementCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCAnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        
        UILabel *detailsLabel=[[UILabel alloc] init];
        detailsLabel.font=[UIFont systemFontOfSize:12];
        detailsLabel.textColor=ZCColor(153, 153, 153);
        [self.contentView addSubview:detailsLabel];
        detailsLabel.numberOfLines=0;
        self.detailsLabel=detailsLabel;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.font=[UIFont systemFontOfSize:12];
        detailsLabel.textColor=ZCColor(153, 153, 153);
        [self.contentView addSubview:timeLabel];
        timeLabel.textAlignment=NSTextAlignmentRight;
        self.timeLabel=timeLabel;
        
//        UIImageView *rightImage=[[UIImageView alloc] init];
//        rightImage.backgroundColor=[UIColor redColor];
//        [self.contentView addSubview:rightImage];
//        self.rightImage=rightImage;

    }
    return  self;
}


-(void)setAnnouncementListModel:(ZCAnnouncementListModel *)announcementListModel
{
    _announcementListModel=announcementListModel;
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",announcementListModel.title];
    self.detailsLabel.text=[NSString stringWithFormat:@"%@",announcementListModel.summary];
    
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:announcementListModel.published_at];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:confromTimesp];
    self.timeLabel.text=destDateString;


}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=14;
    CGFloat nameLabelW=250;
    CGFloat nameLabelH=15;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat detailsLabelX=10;
    CGFloat detailsLabelY=nameLabelY+nameLabelH+15;
    CGFloat detailsLabelW=SCREEN_WIDTH-detailsLabelX-15;
    CGFloat detailsLabelH=15;
    self.detailsLabel.frame=CGRectMake(detailsLabelX, detailsLabelY, detailsLabelW, detailsLabelH);
    
    CGFloat timeLabelX=SCREEN_WIDTH-135;
    CGFloat timeLabelY=nameLabelY;
    CGFloat timeLabelW=120;
    CGFloat timeLabelH=15;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
//    
//    CGFloat rightImageW=15;
//    CGFloat rightImageH=15;
//    CGFloat rightImageX=(SCREEN_WIDTH-rightImageW)-20;
//    CGFloat rightImageY=(self.frame.size.height-rightImageH)/2;
//    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
