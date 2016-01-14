//
//  ZCScheduleModel.m
//  Ganton
//
//  Created by hh on 16/1/8.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCScheduleModel.h"

@implementation ZCScheduleModel
+ (instancetype)scheduleModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.time=dict[@"time"];
        self.state=dict[@"state"];
    }
    return self;
}
@end
