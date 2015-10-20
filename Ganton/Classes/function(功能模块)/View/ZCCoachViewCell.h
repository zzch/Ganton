//
//  ZCCoachViewCell.h
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCCourseModel.h"
@interface ZCCoachViewCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)tableView;
@property(nonatomic,strong)ZCCourseModel *courseModel;
@end
