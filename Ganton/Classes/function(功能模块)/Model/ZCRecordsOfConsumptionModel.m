//
//  ZCRecordsOfConsumptionModel.m
//  Ganton
//
//  Created by hh on 15/11/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//消费记录模型

#import "ZCRecordsOfConsumptionModel.h"

@implementation ZCRecordsOfConsumptionModel
+ (instancetype)recordsOfConsumptionModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict;
{
    if (self=[super init]) {
        self.uuid=dict[@"uuid"];
        self.sequence=dict[@"sequence"];
        self.reception_payment=dict[@"reception_payment"];
        self.entrance_time=[dict[@"entrance_time"] longValue];
        self.departure_time=[dict[@"departure_time"] longValue];
        
        self.items=[NSMutableArray array];
        NSMutableArray *array=[NSMutableArray array];
        array=dict[@"items"];
        for (NSDictionary *dict in array) {
            ZCConsumptionDetailModel *model=[ZCConsumptionDetailModel consumptionDetailModelWithDict:dict];
            [self.items addObject:model];
        }
        
    }
    return self;
}
@end
