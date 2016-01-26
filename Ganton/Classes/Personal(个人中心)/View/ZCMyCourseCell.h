//
//  ZCMyCourseCell.h
//  Ganton
//
//  Created by hh on 15/12/21.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCMyCourseModel.h"
@interface ZCMyCourseCell : UITableViewCell
+(instancetype)CellWithTabaleView:(UITableView *)tableView;
@property(nonatomic,strong)ZCMyCourseModel *myCourseModel;
@end
