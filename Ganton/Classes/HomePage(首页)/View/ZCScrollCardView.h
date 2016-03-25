//
//  ZCScrollCardView.h
//  Ganton
//
//  Created by hh on 16/3/17.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHomeModel.h"

@protocol ZCScrollCardViewDelegate <NSObject>

@optional

-(void)scrollCardView:(UIView *)view clickTheCardUuid:(NSString *)uuid;

@end

@interface ZCScrollCardView : UIView
@property(nonatomic,strong)ZCHomeModel *homeModel;
@property(nonatomic,weak)id<ZCScrollCardViewDelegate> delegate;
@end
