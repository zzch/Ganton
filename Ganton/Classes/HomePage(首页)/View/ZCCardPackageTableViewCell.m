//
//  ZCCardPackageTableViewCell.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCardPackageTableViewCell.h"
#import "UIView+addShadow.h"
@interface ZCCardPackageTableViewCell()
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,weak)UIView *redView;
@property(nonatomic,weak)UIImageView *photoImageView;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UIImageView *imageView2;
@property(nonatomic,weak)UIImageView *imageView3;
@property(nonatomic,weak)UILabel *phoneLabel;
@property(nonatomic,weak)UILabel *addressLabel;
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
        
        //self.backgroundColor=ZCColor(237, 237, 237);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];

        
        //添加阴影效果
        [self addShadow];

        
        UIView *bjView=[[UIView alloc] init];
        [self.contentView addSubview:bjView];
        bjView.backgroundColor=[UIColor whiteColor];
        bjView.layer.cornerRadius = 5;
        bjView.clipsToBounds= YES;
        self.bjView=bjView;
        
        
//        bjView.layer.shadowColor = [UIColor grayColor].CGColor;
//        bjView.layer.shadowOffset = CGSizeMake(2, 2);
//        bjView.layer.shadowOpacity = 0.5;
//        bjView.layer.shadowRadius = 2;
        
        
        UIView *redView=[[UIView alloc] init];
        redView.backgroundColor=ZCColor(229, 74, 74);
        [bjView addSubview:redView];
        self.redView=redView;
        
        
        
        UIImageView *photoImageView=[[UIImageView alloc] init];
        //photoImageView.backgroundColor=ZCColor(299, 74, 75);
        [redView addSubview:photoImageView];
        self.photoImageView=photoImageView;
        
        
        UILabel *nameLabel=[[UILabel alloc] init];
        nameLabel.text=@"北湖九号高尔夫俱乐部";
        nameLabel.textAlignment=NSTextAlignmentCenter;
        nameLabel.textColor=[UIColor whiteColor];
        [redView addSubview:nameLabel];
        self.nameLabel=nameLabel;
        
        
        
        UIImageView *imageView2=[[UIImageView alloc] init];
        imageView2.image=[UIImage imageNamed:@"phone"];
        imageView2.alpha=0.5;
        [bjView addSubview:imageView2];
        self.imageView2=imageView2;
        
        UILabel *phoneLabel=[[UILabel alloc] init];
        phoneLabel.text=@"15010177980";
        [bjView addSubview:phoneLabel];
        self.phoneLabel=phoneLabel;
        
        UIImageView *imageView3=[[UIImageView alloc] init];
        imageView3.image=[UIImage imageNamed:@"location"];
        imageView3.alpha=0.5;
        [bjView addSubview:imageView3];
        self.imageView3=imageView3;

        UILabel *addressLabel=[[UILabel alloc] init];
        addressLabel.text=@"开发区开发区开发区开发区开发区开发区开发区开发区开发区开发区开发区开发区aasdas";
        //addressLabel.numberOfLines=0;
        //addressLabel.lineBreakMode=NSLineBreakByWordWrapping;
        addressLabel.numberOfLines = 0;
        addressLabel.textAlignment=NSTextAlignmentLeft;
        addressLabel.font= [UIFont systemFontOfSize:15];
        [bjView addSubview:addressLabel];
        self.addressLabel=addressLabel;
        
    }
    return self;
}


-(void)setCardModel:(ZCCardModel *)cardModel
{
    _cardModel=cardModel;
    
    if ([ZCTool _valueOrNil:cardModel.logo]) {
       [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:cardModel.logo] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2"] ];
    }
    
    
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@",cardModel.name];

    self.addressLabel.text=[NSString stringWithFormat:@" %@",cardModel.address];
    self.phoneLabel.text=[NSString stringWithFormat:@" %@",cardModel.phone_number];
}




-(void)adjustFrame{

    //[super layoutSubviews];
    
    CGFloat bjViewX=10;
    CGFloat bjViewY=10;
    CGFloat bjViewW=SCREEN_WIDTH-2*bjViewX;
    
    
    CGFloat redViewX=0;
    CGFloat redViewY=0;
    CGFloat redViewW=bjViewW;
    CGFloat redViewH=77;
    self.redView.frame=CGRectMake(redViewX, redViewY, redViewW, redViewH);
    
    CGFloat photoImageViewX=15;
    CGFloat photoImageViewY=8;
    CGFloat photoImageViewW=60;
    CGFloat photoImageViewH=60;
    self.photoImageView.frame=CGRectMake(photoImageViewX, photoImageViewY, photoImageViewW, photoImageViewH);
    
    
    CGFloat nameLabelX=photoImageViewX+photoImageViewW+10;
    CGFloat nameLabelY=0;
    CGFloat nameLabelW=bjViewW-nameLabelX-10;
    CGFloat nameLabelH=redViewH;
    self.nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    
    CGFloat imageView2X=15;
    CGFloat imageView2Y=redViewH+17;
    CGFloat imageView2W=14;
    CGFloat imageView2H=14;
    self.imageView2.frame=CGRectMake(imageView2X, imageView2Y, imageView2W, imageView2H);
    
    CGFloat phoneLabelX=imageView2X+imageView2W+5;
    CGFloat phoneLabelY=imageView2Y;
    CGFloat phoneLabelW=bjViewW-phoneLabelX-15;
    CGFloat phoneLabelH=14;
    self.phoneLabel.frame=CGRectMake(phoneLabelX, phoneLabelY, phoneLabelW, phoneLabelH);
    
    
    CGFloat imageView3X=15;
    CGFloat imageView3Y=imageView2Y+imageView2H+22;
    CGFloat imageView3W=14;
    CGFloat imageView3H=14;
    self.imageView3.frame=CGRectMake(imageView3X,imageView3Y, imageView3W, imageView3H);
    
//    CGFloat addressLabelX=phoneLabelX;
//    CGFloat addressLabelY=imageView3Y-2;
//    CGFloat addressLabelW=bjViewW-addressLabelX-10;
//    CGFloat addressLabelH=[ZCTool getFrame:CGSizeMake(addressLabelW, 100) content:self.addressLabel.text fontSize:[UIFont systemFontOfSize:15]].size.height;
//    self.addressLabel.frame=CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);

    
    
    CGFloat addressLabelX=phoneLabelX;
    CGFloat addressLabelY=imageView3Y-2;
    CGFloat addressLabelW=bjViewW-addressLabelX-10;
    CGFloat addressLabelH=[ZCTool getFrame:CGSizeMake(addressLabelW, 100) content:self.addressLabel.text fontSize:[UIFont systemFontOfSize:15]].size.height;
    self.addressLabel.frame=CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
    
    
    
    CGFloat bjViewH=addressLabelY+addressLabelH+10;
    self.bjView.frame=CGRectMake(bjViewX, bjViewY, bjViewW, bjViewH);
    self.cellHeight=bjViewH+20;
    ZCLog(@"%f",self.cellHeight);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
