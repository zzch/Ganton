//
//  ZCCourseModel.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCourseModel.h"

@implementation ZCCourseModel
+ (instancetype)courseModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        self.price=dict[@"price"];
        self.lessons=dict[@"lessons"];
    }
    return self;
}

@end
