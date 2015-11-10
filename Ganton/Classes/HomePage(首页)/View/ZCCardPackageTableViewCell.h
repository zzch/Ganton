//
//  ZCCardPackageTableViewCell.h
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCCardModel.h"
@interface ZCCardPackageTableViewCell : UITableViewCell
@property (nonatomic, assign) CGFloat cellHeight;
+(instancetype)cellWithTable:(UITableView *)tableView;
@property(nonatomic,strong)ZCCardModel *cardModel;
-(void)adjustFrame;
@end
