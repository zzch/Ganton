//
//  ZCCourseDetailsModel.m
//  Ganton
//
//  Created by hh on 15/10/17.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCourseDetailsModel.h"

@implementation ZCCourseDetailsModel
+ (instancetype)courseDetailsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.Description=dict[@"description"];
        self.lessons=dict[@"lessons"];
        self.maximum_students=dict[@"maximum_students"];
        self.name=dict[@"name"];
        self.price=dict[@"price"];
        self.valid_months=dict[@"valid_months"];
    }
    return self;
}

@end
