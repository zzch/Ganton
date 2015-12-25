//
//  ZCTeachingModel.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCTeachingModel.h"
#import "ZCCoachModel.h"
#import "ZCStudentModel.h"
@implementation ZCTeachingModel
+ (instancetype)teachingModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.featured=[NSMutableArray array];
        NSMutableArray *array=[NSMutableArray array];
        array=dict[@"featured"];
        for (NSDictionary *dict in array) {
            ZCCoachModel *CoachModel=[ZCCoachModel coachModelWithDict:dict];
            [self.featured addObject:CoachModel];
        }
        
        
        self.normal=[NSMutableArray array];
        NSMutableArray *array2=[NSMutableArray array];
        array2=dict[@"normal"];
        for (NSDictionary *dict in array2) {
            ZCCoachModel *CoachModel=[ZCCoachModel coachModelWithDict:dict];
            [self.normal addObject:CoachModel];
        }
        
        
        self.students=[NSMutableArray array];
        NSMutableArray *array3=[NSMutableArray array];
        array3=dict[@"students"];
        for (NSDictionary *dict in array3) {
            ZCStudentModel *studentModel=[ZCStudentModel studentModelWithDict:dict];
            [self.students addObject:studentModel];
        }


        
    }
    return self;

}
@end
