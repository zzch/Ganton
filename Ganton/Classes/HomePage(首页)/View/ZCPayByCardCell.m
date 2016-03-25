//
//  ZCPayByCardCell.m
//  Ganton
//
//  Created by hh on 16/3/21.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCPayByCardCell.h"
#import "ZCPayCardItemModel.h"
@interface ZCPayByCardCell()

@property(nonatomic,weak)UILabel *dayLabel;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UIView *typeView;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UIImageView *iconImage1;
@property(nonatomic,weak)UIImageView *iconImage2;
@property(nonatomic,weak)UIImageView *iconImage3;

@end
@implementation ZCPayByCardCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"ZCPayByCardCell";
    
    ZCPayByCardCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCPayByCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *dayLabel=[[UILabel alloc] init];
        dayLabel.font=[UIFont systemFontOfSize:15];
        dayLabel.textAlignment=NSTextAlignmentCenter;
        dayLabel.text=@"03-05";
        dayLabel.textColor=ZCColor(85, 85, 85);
        [self.contentView addSubview:dayLabel];
        self.dayLabel=dayLabel;
        
        UILabel *timeLabel=[[UILabel alloc] init];
        timeLabel.font=[UIFont systemFontOfSize:11];
        timeLabel.text=@"13:00";
        timeLabel.textAlignment=NSTextAlignmentCenter;
        timeLabel.textColor=ZCColor(148, 149, 151);
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UIView *typeView=[[UIView alloc] init];
        [self.contentView addSubview:typeView];
        self.typeView=typeView;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        [moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
       // moneyLabel.font=[UIFont systemFontOfSize:16];
        moneyLabel.text=@"+10000.00";
        moneyLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;

        UIImageView *iconImage1 =[[UIImageView alloc] init];
        [typeView addSubview:iconImage1];
        self.iconImage1=iconImage1;
        
        UIImageView *iconImage2 =[[UIImageView alloc] init];
        [typeView addSubview:iconImage2];
        self.iconImage2=iconImage2;
        
        UIImageView *iconImage3 =[[UIImageView alloc] init];
        [typeView addSubview:iconImage3];
        self.iconImage3=iconImage3;

    }
    return self;

}



-(void)setPayByCardModel:(ZCPayByCardModel *)payByCardModel
{
    _payByCardModel=payByCardModel;
    
    NSDate *dayDate=[NSDate dateWithTimeIntervalSince1970:payByCardModel.created_at];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"MM-dd";
    
    NSString *day=[dateFormatter stringFromDate:dayDate];
    dateFormatter.dateFormat=@"HH:mm";
    NSString *time=[dateFormatter stringFromDate:dayDate];
    self.dayLabel.text=day;
    self.timeLabel.text=time;
    
    
    if ([payByCardModel.type isEqualToString:@"income"]) {
        self.moneyLabel.text=[NSString stringWithFormat:@"+ %@",payByCardModel.amount];
    }else{
        self.moneyLabel.text=[NSString stringWithFormat:@"- %@",payByCardModel.amount];
    }

    
    
    self.iconImage1.image=nil;
    self.iconImage2.image=nil;
    self.iconImage3.image=nil;
    
    if ([payByCardModel.action isEqualToString:@"refund"]) {
        
        self.iconImage1.image=[UIImage imageNamed:@"tui"];
        
    }else if ([payByCardModel.action isEqualToString:@"charge"]){
        
       self.iconImage1.image=[UIImage imageNamed:@"sk_chongzhi"];
        
    }else if ([payByCardModel.action isEqualToString:@"consumption"]){
    
     
        
        for (int i=0; i<payByCardModel.items.count; i++) {
            
            ZCPayCardItemModel *model=payByCardModel.items[i] ;
            
            if (i==0) {
          
                [self switchImage:self.iconImage1 withType:model.type];
            }else if (i==1){
                
                //ZCPayCardItemModel *model=payByCardModel.items[i] ;
                [self switchImage:self.iconImage2 withType:model.type];
            
            }else if (i==2){
                //ZCPayCardItemModel *model=payByCardModel.items[i] ;
                [self switchImage:self.iconImage3 withType:model.type];
            }
        }
    
    }
    
}


//判断该显示什么图片
-(void)switchImage:(UIImageView *)iconImage withType:(NSString *)type
{
    if ([type isEqualToString:@"playing"]) {
        
        iconImage.image=[UIImage imageNamed:@"sk_dawei"];
        
    }else if ([type isEqualToString:@"provision"]){
        
        iconImage.image=[UIImage imageNamed:@"sk_canying"];
        
    }else if ([type isEqualToString:@"extra"]){
        
        iconImage.image=[UIImage imageNamed:@"sk_qita"];
    }

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    

    CGFloat dayLabelX=10;
    CGFloat dayLabelY=18;
    CGFloat dayLabelW=50;
    CGFloat dayLabelH=15;
    self.dayLabel.frame=CGRectMake(dayLabelX, dayLabelY, dayLabelW, dayLabelH);
    
    CGFloat timeLabelX=dayLabelX;
    CGFloat timeLabelY=dayLabelY+dayLabelH+5;
    CGFloat timeLabelW=dayLabelW;
    CGFloat timeLabelH=13;
    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);

    CGFloat typeViewX=dayLabelX+dayLabelW+5;
    CGFloat typeViewY=0;
    CGFloat typeViewW=150;
    CGFloat typeViewH=self.frame.size.height;
    self.typeView.frame=CGRectMake(typeViewX, typeViewY, typeViewW, typeViewH);
    
    
    CGFloat Y=(typeViewH-40)/2;
    self.iconImage1.frame=CGRectMake(0, Y, 40, 40);
    self.iconImage2.frame=CGRectMake(50, Y, 40, 40);
    self.iconImage3.frame=CGRectMake(100, Y, 40, 40);
    
    
    
    
    
    CGFloat moneyLabelX=self.frame.size.width-110;
    CGFloat moneyLabelY=(self.frame.size.height-20)/2;
    CGFloat moneyLabelW=100;
    CGFloat moneyLabelH=20;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
    
//    CGFloat actionLabelX=moneyLabelX;
//    CGFloat actionLabelY=moneyLabelY+moneyLabelH+5;
//    CGFloat actionLabelW=moneyLabelW;
//    CGFloat actionLabelH=15;
//    self.actionLabel.frame=CGRectMake(actionLabelX, actionLabelY, actionLabelW, actionLabelH);
}

@end
