//
//  ZCRecentlyScheduleModel.h
//  Ganton
//
//  Created by hh on 16/1/8.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRecentlyScheduleModel : NSObject
@property(nonatomic,assign)long date;
@property(nonatomic,strong)NSMutableArray *scheduleArray;
+ (instancetype)recentlyScheduleModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
