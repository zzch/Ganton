//
//  ZCCoachViewCell.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCoachViewCell.h"

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
        textLabel.frame=CGRectMake(10, 0, 50, self.frame.size.height);
        textLabel.text=@"系统高尔夫教程";
        [self.contentView addSubview:textLabel];
        
        
        UILabel *moneyLabel=[[UILabel alloc] init];
        moneyLabel.frame=CGRectMake(SCREEN_WIDTH-100-50, 0, 100, self.frame.size.height);
        moneyLabel.text=@"100000元";
        [self.contentView addSubview:moneyLabel];
        
        UIImageView *rightImage=[[UIImageView alloc] init];
        rightImage.frame=CGRectMake(SCREEN_WIDTH-40, (self.frame.size.height-10)/2, 10, 10);
        rightImage.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:rightImage];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
