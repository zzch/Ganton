//
//  ZCTimeView.h
//  Ganton
//
//  Created by hh on 15/10/27.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCTimeViewDelegate<NSObject>
@optional
-(void)timeViewChooseTime:(NSString *)chooseTime;
@end
@interface ZCTimeView : UIView
@property(nonatomic,weak)id<ZCTimeViewDelegate>delegate;
@property(nonatomic,copy)NSString *timeStr;
@end
