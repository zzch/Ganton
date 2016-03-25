//
//  ZCPayByCardModel.h
//  Ganton
//
//  Created by hh on 16/3/21.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCPayByCardModel : NSObject
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *action;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,assign)long created_at;

//如果需要修改这2个属性，请参照json数据结构来对照赋值// 或者没有此属性
@property(nonatomic,copy)NSString *tabUuid;
@property(nonatomic,copy)NSString *tabSequence;

@property(nonatomic,strong)NSMutableArray *items;

+ (instancetype)payByCardModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
