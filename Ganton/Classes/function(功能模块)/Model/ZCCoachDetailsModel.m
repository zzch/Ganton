//
//  ZCCoachDetailsModel.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCoachDetailsModel.h"
#import "ZCCourseModel.h"
@implementation ZCCoachDetailsModel
+ (instancetype)CoachDetailsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.portrait=dict[@"portrait"];
        self.gender=dict[@"gender"];
        self.title=dict[@"title"];
        self.Description=dict[@"description"];
        
        self.courses=[NSMutableArray array];
        NSMutableArray *array=[[NSMutableArray alloc] init];
        array=dict[@"courses"];
        for (NSDictionary *dict in array) {
            ZCCourseModel *CourseModel=[ZCCourseModel courseModelWithDict:dict];
            [self.courses addObject:CourseModel];
        }
        
    }
    return self;
}

@end
