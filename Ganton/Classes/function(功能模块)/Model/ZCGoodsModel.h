//
//  ZCGoodsModel.h
//  Ganton
//
//  Created by hh on 15/10/19.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCGoodsModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *price;

+ (instancetype)goodsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
