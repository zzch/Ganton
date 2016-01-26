//
//  ZCAllConsumptionCell.m
//  Ganton
//
//  Created by hh on 15/11/17.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAllConsumptionCell.h"
@interface ZCAllConsumptionCell()
@property(nonatomic,weak)UIImageView *bjImageView;
@end
@implementation ZCAllConsumptionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor=[UIColor clearColor];
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        //[self addDetailControls:detailView];
        //
        //        for (int i=0; i<index; i++) {
        //            UILabel *label=[[UILabel alloc] init];
        //            label.frame=CGRectMake(115, 130+i*30, detailView.frame.size.width-130, 30);
        //            label.text=@"打位费：1000元";
        //            [detailView addSubview:label];
        //        }
        
        
        
        
        
        
        //        UILabel *cardType=[[UILabel alloc] init];
        //        cardType.text=@"储蓄卡";
        //        //cardType.backgroundColor=[UIColor brownColor];
        //        cardType.font=[UIFont systemFontOfSize:13];
        //        [self.contentView addSubview:cardType];
        //        self.cardType=cardType;
        
        //        UILabel *moneyLabel=[[UILabel alloc] init];
        //        moneyLabel.text=@"消费金额: ￥500";
        //        moneyLabel.font=[UIFont systemFontOfSize:13];
        //        [self.contentView addSubview:moneyLabel];
        //        self.moneyLabel=moneyLabel;
        //
        //        UILabel *accountLabel=[[UILabel alloc] init];
        //        accountLabel.text=@"消费账号: 王二蛋";
        //        accountLabel.font=[UIFont systemFontOfSize:13];
        //        [self.contentView addSubview:accountLabel];
        //        self.accountLabel=accountLabel;
        //
        //
        //        UIImageView *rightImage=[[UIImageView alloc] init];
        //        rightImage.image=[UIImage imageNamed:@"shouye_arrow_icon"];
        //        [self.contentView addSubview:rightImage];
        //        self.rightImage=rightImage;
        
    }
    return self;
}



-(void)setAllConsumptionModel:(ZCAllConsumptionModel *)allConsumptionModel
{
    _allConsumptionModel=allConsumptionModel;
    
    [self.bjImageView removeFromSuperview];
    
    
    [self addControls:allConsumptionModel];

}




-(void)addControls:(ZCAllConsumptionModel *)allConsumptionModel
{
    
    UIImageView *bjImageView=[[UIImageView alloc] init];
    CGFloat bjImageViewX=10;
    CGFloat bjImageViewY=10;
    CGFloat bjImageViewW=SCREEN_WIDTH-2*bjImageViewX;
    
    
    bjImageView.image=[ZCTool imagePullLitre:@"xiaofeixinxi_bj"];
    [self.contentView addSubview:bjImageView];
    self.bjImageView=bjImageView;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=10;
    CGFloat nameLabelY=10;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=15;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=@"消费单号";
    nameLabel.font=[UIFont systemFontOfSize:12];
    nameLabel.textColor=ZCColor(85, 85, 85);
    [bjImageView addSubview:nameLabel];
    
    //消费单号
    UILabel *sequenceLabel=[[UILabel alloc] init];
    CGFloat sequenceLabelX=nameLabelX;
    CGFloat sequenceLabelY=nameLabelY+nameLabelH+1;
    CGFloat sequenceLabelW=150;
    CGFloat sequenceLabelH=15;
    sequenceLabel.frame=CGRectMake(sequenceLabelX, sequenceLabelY, sequenceLabelW, sequenceLabelH);
    sequenceLabel.font=[UIFont systemFontOfSize:12];
    sequenceLabel.textColor=ZCColor(34, 34, 34);
    sequenceLabel.text=allConsumptionModel.sequence;
    [bjImageView addSubview:sequenceLabel];
    
    UILabel *nameLabel2=[[UILabel alloc] init];
    CGFloat nameLabel2W=100;
    CGFloat nameLabel2H=15;
    CGFloat nameLabel2X=bjImageViewW-nameLabel2W-10;
    CGFloat nameLabel2Y=10;
    nameLabel2.frame=CGRectMake(nameLabel2X, nameLabel2Y, nameLabel2W, nameLabel2H);
    nameLabel2.text=@"前台支付";
    nameLabel2.textAlignment=NSTextAlignmentRight;
    nameLabel2.textColor=ZCColor(85, 85, 85);
    nameLabel2.font=[UIFont systemFontOfSize:12];
    [bjImageView addSubview:nameLabel2];
    
    //前台支付
    UILabel *receptionPaymentLabel=[[UILabel alloc] init];
    CGFloat receptionPaymentLabelW=100;
    CGFloat receptionPaymentLabelH=20;
    CGFloat receptionPaymentLabelX=bjImageViewW-receptionPaymentLabelW-10;
    CGFloat receptionPaymentLabelY=nameLabel2Y+nameLabel2H+1;
    receptionPaymentLabel.frame=CGRectMake(receptionPaymentLabelX, receptionPaymentLabelY, receptionPaymentLabelW, receptionPaymentLabelH);
    receptionPaymentLabel.font=[UIFont systemFontOfSize:15];
    receptionPaymentLabel.text=allConsumptionModel.reception_payment;
    receptionPaymentLabel.textAlignment=NSTextAlignmentRight;
    receptionPaymentLabel.textColor=ZCColor(248, 87, 34);
    [bjImageView addSubview:receptionPaymentLabel];
    
    
    UIImageView *timeImage=[[UIImageView alloc] init];
    CGFloat timeImageX=10;
    CGFloat timeImageY=sequenceLabelY+sequenceLabelH+15;
    CGFloat timeImageW=11;
    CGFloat timeImageH=13;
    timeImage.frame=CGRectMake(timeImageX, timeImageY, timeImageW, timeImageH);
    timeImage.image=[UIImage imageNamed:@"xiaofeixinxi_xuanx"];
    [bjImageView addSubview:timeImage];
    
    UILabel *timeNameLabel=[[UILabel alloc] init];
    CGFloat timeNameLabelX=timeImageX+timeImageW+5;
    CGFloat timeNameLabelY=timeImageY;
    CGFloat timeNameLabelW=100;
    CGFloat timeNameLabelH=13;
    timeNameLabel.frame=CGRectMake(timeNameLabelX, timeNameLabelY, timeNameLabelW, timeNameLabelH);
    timeNameLabel.text=@"消费时间";
    timeNameLabel.textColor=ZCColor(248, 87, 34);
    timeNameLabel.font=[UIFont systemFontOfSize:15];
    [bjImageView addSubview:timeNameLabel];
    
    
    UIView *bjX1=[[UIView alloc] init];
    CGFloat bjX1Y=timeNameLabelY+timeNameLabelH+7;
    CGFloat bjX1W=bjImageViewW-20;
    bjX1.frame=CGRectMake(10, bjX1Y, bjX1W, 1);
    bjX1.backgroundColor=ZCColor(248, 87, 34);
    [bjImageView addSubview:bjX1];
    
    UILabel *timeLabel=[[UILabel alloc] init];
    CGFloat timeLabelX=timeNameLabelX;
    CGFloat timeLabelY=bjX1Y+7;
    CGFloat timeLabelW=bjImageViewW-timeLabelX;
    CGFloat timeLabelH=20;
    timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    timeLabel.font=[UIFont systemFontOfSize:14];
    timeLabel.textColor=ZCColor(34, 34, 34);
    [bjImageView addSubview:timeLabel];
    //self.timeLabel=timeLabel;
    
    NSDate *entranceDate=[NSDate dateWithTimeIntervalSince1970:allConsumptionModel.entrance_time];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"MM月dd日";
    NSString *selfStr = [dateFormatter stringFromDate:entranceDate];
    
    dateFormatter.dateFormat = @"HH: dd";
    NSString *entranceStr = [dateFormatter stringFromDate:entranceDate];
    NSString *departureStr;
    if (allConsumptionModel.departure_time==0) {
        departureStr=@"";
    }else{
    NSDate *departureDate=[NSDate dateWithTimeIntervalSince1970:allConsumptionModel.departure_time];
    departureStr = [dateFormatter stringFromDate:departureDate];
    }
    NSString *str=[NSString stringWithFormat:@"%@ %@ - %@",selfStr,entranceStr,departureStr];
    
    timeLabel.text=str;
    
    
    
    UIImageView *nameImage=[[UIImageView alloc] init];
    CGFloat nameImageX=10;
    CGFloat nameImageY=timeLabelY+timeLabelH+10;
    CGFloat nameImageW=11;
    CGFloat nameImageH=13;
    nameImage.frame=CGRectMake(nameImageX, nameImageY, nameImageW, nameImageH);
    nameImage.image=[UIImage imageNamed:@"xiaofeixinxi_xuanx"];
    [bjImageView addSubview:nameImage];

    
    UILabel *stadiumNameLabel=[[UILabel alloc] init];
    CGFloat stadiumNameLabelX=nameImageX+nameImageW+5;
    CGFloat stadiumNameLabelY=nameImageY;
    CGFloat stadiumNameLabelW=100;
    CGFloat stadiumNameLabelH=13;
    stadiumNameLabel.frame=CGRectMake(stadiumNameLabelX, stadiumNameLabelY, stadiumNameLabelW, stadiumNameLabelH);
    stadiumNameLabel.text=@"消费球场";
    stadiumNameLabel.font=[UIFont systemFontOfSize:15];
    stadiumNameLabel.textColor=ZCColor(248, 87, 34);
    [bjImageView addSubview:stadiumNameLabel];

    UIView *bjX12=[[UIView alloc] init];
    CGFloat bjX12Y=stadiumNameLabelY+stadiumNameLabelH+8;
    CGFloat bjX12W=bjImageViewW-20;
    bjX12.frame=CGRectMake(10, bjX12Y, bjX12W, 1);
    bjX12.backgroundColor=ZCColor(248, 87, 34);
    [bjImageView addSubview:bjX12];
    
    
    UILabel *stadiumLabel=[[UILabel alloc] init];
    CGFloat stadiumLabelX=stadiumNameLabelX;
    CGFloat stadiumLabelY=bjX12Y+7;
    CGFloat stadiumLabelW=bjImageViewW-stadiumLabelX;
    CGFloat stadiumLabelH=20;
    stadiumLabel.frame=CGRectMake(stadiumLabelX, stadiumLabelY, stadiumLabelW, stadiumLabelH);
    stadiumLabel.font=[UIFont systemFontOfSize:14];
    stadiumLabel.textColor=ZCColor(34, 34, 34);
    stadiumLabel.text=allConsumptionModel.name;
    [bjImageView addSubview:stadiumLabel];

    
    
    
    
    
    UIImageView *detailImage=[[UIImageView alloc] init];
    CGFloat detailImageX=10;
    CGFloat detailImageY=stadiumLabelY+stadiumLabelH+10;
    CGFloat detailImageW=11;
    CGFloat detailImageH=13;
    detailImage.frame=CGRectMake(detailImageX, detailImageY, detailImageW, detailImageH);
    detailImage.image=[UIImage imageNamed:@"xiaofeixinxi_xuanx"];
    [bjImageView addSubview:detailImage];
    
    
    UILabel *detailNameLabel=[[UILabel alloc] init];
    CGFloat detailNameLabelX=detailImageX+detailImageW+5;
    CGFloat detailNameLabelY=detailImageY;
    CGFloat detailNameLabelW=100;
    CGFloat detailNameLabelH=13;
    detailNameLabel.frame=CGRectMake(detailNameLabelX, detailNameLabelY, detailNameLabelW, detailNameLabelH);
    detailNameLabel.text=@"消费明细";
    detailNameLabel.font=[UIFont systemFontOfSize:15];
    detailNameLabel.textColor=ZCColor(248, 87, 34);
    [bjImageView addSubview:detailNameLabel];
    
    UIView *bjX2=[[UIView alloc] init];
    CGFloat bjX2Y=detailNameLabelY+detailNameLabelH+8;
    CGFloat bjX2W=bjImageViewW-20;
    bjX2.frame=CGRectMake(10, bjX2Y, bjX2W, 1);
    bjX2.backgroundColor=ZCColor(248, 87, 34);
    [bjImageView addSubview:bjX2];
    
    
    UILabel *detailLabel1=[[UILabel alloc] init];
    CGFloat detailLabel1X=20;
    CGFloat detailLabel1Y=bjX2Y+1;
    CGFloat detailLabel1W=80;
    CGFloat detailLabel1H=35;
    detailLabel1.frame=CGRectMake(detailLabel1X, detailLabel1Y, detailLabel1W, detailLabel1H);
    detailLabel1.text=@"消费内容";
    detailLabel1.font=[UIFont systemFontOfSize:14];
    detailLabel1.textColor=ZCColor(34, 34, 34);
    [bjImageView addSubview:detailLabel1];
   // self.detailLabel1=detailLabel1;
    
    UILabel *detailLabel2=[[UILabel alloc] init];
    CGFloat detailLabel2W=100;
    CGFloat detailLabel2X=(bjImageViewW-detailLabel2W)/2;
    CGFloat detailLabel2Y=bjX2Y+1;
    CGFloat detailLabel2H=35;
    detailLabel2.frame=CGRectMake(detailLabel2X, detailLabel2Y, detailLabel2W, detailLabel2H);
    detailLabel2.text=@"小计";
    detailLabel2.font=[UIFont systemFontOfSize:14];
    detailLabel2.textColor=ZCColor(34, 34, 34);
    detailLabel2.textAlignment=NSTextAlignmentCenter;
    [bjImageView addSubview:detailLabel2];
    
    
    UILabel *detailLabel3=[[UILabel alloc] init];
    CGFloat detailLabel3W=80;
    CGFloat detailLabel3X=bjImageViewW-detailLabel3W;
    CGFloat detailLabel3Y=bjX2Y+1;
    CGFloat detailLabel3H=35;
    detailLabel3.frame=CGRectMake(detailLabel3X, detailLabel3Y, detailLabel3W, detailLabel3H);
    detailLabel3.text=@"付款方式";
    detailLabel3.textColor=ZCColor(34, 34, 34);
    detailLabel3.font=[UIFont systemFontOfSize:14];
    [bjImageView addSubview:detailLabel3];
    
    //detailLabel3.backgroundColor=[UIColor redColor];
    
    
    UIView *detailView=[[UIView alloc] init];
    //detailView.backgroundColor=[UIColor redColor];
    
    //self.detailView=detailView;
    
    CGFloat detailViewY=detailLabel1.frame.size.height+detailLabel1.frame.origin.y+1;
    CGFloat detailViewW=self.bjImageView.frame.size.width;
    CGFloat detailViewH=allConsumptionModel.items.count*30;
    detailView.frame=CGRectMake(0, detailViewY, detailViewW, detailViewH);
    [self.bjImageView addSubview:detailView];
    
//    CGFloat bjImageViewH=detailViewY+detailViewH+20;
//    self.bjImageView.frame=CGRectMake(10, 10, SCREEN_WIDTH-2*10, bjImageViewH);
    
    
    
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewX=0;
    CGFloat imageViewY=detailViewY+detailViewH+15;
    CGFloat imageViewW=bjImageViewW;
    CGFloat imageViewH=53;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    //label.backgroundColor=[UIColor colorWithPatternImage:[ZCTool imagePullLitre:@"xfjl_anniu"]];
    imageView.image=[ZCTool imagePullLitre:@"xfjl_anniu"];
    [bjImageView addSubview:imageView];
    
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.frame=CGRectMake(0, 0, imageViewW, imageViewH);
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.textColor=[UIColor whiteColor];
    [imageView addSubview:textLabel];
    
    if ([allConsumptionModel.state isEqual:@"progressing"]) {
        textLabel.text=@"进行中";
    }else if ([allConsumptionModel.state isEqual:@"cancelled"]){
        textLabel.text=@"已取消";
    }else if ([allConsumptionModel.state isEqual:@"finished"]){
        textLabel.text=@"已完成";
    }else if ([allConsumptionModel.state isEqual:@"confirming"]){
        textLabel.text=@"等待确认";
    }
    
    
    CGFloat bjImageViewH=imageViewY+imageViewH-2;
    self.bjImageView.frame=CGRectMake(10, 10, SCREEN_WIDTH-2*10, bjImageViewH);
    self.cellHight=bjImageViewH+10;

    
    
    for (int i=0; i<allConsumptionModel.items.count; i++) {
        UIView *view=[[UIView alloc] init];
        view.frame=CGRectMake(0, i*30, self.bjImageView.frame.size.width, 30);
        
        [self addDetailControls:view andItem:allConsumptionModel.items[i]];
        [detailView addSubview:view];
    }
    
    
    
    
   // self.cellHight=bjImageViewH+5;
}




//添加消费明细上的控件
-(void)addDetailControls:(UIView *)view andItem:(ZCConsumptionDetailModel *)consumptionDetailModel
{
    UIImageView *xianImage=[[UIImageView alloc] init];
    xianImage.frame=CGRectMake(20, 0, view.frame.size.width-20-10, 1);
    xianImage.image=[ZCTool imagePullLitre:@"xuxian"];
    [view addSubview:xianImage];
    
    UILabel *label1=[[UILabel alloc] init];
    CGFloat label1X=20;
    CGFloat label1Y=1;
    CGFloat label1W=80;
    CGFloat label1H=35;
    label1.frame=CGRectMake(label1X, label1Y, label1W, label1H);
    
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=ZCColor(85, 85, 85);
    [view addSubview:label1];
    
    if ([consumptionDetailModel.name isEqual:@"club_rental"]) {
        label1.text=@"租杆费";
    }else if ([consumptionDetailModel.name isEqual:@"locker"]){
        label1.text=@"存包费";
    }else if ([consumptionDetailModel.name isEqual:@"other"]){
        label1.text=@"其他";
    }else{
        label1.text=consumptionDetailModel.name;
    }
    
    
    
    UILabel *label2=[[UILabel alloc] init];
    CGFloat label2W=100;
    CGFloat label2X=(self.bjImageView.frame.size.width-label2W)/2;
    CGFloat label2Y=1;
    CGFloat label2H=35;
    label2.frame=CGRectMake(label2X, label2Y, label2W, label2H);
    label2.text=consumptionDetailModel.total_price;
    label2.font=[UIFont systemFontOfSize:14];
    label2.textColor=ZCColor(85, 85, 85);
    label2.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label2];
    
    
    UILabel *label3=[[UILabel alloc] init];
    CGFloat label3W=80;
    CGFloat label3X=self.bjImageView.frame.size.width-label3W;
    CGFloat label3Y=1;
    CGFloat label3H=30;
    label3.frame=CGRectMake(label3X, label3Y, label3W, label3H);
    label3.text=consumptionDetailModel.payment_method;;
    label3.font=[UIFont systemFontOfSize:14];
    label3.textColor=ZCColor(85, 85, 85);
    [view addSubview:label3];
    
    if ([consumptionDetailModel.payment_method isEqual:@"by_ball_member"]) {
        label3.text=@"记球卡";
    }else if ([consumptionDetailModel.payment_method isEqual:@"by_time_member"]){
        label3.text=@"计时卡";
    }else if ([consumptionDetailModel.payment_method isEqual:@"unlimited_member"]){
        label3.text=@"畅打卡";
    }else if ([consumptionDetailModel.payment_method isEqual:@"stored_member"]){
        label3.text=@"储值卡";
    }else if ([consumptionDetailModel.payment_method isEqual:@"credit_card"]){
        label3.text=@"信用卡";
    }else if ([consumptionDetailModel.payment_method isEqual:@"cash"]){
        label3.text=@"现金";
    }else if ([consumptionDetailModel.payment_method isEqual:@"check"]){
        label3.text=@"支票";
    }else if ([consumptionDetailModel.payment_method isEqual:@"on_account"]){
        label3.text=@"挂账";
    }else if ([consumptionDetailModel.payment_method isEqual:@"signing"]){
        label3.text=@"签单";
    }else if ([consumptionDetailModel.payment_method isEqual:@"coupon"]){
        label3.text=@"抵用卷";
    }
    
    
    
}

@end
