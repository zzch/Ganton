//
//  ZCHomeModel.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCHomeModel.h"
#import "ZCMemberModel.h"
#import "ZCAnnouncementModel.h"
@implementation ZCHomeModel
+ (instancetype)homeModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"club"][@"name"];
        self.logo=dict[@"club"][@"logo"];
        
        
        
        NSMutableArray *array=[NSMutableArray array];
        array=dict[@"members"];
        
        self.members=[[NSMutableArray alloc] init];
        for (NSDictionary *dict in array) {
            ZCMemberModel *memberModel=[ZCMemberModel memberModelWithDict:dict];
            [self.members addObject:memberModel];
        }
        
        NSMutableArray *array2=[NSMutableArray array];
        array2=dict[@"announcements"];
        
        self.announcements=[[NSMutableArray alloc] init];
        for (NSDictionary *dict in array2) {
            ZCAnnouncementModel *AnnouncementModel=[ZCAnnouncementModel announcementModelWithDict:dict];
            [self.announcements addObject:AnnouncementModel];
        }
        
        
    }
    return self;

}

@end
