//
//  LoginViewController.h
//  YouzaniOSDemo
//
//  Created by youzan on 15/11/6.
//  Copyright (c) 2015年 youzan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheUserInfo.h"
typedef void (^BackWebViewRefreshPageBlock)(CacheUserInfo * model);

@interface LoginViewController : UIViewController

@property (copy, nonatomic) BackWebViewRefreshPageBlock loginBlock;

@end
