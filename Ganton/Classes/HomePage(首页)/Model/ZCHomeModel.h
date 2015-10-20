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

+ (instancetype)homeModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
