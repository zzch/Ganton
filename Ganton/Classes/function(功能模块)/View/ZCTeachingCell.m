//
//  ZCTeachingCell.m
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCTeachingCell.h"
@interface ZCTeachingCell()
@property(nonatomic,weak)UIImageView *personImage;
@property(nonatomic,weak)UILabel *genderLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UIImageView *rightImage;
@property(nonatomic,weak)UILabel *moneyNameLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UILabel *fuhaoLabel;

@end
@implementation ZCTeachingCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCTeachingCell";
    ZCTeachingCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCTeachingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        UIImageView *personImage=[[UIImageView alloc] init];
        personImage.layer.cornerRadius=5;//设置圆角的半径为10
         personImage.layer.masksToBounds=YES;
        [self.contentView addSubview:personImage];
        self.personImage=personImage;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"教练昵称";
        nameLabel.font=[UIFont systemFontOfSize:18];
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.text=@"头衔";
        titleLabel.textColor=ZCColor(85, 85, 85);
        titleLabel.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        self.titleLabel=titleLabel;
        
//        UILabel *genderLabel=[[UILabel alloc] init];
//        genderLabel.text=@"性别";
//        [self.contentView addSubview:genderLabel];
//        self.genderLabel=genderLabel;
        
        
        
//        UIImageView *rightImage=[[UIImageView alloc] init];
//        rightImage.backgroundColor=[UIColor redColor];
//        [self.contentView addSubview:rightImage];
//        self.rightImage=rightImage;
        
        
        UILabel *moneyNameLabel=[[UILabel alloc] init];
        moneyNameLabel.text=@"课程起售价";
        moneyNameLabel.textAlignment=NSTextAlignmentRight;
        moneyNameLabel.font=[UIFont systemFontOfSize:14];
        moneyNameLabel.textColor=ZCColor(136, 136, 136);
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
        
        
        
    
    }
    return self;

}

-(void)setCoachModel:(ZCCoachModel *)coachModel
{
    _coachModel=coachModel;
    
    if ([ZCTool _valueOrNil:coachModel.portrait]==nil) {
        self.personImage.image=[UIImage imageNamed:@"shape-87"];
    }else{
    [self.personImage sd_setImageWithURL:[NSURL URLWithString:coachModel.portrait] placeholderImage:[UIImage imageNamed:@"shape-87"]];
    }
    self.nameLabel.text=[NSString stringWithFormat:@"%@",coachModel.name];
    self.titleLabel.text=[NSString stringWithFormat:@"%@",coachModel.title];
    //self.introductionLabel.text=[NSString stringWithFormat:@"%@",coachModel.title];
    //self.genderLabel.text=[NSString stringWithFormat:@"%@",coachModel.gender];
    
    self.moneyLabel.text=coachModel.starting_price;
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat personImageH=50;
    CGFloat personImageX=15;
    CGFloat personImageY=(self.frame.size.height-personImageH)/2;
    CGFloat personImageW=50;
    
    self.personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=25;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
//    CGFloat  genderLabelX=nameLabelX+nameLabelW+30;
//    CGFloat  genderLabelY=nameLabelY+10;
//    CGFloat  genderLabelW=40;
//    CGFloat  genderLabelH=30;
//    self.genderLabel.frame=CGRectMake(genderLabelX, genderLabelY, genderLabelW, genderLabelH);
//
//    
//    CGFloat rightImageW=15;
//    CGFloat rightImageH=15;
//    CGFloat rightImageX=SCREEN_WIDTH-rightImageW-15;
//    CGFloat rightImageY=(self.frame.size.height-rightImageH)/2;
//    self.rightImage.frame=CGRectMake(rightImageX, rightImageY, rightImageW, rightImageH);
    
    
    CGFloat moneyNameLabelY=personImageY;
    CGFloat moneyNameLabelW=200;
    CGFloat moneyNameLabelH=30;
    CGFloat moneyNameLabelX=self.frame.size.width-moneyNameLabelW-15;
    self.moneyNameLabel.frame=CGRectMake(moneyNameLabelX, moneyNameLabelY, moneyNameLabelW, moneyNameLabelH);
    
    
    CGFloat fuhaoLabelW=12;
    CGFloat fuhaoLabelH=7;
    CGFloat fuhaoLabelX=self.frame.size.width-[ZCTool getFrame:CGSizeMake(1000, 25) content:self.moneyLabel.text fontSize:[UIFont systemFontOfSize:22]].size.width+2-fuhaoLabelW-19;
    CGFloat fuhaoLabelY=moneyNameLabelY+moneyNameLabelH+5;
    self.fuhaoLabel.frame=CGRectMake(fuhaoLabelX, fuhaoLabelY, fuhaoLabelW, fuhaoLabelH);
    
    CGFloat moneyLabelX=fuhaoLabelX+fuhaoLabelW+1;
    CGFloat moneyLabelY=fuhaoLabelY-11;
    CGFloat moneyLabelW=[ZCTool getFrame:CGSizeMake(1000, 25) content:self.moneyLabel.text fontSize:[UIFont systemFontOfSize:22]].size.width+2;
    CGFloat moneyLabelH=25;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
