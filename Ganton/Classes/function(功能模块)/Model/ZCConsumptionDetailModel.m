//
//  ZCConsumptionDetailModel.m
//  Ganton
//
//  Created by hh on 15/11/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCConsumptionDetailModel.h"

@implementation ZCConsumptionDetailModel
+ (instancetype)consumptionDetailModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.total_price=dict[@"total_price"];
        self.payment_method=dict[@"payment_method"];
    }
    return self;
}

@end
