//
//  ZCTeachingModel.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTeachingModel : NSObject
@property(nonatomic,strong)NSMutableArray *featured;
@property(nonatomic,strong)NSMutableArray *normal;

+ (instancetype)teachingModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
