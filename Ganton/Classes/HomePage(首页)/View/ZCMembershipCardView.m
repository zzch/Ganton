//
//  ZCMembershipCardView.m
//  Ganton
//
//  Created by hh on 16/3/16.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCMembershipCardView.h"
@interface ZCMembershipCardView()
@property(nonatomic,weak)UIImageView *bjLogoImage;
@property(nonatomic,weak)UIImageView *logoImage;
@property(nonatomic,weak)UILabel *cardName;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UILabel *fhLabel;
@property(nonatomic,weak)UILabel *moneyNumber;
@property(nonatomic,weak)UILabel *numberLabel;
@property(nonatomic,weak)UILabel *periodLabel;

@end
@implementation ZCMembershipCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
       
        [self setBackgroundImage: [UIImage imageNamed:@"sy_kamian_bj_02"] forState:UIControlStateNormal];
        
        [self setBackgroundImage: [UIImage imageNamed:@"sy_kamian_bj_02"] forState:UIControlStateHighlighted];
        
        //self.backgroundColor=[UIColor colorWithPatternImage:[ZCTool imagePullLitre:@"sy_kamian_bj_02"]];
        
        UIImageView *bjLogoImage=[[UIImageView alloc] init];
        bjLogoImage.image=[UIImage imageNamed:@"bjlogoimage"];
        [self addSubview:bjLogoImage];
        self.bjLogoImage=bjLogoImage;
        
        UIImageView *logoImage=[[UIImageView alloc] init];
        [bjLogoImage addSubview:logoImage];
        self.logoImage=logoImage;
        
        UILabel *cardName=[[UILabel alloc] init];
        cardName.text=@"360000贵宾卡贵宾卡";
        cardName.font=[UIFont systemFontOfSize:16];
        cardName.textAlignment=NSTextAlignmentCenter;
        cardName.textColor=[UIColor whiteColor];
        cardName.numberOfLines=0;
        [self addSubview:cardName];
        self.cardName=cardName;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        moneyLabel.text=@"储值余额";
        moneyLabel.font=[UIFont systemFontOfSize:12];
        moneyLabel.textColor=[UIColor whiteColor];
        moneyLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;
        
//        UILabel *fhLabel=[[UILabel alloc] init];
//        fhLabel.text=@"¥";
//        fhLabel.textColor=[UIColor whiteColor];
//        fhLabel.font=[UIFont systemFontOfSize:14];
//        [self addSubview:fhLabel];
//        self.fhLabel=fhLabel;
        
        UILabel *moneyNumber=[[UILabel alloc] init];
        moneyNumber.font=[UIFont systemFontOfSize:25];
        moneyNumber.textColor=[UIColor whiteColor];
        moneyNumber.textAlignment=NSTextAlignmentCenter;
        moneyNumber.text=@"200000";
        [self addSubview:moneyNumber];
        self.moneyNumber=moneyNumber;
        
        //卡号
        UILabel *numberLabel=[[UILabel alloc] init];
        numberLabel.text=@"卡号: 12213123";
        numberLabel.font=[UIFont systemFontOfSize:10 ];
        numberLabel.textColor=[ZCTool colorWithHexString:@"#b5b5b5"];
        [self addSubview:numberLabel];
        self.numberLabel=numberLabel;
        
        
        //有效期 expired_at
        UILabel *periodLabel=[[UILabel alloc] init];
        periodLabel.textColor=[ZCTool colorWithHexString:@"#b5b5b5"];
        periodLabel.text=@"有效期:2017.01.21";
        periodLabel.font=[UIFont systemFontOfSize:10];
        periodLabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:periodLabel];
        self.periodLabel=periodLabel;
        
    }
    return self;
}


-(void)setMemberModel:(ZCMemberModel *)memberModel andHomeModel:(ZCHomeModel *)homeModel
{
    
    
    if ([ZCTool _valueOrNil:homeModel.logo]==nil) {
        
    }else{
        
        [self.logoImage sd_setImageWithURL:[NSURL URLWithString:homeModel.logo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            CGFloat logoImageX;
            CGFloat logoImageY;
            CGFloat logoImageW;
            CGFloat logoImageH;
            if (image.size.width > image.size.height) {
                logoImageW=50;
                logoImageH=image.size.height*(50/image.size.width);
                logoImageX=50-(logoImageW/2)-10;
                logoImageY=46-(logoImageH/2)-5;
                
            }else{
            
                logoImageW=image.size.width*(50/image.size.height);
                logoImageH=50;
                logoImageX=50-(logoImageW/2)-10;
                logoImageY=46-(logoImageH/2)-5;
            }
            
           
            
            self.logoImage.frame=CGRectMake(logoImageX, logoImageY, logoImageW, logoImageH);
            
        }];
        
    }

    
    self.cardName.text=memberModel.name;
    self.moneyNumber.text=[NSString stringWithFormat:@"%@",memberModel.balance];
    self.numberLabel.text=[NSString stringWithFormat:@"卡号: %@",memberModel.number];
    
    
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:memberModel.expired_at];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
    
    self.periodLabel.text=[NSString stringWithFormat:@"有效期至: %@",nowDateString ];
    
    
    

}





-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat bjLogoImageX=40;
    CGFloat bjLogoImageH=93;
    CGFloat bjLogoImageY=(self.frame.size.height-bjLogoImageH)/2;
    CGFloat bjLogoImageW=99;
    
    self.bjLogoImage.frame=CGRectMake(bjLogoImageX, bjLogoImageY, bjLogoImageW, bjLogoImageH);
    
    CGFloat cardNameX=bjLogoImageX+bjLogoImageW+10;
    CGFloat cardNameY=32;
    CGFloat cardNameW=self.frame.size.width-cardNameX-10;
    CGFloat cardNameH=[ZCTool getFrame:CGSizeMake(cardNameW, 250) content:self.cardName.text fontSize:[UIFont systemFontOfSize:16]].size.height;
    
    self.cardName.frame=CGRectMake(cardNameX, cardNameY, cardNameW, cardNameH);
    
    CGFloat moneyLabelX=bjLogoImageX+bjLogoImageW+10;
    CGFloat moneyLabelY=cardNameY+cardNameH+25;
    CGFloat moneyLabelW=self.frame.size.width-moneyLabelX-10;
    CGFloat moneyLabelH=15;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
//    CGFloat moneyNumberW=[ZCTool getFrame:CGSizeMake(500, 25) content:self.moneyNumber.text fontSize:[UIFont systemFontOfSize:25]].size.width;
//    
//    
//    CGFloat fhLabelW=[ZCTool getFrame:CGSizeMake(30, 10) content:@"¥" fontSize:[UIFont systemFontOfSize:14]].size.width;
//    CGFloat fhLabelH=12;
//    CGFloat fhLabelX=(moneyLabelW-fhLabelW-moneyNumberW)/2+moneyLabelX;
//    CGFloat fhLabelY=moneyLabelY+moneyLabelH+12+5;
//
//    self.fhLabel.frame=CGRectMake(fhLabelX, fhLabelY, fhLabelW, fhLabelH);
    
    
    CGFloat moneyNumberX=moneyLabelX;
    CGFloat moneyNumberY=moneyLabelY+moneyLabelH+12;
    CGFloat moneyNumberW=moneyLabelW;
    CGFloat moneyNumberH=20;
    self.moneyNumber.frame=CGRectMake(moneyNumberX, moneyNumberY, moneyNumberW, moneyNumberH);
    
    
    CGFloat numberLabelX=10;
    CGFloat numberLabelY=self.frame.size.height-48;
    CGFloat numberLabelW=300;
    CGFloat numberLabelH=28;
    self.numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    
    
    CGFloat periodLabelX=self.frame.size.width-160;
    CGFloat periodLabelY=self.frame.size.height-48;
    CGFloat periodLabelW=150;
    CGFloat periodLabelH=28;
    self.periodLabel.frame=CGRectMake(periodLabelX, periodLabelY, periodLabelW, periodLabelH);
    

}

@end
