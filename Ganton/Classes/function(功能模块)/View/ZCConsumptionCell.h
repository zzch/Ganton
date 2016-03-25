//
//  ZCConsumptionCell.h
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCRecordsOfConsumptionModel.h"


@protocol ZCConsumptionCellDelegate<NSObject>
@optional
-(void)clickTheConfirmBtn:(NSString *)uuid;
@end


@interface ZCConsumptionCell : UITableViewCell
@property(nonatomic,strong)ZCRecordsOfConsumptionModel *recordsOfConsumptionModel;

//判断是否是从ZCCardDetailsViewController控制器跳转来的
@property(nonatomic,assign)BOOL isYes;

@property(nonatomic,strong)id<ZCConsumptionCellDelegate>delegete;
@property(nonatomic,assign)CGFloat cellHight;
+(instancetype)cellWithTable:(UITableView *)tableView;

@end
