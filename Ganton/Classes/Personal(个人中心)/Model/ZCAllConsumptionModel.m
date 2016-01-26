//
//  ZCAllConsumptionModel.m
//  Ganton
//
//  Created by hh on 15/11/17.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAllConsumptionModel.h"

@implementation ZCAllConsumptionModel
+ (instancetype)allConsumptionModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    
    
    if (self=[super init]) {
        ZCLog(@"%@",dict);
        self.uuid=dict[@"uuid"];
        self.sequence=dict[@"sequence"];
        self.reception_payment=dict[@"reception_payment"];
        self.entrance_time=[dict[@"entrance_time"] longValue];
        if ([ZCTool _valueOrNil:dict[@"departure_time"]]==nil) {
            self.departure_time=0;
        }else{
        self.departure_time=[dict[@"departure_time"] longValue];
        }
        self.name=dict[@"club"][@"name"];
        self.state=dict[@"state"];
        
        self.items=[NSMutableArray array];
        NSMutableArray *array=[NSMutableArray array];
        array=dict[@"items"];
        for (NSDictionary *dict in array) {
            ZCConsumptionDetailModel *model=[ZCConsumptionDetailModel consumptionDetailModelWithDict:dict];
            [self.items addObject:model];
        }

        
    }
    return self;
}

@end
