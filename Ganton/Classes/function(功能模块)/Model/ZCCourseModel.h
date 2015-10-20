//
//  ZCCourseModel.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCourseModel : NSObject
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *lessons;

+ (instancetype)courseModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
