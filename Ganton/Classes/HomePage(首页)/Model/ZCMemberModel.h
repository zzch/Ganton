//
//  ZCMemberModel.h
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMemberModel : NSObject
@property(nonatomic,copy)NSString *balance;
@property(nonatomic,copy)NSString *background_color;
@property(nonatomic,copy)NSString *font_color;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *uuid;
@property(nonatomic,assign)long expired_at;

+ (instancetype)memberModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
