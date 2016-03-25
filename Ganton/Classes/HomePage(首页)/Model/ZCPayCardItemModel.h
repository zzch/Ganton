//
//  ZCPayCardItemModel.h
//  Ganton
//
//  Created by hh on 16/3/21.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCPayCardItemModel : NSObject

@property(nonatomic,copy)NSString *type;

+ (instancetype)payCardItemModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
