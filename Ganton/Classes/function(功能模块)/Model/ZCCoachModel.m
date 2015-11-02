//
//  ZCCoachModel.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCoachModel.h"

@implementation ZCCoachModel

+ (instancetype)coachModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.gender=dict[@"gender"];
        self.name=dict[@"name"];
        self.portrait=dict[@"portrait"];
        self.title=dict[@"title"];
        self.uuid=dict[@"uuid"];
        ZCLog(@"%@",dict[@"description"]);
        self.Description=dict[@"description"];
        self.starting_price=dict[@"starting_price"];
    }
    return self;

}
@end
