//
//  ZCCoachViewCell.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCoachViewCell.h"
@interface ZCCoachViewCell()
@property(nonatomic,weak)UILabel *TextLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UIImageView *rightImage;
@end
@implementation ZCCoachViewCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCCoachViewCell";
    ZCCoachViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCCoachViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *textLabel=[[UILabel alloc] init];
        textLabel.text=@"系统高尔夫教程";
        textLabel.font=[UIFont systemFontOfSize:15];
        [self.contentView addSubview:textLabel];
        self.TextLabel=textLabel;
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        
        moneyLabel.text=@"100000元";
        moneyLabel.font=[UIFont systemFontOfSize:15];
        moneyLabel.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:moneyLabel];
        self.moneyLabel=moneyLabel;
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.image=[UIImage imageNamed:@"shouye_arrow_icon"];
        [self.contentView addSubview:rightImage];
        self.rightImage=rightImage;
    
    }
    return self;
}


-(void)setCourseModel:(ZCCourseModel *)courseModel
{
    _courseModel=courseModel;
    
    self.TextLabel.text=courseModel.name;
    self.moneyLabel.text=[NSString stringWithFormat:@"%@元",courseModel.price];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    self.TextLabel.frame=CGRectMake(15, 0, 150, self.frame.size.height);
    
    self.moneyLabel.frame=CGRectMake(self.frame.size.width-6-15-165, 0, 150, self.frame.size.height);
    
    self.rightImage.frame=CGRectMake(self.frame.size.width-6-15, (self.frame.size.height-11)/2, 6, 11);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
