//
//  ZCGoodsDetailsViewController.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCGoodsDetailsViewController.h"

@interface ZCGoodsDetailsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)NSDictionary *goodsDetailsDict;
@end

@implementation ZCGoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"详情";
    
    [self addData];
    
    
}

//添加数据
-(void)addData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *club_uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=club_uuid;
    params[@"uuid"]=self.uuid;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/promotions/detail",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        self.goodsDetailsDict=responseObject;
        
        [self addControls];
    } failure:^(NSError *error) {
        
    }];


}


-(void)addControls
{
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.text=self.goodsDetailsDict[@"title"];
    nameLabel.font=[UIFont systemFontOfSize:24];
    [self.view addSubview:nameLabel];
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, 50, SCREEN_WIDTH, 10);
    webView.delegate=self;
    [self.view addSubview:webView];
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    [webView loadHTMLString:self.goodsDetailsDict[@"content"] baseURL:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    // self.scrollView.contentSize=CGSizeMake(0, webViewHeight+130);
    
    ZCLog(@"%f",webViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
