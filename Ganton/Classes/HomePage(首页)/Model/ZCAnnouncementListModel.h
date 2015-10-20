//
//  ZCAnnouncementListModel.h
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCAnnouncementListModel : NSObject
@property(nonatomic,assign)long published_at;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *uuid;

+ (instancetype)announcementListModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
