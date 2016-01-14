//
//  ZCUnstartedLessonsModel.m
//  Ganton
//
//  Created by hh on 16/1/7.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCUnstartedLessonsModel.h"

@implementation ZCUnstartedLessonsModel
+ (instancetype)unstartedLessonsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.started_at=[dict[@"started_at"] longValue];
        self.finished_at=[dict[@"finished_at"] longValue];
        self.current_students=dict[@"current_students"];
        self.maximum_students=dict[@"maximum_students"];
        self.state=dict[@"state"];
    }
    return self;
}



@end
