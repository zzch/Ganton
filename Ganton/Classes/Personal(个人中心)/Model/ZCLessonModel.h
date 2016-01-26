//
//  ZCLessonModel.h
//  Ganton
//
//  Created by hh on 16/1/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCMyLessonModel.h"
@interface ZCLessonModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)long started_at;
@property(nonatomic,assign)long finished_at;

@property(nonatomic,strong)ZCMyLessonModel *course;
+ (instancetype)lessonModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
