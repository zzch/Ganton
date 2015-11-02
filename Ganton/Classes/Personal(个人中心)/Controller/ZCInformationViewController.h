//
//  ZCInformationViewController.h
//  Ganton
//
//  Created by hh on 15/10/14.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCInformationViewControllerDelegate<NSObject>
@optional
-(void)informationViewControllerWithImage:(UIImage *)image;
@end
@interface ZCInformationViewController : UIViewController
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,weak)id<ZCInformationViewControllerDelegate>delegate;
@end
