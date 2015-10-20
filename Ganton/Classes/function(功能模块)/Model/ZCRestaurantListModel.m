//
//  ZCRestaurantListModel.m
//  Ganton
//
//  Created by hh on 15/10/19.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//餐饮列表

#import "ZCRestaurantListModel.h"
#import "ZCGoodsModel.h"
@implementation ZCRestaurantListModel
+ (instancetype)restaurantListModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.provisions=[NSMutableArray array];
        
        NSMutableArray *array=dict[@"provisions"];
        for (NSDictionary *dict in array) {
            ZCGoodsModel *goodsModel=[ZCGoodsModel goodsModelWithDict:dict];
            [self.provisions addObject:goodsModel];
        }
        
    }
    return self;

}

@end
