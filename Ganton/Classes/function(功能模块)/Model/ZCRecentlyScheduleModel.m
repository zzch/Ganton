//
//  ZCRecentlyScheduleModel.m
//  Ganton
//
//  Created by hh on 16/1/8.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCRecentlyScheduleModel.h"
#import "ZCScheduleModel.h"
@implementation ZCRecentlyScheduleModel

+ (instancetype)recentlyScheduleModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.date=[dict[@"date"] longValue];
        self.scheduleArray=[[NSMutableArray alloc] init];
       
        
        NSMutableArray *teamArray=[NSMutableArray array];
        teamArray=dict[@"schedule"];
        for (NSDictionary *dict in teamArray) {
            ZCScheduleModel *model=[ZCScheduleModel scheduleModelWithDict:dict];
            [self.scheduleArray addObject:model];
        }

        
    }
    return self;
}
@end
