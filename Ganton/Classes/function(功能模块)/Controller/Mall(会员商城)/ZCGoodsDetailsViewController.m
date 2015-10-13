//
//  ZCGoodsDetailsViewController.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCGoodsDetailsViewController.h"

@interface ZCGoodsDetailsViewController ()

@end

@implementation ZCGoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"详情";
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
