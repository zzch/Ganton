//
//  ZCPrivateCoursesModel.m
//  Ganton
//
//  Created by hh on 16/1/8.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCPrivateCoursesModel.h"
#import "ZCRecentlyScheduleModel.h"
@implementation ZCPrivateCoursesModel
+ (instancetype)privateCoursesModelWithDict:(NSDictionary *)dict;
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
        
        self.recently_scheduleArray=[NSMutableArray array];
        NSMutableArray *teamArray=[NSMutableArray array];
        teamArray=dict[@"recently_schedule"];
        for (NSDictionary *dict in teamArray) {
            ZCRecentlyScheduleModel *model=[ZCRecentlyScheduleModel recentlyScheduleModelWithDict:dict];
            [self.recently_scheduleArray addObject:model];
        }
        
    }
    return self;
}

@end
