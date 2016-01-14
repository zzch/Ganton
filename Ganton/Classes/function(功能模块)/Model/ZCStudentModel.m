//
//  ZCStudentModel.m
//  Ganton
//
//  Created by hh on 15/12/24.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCStudentModel.h"

@implementation ZCStudentModel

+ (instancetype)studentModelWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
    

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
       
        
        self.name=dict[@"course"][@"name"];
        self.type=dict[@"course"][@"type"];
        self.expired_at=[dict[@"expired_at"] longValue];
        self.total_lessons=dict[@"total_lessons"];
        self.uuid=dict[@"course"][@"uuid"];
    }
    return self;
}

@end
