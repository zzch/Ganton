//
//  ZCAnnouncementCell.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCAnnouncementListModel.h"
@interface ZCAnnouncementCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)tableView;
@property(nonatomic,strong)ZCAnnouncementListModel *announcementListModel;
@end
