//
//  ZCMakeAnAppointmentCell.h
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCMakeAnAppointmentModel.h"
@interface ZCMakeAnAppointmentCell : UITableViewCell
@property(nonatomic,strong)ZCMakeAnAppointmentModel *makeAnAppointmentModel;
+(instancetype)cellWithTable:(UITableView *)tableView;
@end
