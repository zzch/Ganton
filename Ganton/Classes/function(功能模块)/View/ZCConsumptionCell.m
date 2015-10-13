//
//  ZCConsumptionCell.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//消费记录

#import "ZCConsumptionCell.h"
@interface ZCConsumptionCell()
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *cardType;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UILabel *accountLabel;
@property(nonatomic,weak)UIImageView *rightImage;
@end
@implementation ZCConsumptionCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID=@"ZCConsumptionCell";
    ZCConsumptionCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCConsumptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;


}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.text=@"9月28日 14:28";
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UILabel *cardType=[[UILabel alloc] init];
        cardType.text=@"储蓄卡";
        cardType.backgroundColor=[UIColor brownColor];
        [self.contentView addSubview:cardType];
        self.cardType=cardType;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        moneyLabel.text=@"消费金额: ￥500";
        [self.contentView addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;
        
        UILabel *accountLabel=[[UILabel alloc] init];
        accountLabel.text=@"消费账号: 王二蛋";
        [self.contentView addSubview:accountLabel];
        self.accountLabel=accountLabel;
        
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
        
        
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat timeLabelX=10;
    CGFloat timeLabelY=10;
    CGFloat timeLabelW=200;
    CGFloat timeLabelH=20;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat cardTypeX=timeLabelX+timeLabelW+30;
    CGFloat cardTypeY=10;
    CGFloat cardTypeW=200;
    CGFloat cardTypeH=20;
    self.cardType.frame=CGRectMake(cardTypeX, cardTypeY, cardTypeW, cardTypeH);
    
    CGFloat moneyLabelX=timeLabelX;
    CGFloat moneyLabelY=10+timeLabelH+10;
    CGFloat moneyLabelW=200;
    CGFloat moneyLabelH=20;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
    CGFloat accountLabelX=timeLabelX;
    CGFloat accountLabelY=moneyLabelY+moneyLabelH+10;
    CGFloat accountLabelW=200;
    CGFloat accountLabelH=20;
    self.accountLabel.frame=CGRectMake(accountLabelX, accountLabelY, accountLabelW, accountLabelH);

    CGFloat rightImageW=10;
    CGFloat rightImageH=10;
    CGFloat rightImageX=SCREEN_WIDTH-40;
    CGFloat rightImageY=(self.frame.size.height-rightImageH)/2;
    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);

}


@end
