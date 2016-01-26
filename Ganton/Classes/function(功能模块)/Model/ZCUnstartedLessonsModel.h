//
//  ZCUnstartedLessonsModel.h
//  Ganton
//
//  Created by hh on 16/1/7.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCUnstartedLessonsModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)long started_at;
@property(nonatomic,assign)long finished_at;
@property(nonatomic,copy)NSString *current_students;
@property(nonatomic,copy)NSString *maximum_students;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *uuid;

+ (instancetype)unstartedLessonsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
