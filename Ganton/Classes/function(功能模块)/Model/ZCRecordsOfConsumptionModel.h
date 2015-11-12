//
//  ZCRecordsOfConsumptionModel.h
//  Ganton
//
//  Created by hh on 15/11/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCConsumptionDetailModel.h"
@interface ZCRecordsOfConsumptionModel : NSObject
// 保留，目前无作用
@property(nonatomic,copy)NSString *uuid;
// 消费单号
@property(nonatomic,copy)NSString *sequence;
// 前台支付
@property(nonatomic,copy)NSString *reception_payment;
// 进场时间
@property(nonatomic,assign)long entrance_time;
 // 离场时间
@property(nonatomic,assign)long departure_time;
// 消费明细
@property(nonatomic,strong)NSMutableArray *items;

+ (instancetype)recordsOfConsumptionModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
