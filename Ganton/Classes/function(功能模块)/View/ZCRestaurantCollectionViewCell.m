//
//  ZCRestaurantCollectionViewCell.m
//  Ganton
//
//  Created by hh on 15/10/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCRestaurantCollectionViewCell.h"
@interface ZCRestaurantCollectionViewCell()
@property(nonatomic,weak)UIView *view;
@property(nonatomic,weak)UIImageView *foodImage;
@property(nonatomic,weak)UIImageView *foodImage2;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@end
@implementation ZCRestaurantCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        //添加阴影效果
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 2;
        
        UIView *view=[[UIView alloc] init];
        view.backgroundColor=[UIColor whiteColor];
        view.layer.cornerRadius = 5;
        view.clipsToBounds= YES;
        [self.contentView addSubview:view];
        self.view=view;
        
        UIImageView *foodImage=[[UIImageView alloc] init];
        foodImage.backgroundColor=ZCColor(299, 299, 299);
        [view addSubview:foodImage];
        self.foodImage=foodImage;
        
        
//        UIImageView *foodImage2=[[UIImageView alloc] init];
//        //foodImage2.backgroundColor=ZCColor(299, 299, 299);
//        foodImage2.hidden=YES;
//        [foodImage addSubview:foodImage2];
//        self.foodImage2=foodImage2;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.textAlignment=NSTextAlignmentRight;
        [view addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        moneyLabel.textColor=[UIColor redColor];
        moneyLabel.textAlignment=NSTextAlignmentRight;
        [view addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;
        
    }
    return self;
}


-(void)setGoodsModel:(ZCGoodsModel *)goodsModel
{
    _goodsModel=goodsModel;
    
    if ([ZCTool _valueOrNil:goodsModel.image]==nil) {
        self.foodImage.image=[UIImage imageNamed:@"cyfw_mr"];
        //self.foodImage2.hidden=NO;
    }else{
        
        [self.foodImage sd_setImageWithURL:[NSURL URLWithString:goodsModel.image] placeholderImage:[UIImage imageNamed:@"cyfw_mr"]];
    }
    self.nameLabel.text=goodsModel.name;
    
    self.moneyLabel.text=[NSString stringWithFormat:@"￥ %@",goodsModel.price];
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewX=0;
    CGFloat viewY=0;
    CGFloat viewW=self.frame.size.width;
    CGFloat viewH=self.frame.size.height;
    self.view.frame=CGRectMake(viewX, viewY, viewW, viewH);
    
    CGFloat foodImageX=0;
    CGFloat foodImageY=0;
    CGFloat foodImageW=viewW;
    CGFloat foodImageH=viewW*0.7586;
    self.foodImage.frame=CGRectMake(foodImageX, foodImageY, foodImageW, foodImageH);
    
    
    //self.foodImage2.frame=CGRectMake((foodImageW-87)/2, (foodImageH-49)/2, 87, 49);
    
    
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=foodImageY+foodImageH;
    CGFloat nameLabelW=viewW-10;
    CGFloat nameLabelH=30;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat moneyLabelX=nameLabelX;
    CGFloat moneyLabelY=nameLabelY+nameLabelH-5;
    CGFloat moneyLabelW=nameLabelW;
    CGFloat moneyLabelH=nameLabelH;
    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);
    
}


@end
