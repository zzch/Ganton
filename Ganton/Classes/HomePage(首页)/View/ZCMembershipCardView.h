//
//  ZCMembershipCardView.h
//  Ganton
//
//  Created by hh on 16/3/16.
//  Copyright © 2016年 zhongchuang. All rights reserved.
// 会员卡

#import <UIKit/UIKit.h>
#import "ZCMemberModel.h"
#import "ZCHomeModel.h"
@interface ZCMembershipCardView : UIButton
-(void)setMemberModel:(ZCMemberModel *)memberModel andHomeModel:(ZCHomeModel *)homeModel;
@end
