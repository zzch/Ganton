//
//  ZCTeachingHeaderCell.m
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCTeachingHeaderCell.h"
@interface ZCTeachingHeaderCell()
@property(nonatomic,weak)UIImageView *personImage;
@property(nonatomic,weak)UILabel *genderLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UILabel *introductionLabel;
@property(nonatomic,weak)UIImageView *rightImage;

@property(nonatomic,weak)UILabel *moneyNameLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UILabel *fuhaoLabel;
@end
@implementation ZCTeachingHeaderCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCTeachingHeaderCell";
    ZCTeachingHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCTeachingHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *personImage=[[UIImageView alloc] init];
        personImage.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:personImage];
        personImage.layer.cornerRadius=5;//设置圆角的半径为10
        personImage.layer.masksToBounds=YES;
        self.personImage=personImage;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"白珊珊";
        nameLabel.font=[UIFont systemFontOfSize:18];
        
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.text=@"总教练";
        titleLabel.textColor=ZCColor(85, 85, 85);
        titleLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        self.titleLabel=titleLabel;
        
        
        UILabel *introductionLabel=[[UILabel alloc] init];
        introductionLabel.text=@"介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介";
        introductionLabel.numberOfLines=0;
        introductionLabel.font=[UIFont systemFontOfSize:12];
        introductionLabel.textColor=ZCColor(136, 136, 136);
        [self.contentView addSubview:introductionLabel];
        self.introductionLabel=introductionLabel;
        
//        UILabel *genderLabel=[[UILabel alloc] init];
//        genderLabel.text=@"性别";
//        [self.contentView addSubview:genderLabel];
//        self.genderLabel=genderLabel;

        UILabel *moneyNameLabel=[[UILabel alloc] init];
        moneyNameLabel.text=@"课程起售价";
        moneyNameLabel.textAlignment=NSTextAlignmentRight;
        moneyNameLabel.textColor=ZCColor(136, 136, 136);
        moneyNameLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:moneyNameLabel];
        self.moneyNameLabel=moneyNameLabel;
        
        UILabel *fuhaoLabel=[[UILabel alloc] init];
        fuhaoLabel.text=@"￥";
        fuhaoLabel.textColor=[UIColor redColor];
        fuhaoLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:fuhaoLabel];
        self.fuhaoLabel=fuhaoLabel;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        moneyLabel.text=@"10000";
        [self.contentView addSubview:moneyLabel];
        moneyLabel.font=[UIFont systemFontOfSize:22];
        moneyLabel.textColor=[UIColor redColor];
        
        self.moneyLabel=moneyLabel;
        
        
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.image=[UIImage imageNamed:@"shouye_arrow_icon"];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
        
        
        
        
    }
    return self;

}


-(void)setCoachModel:(ZCCoachModel *)coachModel
{
    _coachModel=coachModel;
    
    //[self.personImage sd_setImageWithURL:[NSURL URLWithString:coachModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
    
    
    if ([ZCTool _valueOrNil:coachModel.portrait]==nil) {
        self.personImage.image=[UIImage imageNamed:@"shape-87"];
    }else{
        [self.personImage sd_setImageWithURL:[NSURL URLWithString:coachModel.portrait] placeholderImage:[UIImage imageNamed:@"shape-87"]];
    }
    
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",coachModel.name];
    self.titleLabel.text=[NSString stringWithFormat:@"%@",coachModel.title];
    self.introductionLabel.text=[NSString stringWithFormat:@"%@",coachModel.Description];
    //self.genderLabel.text=[NSString stringWithFormat:@"%@",coachModel.gender];
    self.moneyLabel.text=coachModel.starting_price;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat personImageH=104;
    CGFloat personImageX=15;
    CGFloat personImageY=(self.frame.size.height-personImageH)/2;
    CGFloat personImageW=75;
    self.personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=self.frame.size.width-[ZCTool getFrame:CGSizeMake(1000, 25) content:self.moneyLabel.text fontSize:[UIFont systemFontOfSize:22]].size.width-12-20-nameLabelX;
    CGFloat nameLabelH=25;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat introductionLabelX=nameLabelX;
    CGFloat introductionLabelY=titleLabelY+titleLabelH+5;
    CGFloat introductionLabelW=self.frame.size.width-introductionLabelX-20;
    CGFloat introductionLabelH=self.frame.size.height-introductionLabelY-10;
    self.introductionLabel.frame=CGRectMake(introductionLabelX, introductionLabelY, introductionLabelW, introductionLabelH);
    
//    CGFloat  genderLabelX=titleLabelX+titleLabelW+30;
//    CGFloat  genderLabelY=nameLabelY+10;
//    CGFloat  genderLabelW=40;
//    CGFloat  genderLabelH=30;
//    self.genderLabel.frame=CGRectMake(genderLabelX, genderLabelY, genderLabelW, genderLabelH);

    
    CGFloat moneyNameLabelY=nameLabelY;
    CGFloat moneyNameLabelW=200;
    CGFloat moneyNameLabelH=25;
    CGFloat moneyNameLabelX=self.frame.size.width-moneyNameLabelW-20;
    self.moneyNameLabel.frame=CGRectMake(moneyNameLabelX, moneyNameLabelY, moneyNameLabelW, moneyNameLabelH);
    
    
    CGFloat fuhaoLabelW=12;
    CGFloat fuhaoLabelH=7;
    CGFloat fuhaoLabelX=self.frame.size.width-[ZCTool getFrame:CGSizeMake(1000, 25) content:self.moneyLabel.text fontSize:[UIFont systemFontOfSize:22]].size.width-fuhaoLabelW-20;
    CGFloat fuhaoLabelY=moneyNameLabelY+moneyNameLabelH+7;
    self.fuhaoLabel.frame=CGRectMake(fuhaoLabelX, fuhaoLabelY, fuhaoLabelW, fuhaoLabelH);
    
    CGFloat moneyLabelX=fuhaoLabelX+fuhaoLabelW+1;
    CGFloat moneyLabelY=fuhaoLabelY-11;
    CGFloat moneyLabelW=[ZCTool getFrame:CGSizeMake(1000, 25) content:self.moneyLabel.text fontSize:[UIFont systemFontOfSize:22]].size.width;
    CGFloat moneyLabelH=25;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
    

   // self.rightImage.frame=CGRectMake(self.frame.size.width-6-10, (self.frame.size.height-11)/2, 6, 11);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
