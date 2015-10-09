//
//  ZCCardPackageTableViewCell.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCardPackageTableViewCell.h"
@interface ZCCardPackageTableViewCell()
@property(nonatomic,weak)UIImageView *photoImageView;
@property(nonatomic,weak)UILabel *nameLabel;
@end
@implementation ZCCardPackageTableViewCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"ZCCardPackageTableViewCell";
    ZCCardPackageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCCardPackageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


//+(instancetype)cellWithTable:(UITableView *)tableView
//{
//    static NSString *ID = @"choose";
//    ZCChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[ZCChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    return  cell;
//}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *photoImageView=[[UIImageView alloc] init];
        photoImageView.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:photoImageView];
        self.photoImageView=photoImageView;
        
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"北湖九号高尔夫俱乐部";
        nameLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        
    }
    return self;
}


-(void)layoutSubviews{

    [super layoutSubviews];
    self.photoImageView.frame=CGRectMake(10, 10, 50, self.frame.size.height-20);
    self.nameLabel.frame=CGRectMake(60, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height);

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
