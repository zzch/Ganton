//
//  ZCOpenCoursesModel.h
//  Ganton
//
//  Created by hh on 16/1/7.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCUnstartedLessonsModel.h"
@interface ZCOpenCoursesModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *coachName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,strong)NSMutableArray *unstarted_lessonsArray;
+ (instancetype)openCoursesModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
