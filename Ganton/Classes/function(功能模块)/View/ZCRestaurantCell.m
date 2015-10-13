//
//  ZCRestaurantCell.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//餐饮服务

#import "ZCRestaurantCell.h"
@interface ZCRestaurantCell()
@property(nonatomic,weak)UIView *view;
@property(nonatomic,weak)UIImageView *foodImage;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@end
@implementation ZCRestaurantCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"ZCRestaurantCell";
    
    ZCRestaurantCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCRestaurantCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        //添加阴影效果
//        self.layer.shadowColor = [UIColor grayColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(2, 2);
//        self.layer.shadowOpacity = 0.5;
//        self.layer.shadowRadius = 2;

        
        UIView *view=[[UIView alloc] init];
        //view.backgroundColor=[UIColor blueColor];
        [self.contentView addSubview:view];
        self.view=view;
        
//        //1.设置阴影 因为shadowColor 是CGColorRef类型 所以要转换成CGColor类型
//        
//        view.layer.shadowColor=[UIColor blackColor].CGColor;
//        
//        //2.阴影的偏移大小
//        
//        view.layer.shadowOffset=CGSizeMake(10,10);
//        
//        //3.不透明度
//        
//        view.layer.shadowOpacity=0.5;
        

        
        UIImageView *foodImage=[[UIImageView alloc] init];
        //foodImage.backgroundColor=[UIColor redColor];
        [view addSubview:foodImage];
        self.foodImage=foodImage;
        
        UILabel *nameLabel=[[UILabel alloc] init];
        [view addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        [view addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;
        
    }
    return self;

}

-(void)setNameStr:(NSString *)nameStr
{
    _nameStr=nameStr;
    self.nameLabel.text=nameStr;

}

-(void)setImageStr:(NSString *)imageStr
{
    _imageStr=imageStr;
    self.imageView.image=[UIImage imageNamed:imageStr];

}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewX=10;
    CGFloat viewY=10;
    CGFloat viewW=SCREEN_WIDTH-20;
    CGFloat viewH=self.frame.size.height-20;
    self.view.frame=CGRectMake(viewX, viewY, viewW, viewH);
    
    CGFloat foodImageX=10;
    CGFloat foodImageY=10;
    CGFloat foodImageW=100;
    CGFloat foodImageH=viewH-20;
    self.foodImage.frame=CGRectMake(foodImageX, foodImageY, foodImageW, foodImageH);
    
    CGFloat nameLabelX=foodImageX+foodImageW+80;
    CGFloat nameLabelY=foodImageY;
    CGFloat nameLabelW=viewW-nameLabelX;
    CGFloat nameLabelH=30;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    CGFloat moneyLabelX=nameLabelX;
    CGFloat moneyLabelY=viewH-40;
    CGFloat moneyLabelW=nameLabelW;
    CGFloat moneyLabelH=nameLabelH;
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
