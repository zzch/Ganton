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
        self.personImage=personImage;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"白珊珊";
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.text=@"总教练";
        [self.contentView addSubview:titleLabel];
        self.titleLabel=titleLabel;
        
        
        UILabel *introductionLabel=[[UILabel alloc] init];
        introductionLabel.text=@"介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介介绍简介";
        introductionLabel.numberOfLines=0;
        [self.contentView addSubview:introductionLabel];
        self.introductionLabel=introductionLabel;
        
        UILabel *genderLabel=[[UILabel alloc] init];
        genderLabel.text=@"性别";
        [self.contentView addSubview:genderLabel];
        self.genderLabel=genderLabel;

        
    }
    return self;

}


-(void)setCoachModel:(ZCCoachModel *)coachModel
{
    _coachModel=coachModel;
    
    //[self.personImage sd_setImageWithURL:[NSURL URLWithString:coachModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",coachModel.name];
    self.titleLabel.text=[NSString stringWithFormat:@"%@",coachModel.title];
    //self.introductionLabel.text=[NSString stringWithFormat:@"%@",coachModel.title];
    self.genderLabel.text=[NSString stringWithFormat:@"%@",coachModel.gender];

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat personImageX=10;
    CGFloat personImageY=10;
    CGFloat personImageW=50;
    CGFloat personImageH=self.frame.size.height-20;
    self.personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=30;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat titleLabelX=nameLabelX+nameLabelW+10;
    CGFloat titleLabelY=nameLabelY;
    CGFloat titleLabelW=50;
    CGFloat titleLabelH=30;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat introductionLabelX=nameLabelX;
    CGFloat introductionLabelY=nameLabelY+nameLabelH;
    CGFloat introductionLabelW=300;
    CGFloat introductionLabelH=90;
    self.introductionLabel.frame=CGRectMake(introductionLabelX, introductionLabelY, introductionLabelW, introductionLabelH);
    
    CGFloat  genderLabelX=titleLabelX+titleLabelW+30;
    CGFloat  genderLabelY=nameLabelY+10;
    CGFloat  genderLabelW=40;
    CGFloat  genderLabelH=30;
    self.genderLabel.frame=CGRectMake(genderLabelX, genderLabelY, genderLabelW, genderLabelH);


}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
