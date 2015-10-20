//
//  ZCTeachingCell.h
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCCoachModel.h"
@interface ZCTeachingCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)tableView;
@property(nonatomic,strong)ZCCoachModel *coachModel;
@end
