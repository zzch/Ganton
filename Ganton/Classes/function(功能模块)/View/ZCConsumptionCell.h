//
//  ZCConsumptionCell.h
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCRecordsOfConsumptionModel.h"
@interface ZCConsumptionCell : UITableViewCell
@property(nonatomic,strong)ZCRecordsOfConsumptionModel *recordsOfConsumptionModel;
@property(nonatomic,assign)CGFloat cellHight;
+(instancetype)cellWithTable:(UITableView *)tableView;

@end
