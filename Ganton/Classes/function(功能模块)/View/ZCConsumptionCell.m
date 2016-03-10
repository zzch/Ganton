//
//  ZCConsumptionCell.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//消费记录

#import "ZCConsumptionCell.h"
#import "ZCConsumptionDetailModel.h"
@interface ZCConsumptionCell()<UIAlertViewDelegate>
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UILabel *cardType;
@property(nonatomic,weak)UILabel *detailLabel1;
@property(nonatomic,weak)UIImageView *bjImageView;
@property(nonatomic,strong)UIView *detailView;
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




-(void)setRecordsOfConsumptionModel:(ZCRecordsOfConsumptionModel *)recordsOfConsumptionModel
{
    
    _recordsOfConsumptionModel=recordsOfConsumptionModel;
    
    
    [self.bjImageView removeFromSuperview];
    
    
    [self addControls:recordsOfConsumptionModel];
    
   
    
    
    
    

    
    
    
    
    
    
    
   // self.cellHight=bjImageViewH+5;
    

}


-(void)addControls:(ZCRecordsOfConsumptionModel *)recordsOfConsumptionModel
{
    
    UIImageView *bjImageView=[[UIImageView alloc] init];
    bjImageView.userInteractionEnabled=YES;
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
    sequenceLabel.text=recordsOfConsumptionModel.sequence;
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
    receptionPaymentLabel.text=recordsOfConsumptionModel.reception_payment;
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
    self.timeLabel=timeLabel;
    
    NSDate *entranceDate=[NSDate dateWithTimeIntervalSince1970:recordsOfConsumptionModel.entrance_time];
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"MM月dd日";
    NSString *selfStr = [dateFormatter stringFromDate:entranceDate];

    dateFormatter.dateFormat = @"HH: mm";
    NSString *entranceStr = [dateFormatter stringFromDate:entranceDate];
    
    
    
    NSString *departureStr;
    if (recordsOfConsumptionModel.departure_time==0) {
        departureStr=@"";
    }else{
    NSDate *departureDate=[NSDate dateWithTimeIntervalSince1970:recordsOfConsumptionModel.departure_time];
    departureStr = [dateFormatter stringFromDate:departureDate];
    }
    NSString *str=[NSString stringWithFormat:@"%@ %@ - %@",selfStr,entranceStr,departureStr];
    
    timeLabel.text=str;
    
    
    UIImageView *detailImage=[[UIImageView alloc] init];
    CGFloat detailImageX=10;
    CGFloat detailImageY=timeLabelY+timeLabelH+10;
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
    self.detailLabel1=detailLabel1;
    
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
    
    self.detailView=detailView;
    
    CGFloat detailViewY=self.detailLabel1.frame.size.height+self.detailLabel1.frame.origin.y+1;
    CGFloat detailViewW=self.bjImageView.frame.size.width;
    CGFloat detailViewH=recordsOfConsumptionModel.items.count*30;
    self.detailView.frame=CGRectMake(0, detailViewY, detailViewW, detailViewH);
    [self.bjImageView addSubview:detailView];
    
    
    
    
   
    
    if ([recordsOfConsumptionModel.state isEqual:@"confirming"]) {
        
        UIImageView *xianImage=[[UIImageView alloc] init];
        xianImage.frame=CGRectMake(20, detailViewY+detailViewH+5, bjImageViewW-20-10, 1);
        xianImage.image=[ZCTool imagePullLitre:@"xuxian"];
        [bjImageView addSubview:xianImage];
        
        
        UIButton *confirmBtn=[[UIButton alloc] init];
        
        CGFloat confirmBtnY=detailViewY+detailViewH+25;
        CGFloat confirmBtnW=100;
        CGFloat confirmBtnH=30;
        CGFloat confirmBtnX=(SCREEN_WIDTH-confirmBtnW)/2;
        confirmBtn.frame=CGRectMake(confirmBtnX, confirmBtnY, confirmBtnW, confirmBtnH);
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"xfjl_niu" ] forState:UIControlStateNormal];
        [confirmBtn setTitle:@"等待确认" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(clickTheConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        [bjImageView addSubview:confirmBtn];
        
        
        CGFloat bjImageViewH=confirmBtnY+confirmBtnH+20;
        self.bjImageView.frame=CGRectMake(10, 10, SCREEN_WIDTH-2*10, bjImageViewH);
        self.cellHight=bjImageViewH+5;

    }else
    {
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
        
        if ([recordsOfConsumptionModel.state isEqual:@"progressing"]) {
            textLabel.text=@"进行中";
        }else if ([recordsOfConsumptionModel.state isEqual:@"cancelled"]){
            textLabel.text=@"已取消";
        }else if ([recordsOfConsumptionModel.state isEqual:@"finished"]){
            textLabel.text=@"已完成";
        }
        
    
        CGFloat bjImageViewH=imageViewY+imageViewH-2;
        self.bjImageView.frame=CGRectMake(10, 10, SCREEN_WIDTH-2*10, bjImageViewH);
        self.cellHight=bjImageViewH+10;
    }
    
    
    
    for (int i=0; i<recordsOfConsumptionModel.items.count; i++) {
        UIView *view=[[UIView alloc] init];
        view.frame=CGRectMake(0, i*30, self.bjImageView.frame.size.width, 30);
        
        [self addDetailControls:view andItem:recordsOfConsumptionModel.items[i]];
        [self.detailView addSubview:view];
    }

    
}


//点击确认按钮
-(void)clickTheConfirmBtn
{
    // 弹框
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"您要确认该笔消费吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // 设置对话框的类型
    alert.alertViewStyle=UIKeyboardTypeNumberPad;
    
    [alert show];

}


#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        ZCLog(@"asdasda");
        //[self.navigationController popViewControllerAnimated:YES];
    }else
    {
        ZCLog(@"asdasda");
        [self confirmRequest];
    }

    // 按钮的索引肯定不是0

}


//确认消费
-(void)confirmRequest
{
    
    if ([self.delegete respondsToSelector:@selector(clickTheConfirmBtn:)]) {
        
        [self.delegete clickTheConfirmBtn:self.recordsOfConsumptionModel.uuid];
    }
    //[self.delegete clickTheConfirmBtn:self.recordsOfConsumptionModel.uuid];
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
    //label1.text=consumptionDetailModel.name;
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




//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    CGFloat timeLabelX=17;
//    CGFloat timeLabelY=15;
//    CGFloat timeLabelW=200;
//    CGFloat timeLabelH=20;
//    self.timeLabel.frame=CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
//    
////    CGFloat cardTypeX=timeLabelX+timeLabelW+30;
////    CGFloat cardTypeY=10;
////    CGFloat cardTypeW=200;
////    CGFloat cardTypeH=20;
////    self.cardType.frame=CGRectMake(cardTypeX, cardTypeY, cardTypeW, cardTypeH);
//    
//    CGFloat moneyLabelX=timeLabelX;
//    CGFloat moneyLabelY=13+timeLabelH+6;
//    CGFloat moneyLabelW=200;
//    CGFloat moneyLabelH=20;
//    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
//    
//    CGFloat accountLabelX=timeLabelX;
//    CGFloat accountLabelY=moneyLabelY+moneyLabelH+6;
//    CGFloat accountLabelW=200;
//    CGFloat accountLabelH=20;
//    self.accountLabel.frame=CGRectMake(accountLabelX, accountLabelY, accountLabelW, accountLabelH);
//
//    self.rightImage.frame=CGRectMake(self.frame.size.width-6-10, (self.frame.size.height-11)/2, 6, 11);
//
//}


@end
