//
//  ZCMallCell.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//会员商城

#import "ZCMallCell.h"
@interface ZCMallCell()
@property(nonatomic,weak)UIImageView *goodsImage;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@end
@implementation ZCMallCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"ZCMallCell";
    
    ZCMallCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCMallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        //self.=UITableViewCellSeparatorStyleNone;
       // self.separatorInset
        
        UIImageView *goodsImage=[[UIImageView alloc] init];
        goodsImage.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:goodsImage];
        self.goodsImage=goodsImage;
        
//        UILabel *nameLabel=[[UILabel alloc] init];
//        nameLabel.text=@"高尔夫球杆3号";
//        [self.contentView addSubview:nameLabel];
//        self.nameLabel=nameLabel;
//        
//        UILabel *moneyLabel=[[UILabel alloc] init];
//        moneyLabel.text=@"￥ 10000";
//        [self.contentView addSubview:moneyLabel];
//        self.moneyLabel=moneyLabel;
        
    }
    return self;
}



-(void)setMallModel:(ZCMallModel *)mallModel
{
    _mallModel=mallModel;
    

    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:mallModel.image] placeholderImage:nil];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat goodsImageW=self.frame.size.width;
    CGFloat goodsImageH=self.frame.size.height;
    CGFloat goodsImageX=0;
    CGFloat goodsImageY=0;
    self.goodsImage.frame=CGRectMake(goodsImageX, goodsImageY, goodsImageW, goodsImageH);
    
//    CGFloat nameLabelX=goodsImageX+goodsImageW+10;
//    CGFloat nameLabelY=20;
//    CGFloat nameLabelW=100;
//    CGFloat nameLabelH=30;
//    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
//    
//    CGFloat moneyLabelW=50;
//    CGFloat moneyLabelH=30;
//    CGFloat moneyLabelX=SCREEN_WIDTH-moneyLabelW-20;
//    CGFloat moneyLabelY=20;
//    self.moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelW, moneyLabelH);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
