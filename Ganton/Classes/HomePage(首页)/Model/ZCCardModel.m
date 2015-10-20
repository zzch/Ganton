//
//  ZCCardModel.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCardModel.h"

@implementation ZCCardModel
+ (instancetype)cardModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.uuid=dict[@"uuid"];
        self.name=dict[@"name"];
        self.logo=dict[@"logo"];
    }
    return self;
}

@end
