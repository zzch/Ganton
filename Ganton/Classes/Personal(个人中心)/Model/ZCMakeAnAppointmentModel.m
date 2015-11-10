//
//  ZCMakeAnAppointmentModel.m
//  Ganton
//
//  Created by hh on 15/11/5.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//打位预约模型

#import "ZCMakeAnAppointmentModel.h"

@implementation ZCMakeAnAppointmentModel

+ (instancetype)makeAnAppointmentModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"club"][@"name"];
        self.state=dict[@"state"];
        self.will_playing_at=[dict[@"will_playing_at"] longValue];
        
        
    }
    return self;

}
@end
