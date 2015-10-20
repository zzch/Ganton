//
//  ZCWeathersModel.h
//  Ganton
//
//  Created by hh on 15/10/19.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCWeathersModel : NSObject
@property(nonatomic,assign)long date;
@property(nonatomic,copy)NSString *day_of_week;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *day_code;
@property(nonatomic,copy)NSString *maximum_temperature;
@property(nonatomic,copy)NSString *minimum_temperature;
@property(nonatomic,copy)NSString *probability_of_precipitation;
@property(nonatomic,copy)NSString *wind;

+ (instancetype)weathersModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
