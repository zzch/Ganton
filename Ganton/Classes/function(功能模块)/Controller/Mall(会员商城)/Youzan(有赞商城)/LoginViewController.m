//
//  LoginViewController.m
//  YouzaniOSDemo
//
//  Created by youzan on 15/11/6.
//  Copyright (c) 2015年 youzan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";

}

- (IBAction)cancleLoginViewController:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不登录不能打开商品详情噢" delegate:self cancelButtonTitle:@"不登录" otherButtonTitles:@"登录",nil];
    [alertView show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClick:(id)sender {
    
    CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];

    [self dismissViewControllerAnimated:YES completion:^{
        _loginBlock(cacheModel);
    }];
    
}

#pragma mark - alertdelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else if(buttonIndex == 1) {
        
        CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
        [self dismissViewControllerAnimated:YES completion:^{
            _loginBlock(cacheModel);
        }];
    }
}


@end
