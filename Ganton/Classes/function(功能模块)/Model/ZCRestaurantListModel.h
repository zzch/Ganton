//
//  ZCRestaurantListModel.h
//  Ganton
//
//  Created by hh on 15/10/19.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCRestaurantListModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSMutableArray *provisions;

+ (instancetype)restaurantListModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
