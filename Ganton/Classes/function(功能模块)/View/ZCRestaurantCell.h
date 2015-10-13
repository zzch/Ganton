//
//  ZCRestaurantCell.h
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCRestaurantCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)NSString *nameStr;
@property(nonatomic,strong)NSString *imageStr;
@end
