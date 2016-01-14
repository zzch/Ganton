//
//  ZCPrivateCoursesModel.h
//  Ganton
//
//  Created by hh on 16/1/8.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCPrivateCoursesModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *coachName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,strong)NSMutableArray *recently_scheduleArray;
+ (instancetype)privateCoursesModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
