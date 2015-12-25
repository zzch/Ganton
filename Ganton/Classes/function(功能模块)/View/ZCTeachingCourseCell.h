//
//  ZCTeachingCourseCell.h
//  Ganton
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCStudentModel.h"
@interface ZCTeachingCourseCell : UITableViewCell
@property(nonatomic,strong)ZCStudentModel *studentModel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
