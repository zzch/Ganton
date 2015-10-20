//
//  ZCCoachDetailsModel.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCoachDetailsModel : NSObject
@property(nonatomic,copy)NSString *name;
//图片地址
@property(nonatomic,copy)NSString *portrait;
//性别
@property(nonatomic,copy)NSString *gender;
//教练级别
@property(nonatomic,copy)NSString *title;
//描述
@property(nonatomic,copy)NSString *Description;

//课程数组
@property(nonatomic,strong)NSMutableArray *courses;

+ (instancetype)CoachDetailsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
