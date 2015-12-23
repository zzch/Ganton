//
//  AppDelegate.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCHomeViewController.h"
#import "ZCAccountViewController.h"
#import "APService.h"
#import "ZCRecordsOfConsumptionViewController.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsService.h"
@interface AppDelegate ()<UIAlertViewDelegate>
@property(nonatomic,strong)NSDictionary *userInfo;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建Window
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    
    
    //去掉右上角图标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    // Required
    [APService setupWithOption:launchOptions];
    
    
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    
   
    
    //友盟分享
     [UMSocialWechatHandler setWXAppId:@"wxaf828c2ffaaa6f94" appSecret:@"6bb03e9ee3ed10160b2df80eca4c6a4d" url:@"http://www.umeng.com/social"];
    
    
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
   
    if (token) {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ZCHomeViewController alloc] init]];
        self.window.rootViewController = nav;

    }else{
        //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ZCAccountViewController alloc] init]];
        self.window.rootViewController = [[ZCAccountViewController alloc] init];

    }
    
    
    
    //监听极光推送注册成功后调用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registeredSuccessfully) name:@"kJPFNetworkDidLoginNotification" object:nil];
    
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //导航栏的背景颜色和字体
    
    UINavigationBar *bar = [UINavigationBar appearance];
    //bar.barTintColor = ZCColor(60, 57, 78);
    [bar setBackgroundImage:[UIImage imageNamed:@"daohanglan"] forBarMetrics:UIBarMetricsDefault];
    bar.tintColor=[UIColor whiteColor];
    bar.titleTextAttributes=@{UITextAttributeTextColor: [UIColor whiteColor],UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    // 4.显示window
    [self.window makeKeyAndVisible];
    
    
//    
//    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert)
//                                       categories:nil];
//    
//    //launchOptions  远程通知的内容
//    [APService setupWithOption:launchOptions];
    
//    UILabel *label=[[UILabel alloc] init];
//    label.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    label.numberOfLines=0;
//    label.text=[NSString stringWithFormat:@"%@",remoteNotification];
//    [self.window addSubview:label];
    
    return YES;


}

//友盟回调

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}



// 注册成功
-(void)registeredSuccessfully
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    if (token){
    //判断是否要上传ID
   [ZCTool uploadThePushID];
        
    }


}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得自定义字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
   
    
    // Required
    [APService handleRemoteNotification:userInfo];
    
    
    if ((long)application.applicationState==0 ) {
        
        [self pushThepopUp:userInfo];
        
    }else{
        
        
        NSString *redirect_to = [userInfo valueForKey:@"redirect_to"];
        if ([redirect_to isEqual:@"tabs_list"]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"uuid"];
            [defaults setObject:[userInfo valueForKey:@"club_uuid"] forKey:@"uuid"];
            
            ZCHomeViewController *vc= [[ZCHomeViewController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            self.window.rootViewController = nav;
            
            [vc.navigationController pushViewController:[[ZCRecordsOfConsumptionViewController alloc] init] animated:NO];
            
        }
        
    }
    
    
}
//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:  (NSDictionary *)userInfo fetchCompletionHandler:(void (^)   (UIBackgroundFetchResult))completionHandler {
    
    
    ZCLog(@"%ld",(long)application.applicationState);
    
    NSLog(@"this is iOS7 Remote Notification");
    
    if ((long)application.applicationState==0 ) {
        
        [self pushThepopUp:userInfo];
        
    }else{
    
        
        NSString *redirect_to = [userInfo valueForKey:@"redirect_to"];
        if ([redirect_to isEqual:@"tabs_list"]) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"uuid"];
            [defaults setObject:[userInfo valueForKey:@"club_uuid"] forKey:@"uuid"];
            
            ZCHomeViewController *vc= [[ZCHomeViewController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            self.window.rootViewController = nav;
            
            [vc.navigationController pushViewController:[[ZCRecordsOfConsumptionViewController alloc] init] animated:NO];
            
        }

        
    }
    
    
    
    
    
    
    
    
//    NSDictionary *aps = [userInfo valueForKey:@"aps"];
//    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
//    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
//    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
//    
//    // 取得自定义字段内容
//    NSString *customizeField1 = [userInfo valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
//    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
    
    
    
    
    
    // Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}




//点击确认按钮
-(void)pushThepopUp:(NSDictionary *)userInfo
{
    self.userInfo=userInfo;
    
    // 弹框
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"您有一笔消费单需要确认" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // 设置对话框的类型
    alert.alertViewStyle=UIKeyboardTypeNumberPad;
    
    [alert show];
    
}


#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        ZCLog(@"asdasda");
        //[self.navigationController popViewControllerAnimated:YES];
    }else
    {
        ZCLog(@"asdasda");
        [self confirmRequest];
    }
    
    // 按钮的索引肯定不是0
    
}



//确认消费
-(void)confirmRequest
{
    NSString *redirect_to = [self.userInfo valueForKey:@"redirect_to"];
    if ([redirect_to isEqual:@"tabs_list"]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"uuid"];
        [defaults setObject:[self.userInfo valueForKey:@"club_uuid"] forKey:@"uuid"];
        
        ZCHomeViewController *vc= [[ZCHomeViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
        
        [vc.navigationController pushViewController:[[ZCRecordsOfConsumptionViewController alloc] init] animated:NO];
        
    }
    
}







- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
    
    
//    //判断是否要上传ID
//    [ZCTool uploadThePushID];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *registrationID = [defaults objectForKey:@"registrationID"];
//    
//    //获取registrationID
//   NSString *registrationID1= [APService registrationID];
//    
//    if (![registrationID isEqual:registrationID1]) {
//        [defaults setObject:registrationID1 forKey:@"registrationID"];
//        [defaults setObject:@"yes" forKey:@"isYes"];
//        //[self uploadRegistrationID];
//    }
//    
//    ZCLog(@"%@",registrationID);
}





//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    // Required
//    [APService handleRemoteNotification:userInfo];
//}



//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    
//    // IOS 7 Support Required
//    [APService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}





//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    //设置用户的别名  账号 而且每个人不一样
//    [APService setAlias:@"137" callbackSelector:nil object:nil];
//    
//    //上传DeviceToken
//    [APService registerDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    // Required
//    [APService handleRemoteNotification:userInfo];
//}
////后台 真后台
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    // IOS 7 Support Required
//    //[APService handleRemoteNotification:userInfo];
//    
//    //代码块
//    //后台 还在继续运行  (下载  加载图片信息 -> 耗时 : 30)
//    completionHandler(UIBackgroundFetchResultNewData);
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //去掉右上角图标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
