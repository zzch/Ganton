//
//  ZCMakeAnAppointmentModel.h
//  Ganton
//
//  Created by hh on 15/11/5.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMakeAnAppointmentModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,assign)long will_playing_at;


+ (instancetype)makeAnAppointmentModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
