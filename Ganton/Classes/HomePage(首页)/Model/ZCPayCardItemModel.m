//
//  ZCPayCardItemModel.m
//  Ganton
//
//  Created by hh on 16/3/21.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCPayCardItemModel.h"

@implementation ZCPayCardItemModel
+ (instancetype)payCardItemModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.type=dict[@"type"];
    }
    return self;
}
@end
