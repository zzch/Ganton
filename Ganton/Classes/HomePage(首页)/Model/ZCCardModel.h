//
//  ZCCardModel.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCardModel : NSObject
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *phone_number;

+ (instancetype)cardModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
