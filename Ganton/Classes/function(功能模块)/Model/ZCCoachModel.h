//
//  ZCCoachModel.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCoachModel : NSObject
@property(nonatomic,copy)NSString *gender;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *portrait;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *Description;
@property(nonatomic,copy)NSString *starting_price;
+ (instancetype)coachModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
