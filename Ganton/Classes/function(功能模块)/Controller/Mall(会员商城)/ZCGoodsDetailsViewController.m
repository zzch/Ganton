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
@property(nonatomic,weak)UIScrollView *scrollView;
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
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=self.view.frame;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    CGFloat H=[ZCTool getFrame:CGSizeMake(SCREEN_WIDTH-60, 200) content:self.goodsDetailsDict[@"title"] fontSize:[UIFont systemFontOfSize:24]].size.height;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(30, 10, SCREEN_WIDTH-60, H);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.text=self.goodsDetailsDict[@"title"];
    nameLabel.font=[UIFont systemFontOfSize:24];
    nameLabel.numberOfLines=0;
    [scrollView addSubview:nameLabel];
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(5, H+5, SCREEN_WIDTH-10, 10);
    webView.delegate=self;
    [scrollView addSubview:webView];
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    NSString *newStr=[NSString stringWithFormat:@"<html><head><title>Example</title><style>img { width: 100%%}</style></head><body>%@</body></html>",self.goodsDetailsDict[@"content"]];
    [webView loadHTMLString:newStr baseURL:nil];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    
    CGFloat W=[webView.scrollView contentSize].width;
    ZCLog(@"%f",webViewHeight);
    CGFloat bei=(SCREEN_WIDTH)/W;
    NSString *str=[NSString stringWithFormat:@"document.body.style.zoom=%f",bei];
    [webView
     stringByEvaluatingJavaScriptFromString:str];
    
    self.scrollView.contentSize=CGSizeMake(0, webViewHeight+70);
    // self.scrollView.contentSize=CGSizeMake(0, webViewHeight+130);
    
    ZCLog(@"%f",webViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
