//
//  ZCAnnouncementModel.h
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCAnnouncementModel : NSObject
//时间戳
@property(nonatomic,assign)long published_at;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *uuid;

+ (instancetype)announcementModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
