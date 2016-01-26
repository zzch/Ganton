//
//  ZCMyLessonModel.h
//  Ganton
//
//  Created by hh on 16/1/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMyLessonModel : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *Description;
//下一层结构里的内容，修改需查询数据结构
@property(nonatomic,copy)NSString *coachName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *portrait;

+ (instancetype)myLessonModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
