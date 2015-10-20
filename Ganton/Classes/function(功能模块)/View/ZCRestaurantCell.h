//
//  ZCRestaurantCell.h
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCGoodsModel.h"
@interface ZCRestaurantCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)ZCGoodsModel *goodsModel;

@end
