//
//  ZCBirthdayViewController.h
//  Ganton
//
//  Created by hh on 15/10/28.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCBirthdayViewControllerDelegate<NSObject>
@optional
-(void)birthdayViewControllerDelegate:(long )data;
@end

@interface ZCBirthdayViewController : UIViewController
@property(nonatomic,copy) NSString *birthday;
@property(nonatomic,weak)id<ZCBirthdayViewControllerDelegate>delegate;
@end
