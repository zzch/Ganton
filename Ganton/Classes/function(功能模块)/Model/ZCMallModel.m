//
//  ZCMallModel.m
//  Ganton
//
//  Created by hh on 15/10/30.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//购物中心模型

#import "ZCMallModel.h"

@implementation ZCMallModel
+ (instancetype)mallModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.image=dict[@"image"];
        self.published_at=[dict[@"published_at"] longValue];
        self.uuid=dict[@"uuid"];
    }
    return self;

}
@end
