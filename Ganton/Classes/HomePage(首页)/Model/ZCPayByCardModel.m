//
//  ZCPayByCardModel.m
//  Ganton
//
//  Created by hh on 16/3/21.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//会员卡模型

#import "ZCPayByCardModel.h"
#import "ZCPayCardItemModel.h"
@implementation ZCPayByCardModel

+ (instancetype)payByCardModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        
        self.uuid=dict[@"uuid"];
        self.type=dict[@"type"];
        self.action=dict[@"action"];
        self.amount=dict[@"amount"];
        
        self.created_at=[dict[@"created_at"] longValue];
        
        if ([ZCTool _valueOrNil:dict[@"tab"]]) {
            self.tabUuid=dict[@"tab"][@"uuid"];
            self.tabSequence=dict[@"tab"][@"sequence"];
        }
        
        
        NSArray *array=[NSArray array];
        array=dict[@"items"];
        for (NSDictionary *dict in array) {
            [self.items addObject:[ZCPayCardItemModel payCardItemModelWithDict:dict]];
        }
        
        
    }
    return self;
}


-(NSMutableArray *)items{
    if (!_items) {
        _items=[NSMutableArray array];
    }
    return _items;
}

@end
