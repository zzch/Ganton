//
//  ZCCardPackageViewController.h
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCCardPackageViewController;
@protocol ZCCardPackageViewControllerDelegate<NSObject>
@optional
-(void)clickTheOtherCardWithcardPackageViewController:(ZCCardPackageViewController *)cardPackageViewController;
@end
@interface ZCCardPackageViewController : UIViewController
@property(nonatomic,weak)id <ZCCardPackageViewControllerDelegate >delegate;
@end
