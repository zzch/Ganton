//
//  ZCCourseDetailsModel.h
//  Ganton
//
//  Created by hh on 15/10/17.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCourseDetailsModel : NSObject

@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *lessons;
@property(nonatomic,copy)NSString *maximum_students;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *valid_months;


+ (instancetype)courseDetailsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
