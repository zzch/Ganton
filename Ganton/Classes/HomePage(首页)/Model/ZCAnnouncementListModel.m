//
//  ZCAnnouncementListModel.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnnouncementListModel.h"

@implementation ZCAnnouncementListModel
+ (instancetype)announcementListModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.published_at=[dict[@"published_at"] longValue];
        self.summary=dict[@"summary"];
        self.title=dict[@"title"];
        self.uuid=dict[@"uuid"];
    }
    return self;

}

@end
