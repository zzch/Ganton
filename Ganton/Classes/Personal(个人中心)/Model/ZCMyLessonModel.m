//
//  ZCMyLessonModel.m
//  Ganton
//
//  Created by hh on 16/1/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCMyLessonModel.h"

@implementation ZCMyLessonModel
+ (instancetype)myLessonModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=[dict objectForKey:@"name"];
        self.type=dict[@"type"];
        self.Description=dict[@"description"];
        
        self.coachName=dict[@"coach"][@"name"];
        self.title=dict[@"coach"][@"title"];
        self.portrait=dict[@"coach"][@"portrait"];
        
        ZCLog(@"%@",self.name);
        
    }
    return self;
}
@end
