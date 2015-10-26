//
//  ZCMemberModel.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMemberModel.h"

@implementation ZCMemberModel

+ (instancetype)memberModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.balance=dict[@"balance"];
        self.background_color=dict[@"card"][@"background_color"];
        self.font_color=dict[@"card"][@"font_color"];
        self.name=dict[@"card"][@"name"];
        self.number=dict[@"number"];
        self.uuid=dict[@"uuid"];
        self.expired_at=[dict[@"expired_at"] longValue];
    }
    return self;
}


@end
