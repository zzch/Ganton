//
//  ZCOpenCoursesModel.m
//  Ganton
//
//  Created by hh on 16/1/7.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCOpenCoursesModel.h"

@implementation ZCOpenCoursesModel

+ (instancetype)openCoursesModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.Description=dict[@"description"];
        self.coachName=dict[@"coach"][@"name"];
        self.title=dict[@"coach"][@"title"];
        self.portrait=dict[@"coach"][@"portrait"];
        
        self.unstarted_lessonsArray=[NSMutableArray array];
        NSMutableArray *teamArray=[NSMutableArray array];
        teamArray=dict[@"unstarted_lessons"];
        for (NSDictionary *dict in teamArray) {
            ZCUnstartedLessonsModel *model=[ZCUnstartedLessonsModel unstartedLessonsModelWithDict:dict];
            [self.unstarted_lessonsArray addObject:model];
        }
       
    }
    return self;
}

@end
