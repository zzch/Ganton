//
//  ZCStudentModel.h
//  Ganton
//
//  Created by hh on 15/12/24.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//教练教学页面课程

#import <Foundation/Foundation.h>

@interface ZCStudentModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,assign)long expired_at;
@property(nonatomic,copy)NSString *total_lessons;
@property(nonatomic,copy)NSString *uuid;


+ (instancetype)studentModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
