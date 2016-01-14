//
//  ZCAppointmentCoachCell.h
//  Ganton
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCUnstartedLessonsModel.h"
@protocol ZCAppointmentCoachCellDelegate<NSObject>
@optional
-(void)clickTheButton:(NSString *)str;
@end
@interface ZCAppointmentCoachCell : UITableViewCell
@property(nonatomic,weak)id<ZCAppointmentCoachCellDelegate>delegate;

@property(nonatomic,strong)ZCUnstartedLessonsModel *unstartedLessonsModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
