//
//  ZCAnnouncementModel.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnnouncementModel.h"

@implementation ZCAnnouncementModel
+ (instancetype)announcementModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.title=dict[@"title"];
        self.uuid=dict[@"uuid"];
    }
    return self;

}
@end
