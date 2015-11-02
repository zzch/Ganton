//
//  ZCWeathersModel.m
//  Ganton
//
//  Created by hh on 15/10/19.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCWeathersModel.h"

@implementation ZCWeathersModel
+ (instancetype)weathersModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.date=[dict[@"date"] longValue];
        self.day_of_week=dict[@"day_of_week"];
        self.content=dict[@"content"];
        self.code=dict[@"code"];
        self.maximum_temperature=dict[@"maximum_temperature"];
        self.minimum_temperature=dict[@"minimum_temperature"];
        self.probability_of_precipitation=dict[@"probability_of_precipitation"];
        self.wind=dict[@"wind"];
    }
    return self;

}
@end
