//
//  ZCMyCourseModel.h
//  Ganton
//
//  Created by hh on 16/1/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLessonModel.h"
@interface ZCMyCourseModel : NSObject
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,assign)int rating;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *club_name;
@property(nonatomic,strong)ZCLessonModel *lesson;
+ (instancetype)myCourseModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
