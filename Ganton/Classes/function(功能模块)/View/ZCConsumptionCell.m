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
        timeLabel.text=@"2015-9-28 14:28";
        timeLabel.font=[UIFont systemFontOfSize:15];
        timeLabel.textColor=[UIColor redColor];
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
//        UILabel *cardType=[[UILabel alloc] init];
//        cardType.text=@"储蓄卡";
//        //cardType.backgroundColor=[UIColor brownColor];
//        cardType.font=[UIFont systemFontOfSize:13];
//        [self.contentView addSubview:cardType];
//        self.cardType=cardType;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        moneyLabel.text=@"消费金额: ￥500";
        moneyLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;
        
        UILabel *accountLabel=[[UILabel alloc] init];
        accountLabel.text=@"消费账号: 王二蛋";
        accountLabel.font=[UIFont systemFontOfSize:13];
        [self.contentView addSubview:accountLabel];
        self.accountLabel=accountLabel;
        
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.image=[UIImage imageNamed:@"shouye_arrow_icon"];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
        
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat timeLabelX=17;
    CGFloat timeLabelY=15;
    CGFloat timeLabelW=200;
    CGFloat timeLabelH=20;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
//    CGFloat cardTypeX=timeLabelX+timeLabelW+30;
//    CGFloat cardTypeY=10;
//    CGFloat cardTypeW=200;
//    CGFloat cardTypeH=20;
//    self.cardType.frame=CGRectMake(cardTypeX, cardTypeY, cardTypeW, cardTypeH);
    
    CGFloat moneyLabelX=timeLabelX;
    CGFloat moneyLabelY=13+timeLabelH+6;
    CGFloat moneyLabelW=200;
    CGFloat moneyLabelH=20;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
    CGFloat accountLabelX=timeLabelX;
    CGFloat accountLabelY=moneyLabelY+moneyLabelH+6;
    CGFloat accountLabelW=200;
    CGFloat accountLabelH=20;
    self.accountLabel.frame=CGRectMake(accountLabelX, accountLabelY, accountLabelW, accountLabelH);

    self.rightImage.frame=CGRectMake(self.frame.size.width-6-10, (self.frame.size.height-11)/2, 6, 11);

}


@end
