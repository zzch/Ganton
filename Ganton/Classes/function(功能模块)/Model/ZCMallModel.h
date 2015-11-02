//
//  ZCMallModel.h
//  Ganton
//
//  Created by hh on 15/10/30.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMallModel : NSObject
@property(nonatomic,copy)NSString *image;
@property(nonatomic,assign)long published_at;
@property(nonatomic,copy)NSString *uuid;

+ (instancetype)mallModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
