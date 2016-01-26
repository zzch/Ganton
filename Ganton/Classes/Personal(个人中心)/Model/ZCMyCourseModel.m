//
//  ZCMyCourseModel.m
//  Ganton
//
//  Created by hh on 16/1/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCMyCourseModel.h"

@implementation ZCMyCourseModel
+ (instancetype)myCourseModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.uuid=[dict objectForKey:@"uuid"];
        if ([ZCTool _valueOrNil:[dict objectForKey:@"rating"]]==nil) {
            self.rating=0;
        }else{
            self.rating=[[dict objectForKey:@"rating"] intValue];
        }
        
        
        self.state=[dict objectForKey:@"state"];
        self.club_name=[dict objectForKey:@"club_name"];
        self.lesson=[ZCLessonModel lessonModelWithDict:[dict objectForKey:@"lesson"]];
    }
    return self;

}
@end
