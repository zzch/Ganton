//
//  ZCConsumptionDetailModel.h
//  Ganton
//
//  Created by hh on 15/11/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCConsumptionDetailModel : NSObject
// 消费内容（无需格式化，可直接显示内容）
@property(nonatomic,copy)NSString *name;
 // 小计（无需格式化，可直接显示内容）
@property(nonatomic,copy)NSString *total_price;
// 付款方式（需要格式化，映射关系见下）
@property(nonatomic,copy)NSString *payment_method;

+ (instancetype)consumptionDetailModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
