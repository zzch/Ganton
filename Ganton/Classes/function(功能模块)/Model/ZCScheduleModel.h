//
//  ZCScheduleModel.h
//  Ganton
//
//  Created by hh on 16/1/8.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCScheduleModel : NSObject
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *state;
+ (instancetype)scheduleModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
