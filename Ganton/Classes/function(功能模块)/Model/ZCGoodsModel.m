//
//  ZCGoodsModel.m
//  Ganton
//
//  Created by hh on 15/10/19.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCGoodsModel.h"

@implementation ZCGoodsModel
+ (instancetype)goodsModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.image=dict[@"image"];
        self.price=dict[@"price"];
    }
    return self;

}
@end
