//
//  ZCHomeModel.h
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCHomeModel : NSObject
//球场名字
@property(nonatomic,copy)NSString *name;
//图片地址
@property(nonatomic,copy)NSString *logo;

//会员卡的信息
@property(nonatomic,strong)NSMutableArray *members;
//公告信息
@property(nonatomic,strong)NSMutableArray *announcements;


//天气模型 ，数据返回是是一个字典 单独抽取出来
@property(nonatomic,copy)NSString *maximum_temperature;
@property(nonatomic,assign)long date;

+ (instancetype)homeModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
