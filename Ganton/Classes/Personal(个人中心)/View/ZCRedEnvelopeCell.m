//
//  ZCRedEnvelopeCell.m
//  Ganton
//
//  Created by hh on 15/10/14.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//红包

#import "ZCRedEnvelopeCell.h"
@interface ZCRedEnvelopeCell()
@property(nonatomic,weak)UIImageView *personImage;
@property(nonatomic,weak)UILabel *typeLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *titleLabel;

@end
@implementation ZCRedEnvelopeCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCTeachingCell";
    ZCRedEnvelopeCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCRedEnvelopeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        nameLabel.text=@"可乐2听";
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        UILabel *titleLabel=[[UILabel alloc] init];
        titleLabel.text=@"剩余30天";
        [self.contentView addSubview:titleLabel];
        self.titleLabel=titleLabel;
        
        UILabel *typeLabel=[[UILabel alloc] init];
        typeLabel.text=@"未使用";
        [self.contentView addSubview:typeLabel];
        self.typeLabel=typeLabel;
        
        
        
                
        
    }
    return self;
    
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
    
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH;
    CGFloat titleLabelW=50;
    CGFloat titleLabelH=30;
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat  typeLabelX=nameLabelX+nameLabelW+30;
    CGFloat  typeLabelY=nameLabelY+10;
    CGFloat  typeLabelW=40;
    CGFloat  typeLabelH=30;
    self.typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    
    
    
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
