//
//  ZCLessonModel.m
//  Ganton
//
//  Created by hh on 16/1/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCLessonModel.h"

@implementation ZCLessonModel
+ (instancetype)lessonModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=[dict objectForKey:@"name"];
        self.started_at=[[dict objectForKey:@"started_at"] longValue];
        self.finished_at=[[dict objectForKey:@"finished_at"] longValue];
        
        self.course=[ZCMyLessonModel myLessonModelWithDict:dict[@"course"]];
    }
    return self;

}
@end
