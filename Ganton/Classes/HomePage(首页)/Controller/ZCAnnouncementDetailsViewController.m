//
//  ZCAnnouncementDetailsViewController.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnnouncementDetailsViewController.h"

@interface ZCAnnouncementDetailsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)NSDictionary *detailsDict;
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation ZCAnnouncementDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title=@"公告详情";
    
    [self onlineData];
    
    
    
}

//网络加载
-(void)onlineData
{
    [MBProgressHUD showMessage:@"数据加载中..."];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=token;
    params[@"club_uuid"]=[defaults objectForKey:@"uuid"];;
    params[@"uuid"]=self.uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/announcements/detail",API];
    ZCLog(@"%@",self.uuid);
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        self.detailsDict=responseObject;
        
        [self addControls];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        ZCLog(@"%@",error);
    }];

    

}

-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=self.view.frame;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(0, 15, SCREEN_WIDTH, 50);
    nameLabel.textAlignment=NSTextAlignmentCenter;
    nameLabel.text=self.detailsDict[@"title"];
    nameLabel.font=[UIFont systemFontOfSize:24];
    [scrollView addSubview:nameLabel];
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, 65, SCREEN_WIDTH, 10);
    webView.delegate=self;
    [scrollView addSubview:webView];
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
//    webView.scalesPageToFit = YES;
//    [webView setScalesPageToFit:YES];
    [webView loadHTMLString:self.detailsDict[@"content"] baseURL:nil];
    
    
    
}





- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
   // self.scrollView.contentSize=CGSizeMake(0, webViewHeight+130);
    CGFloat W=[webView.scrollView contentSize].width;
    ZCLog(@"%f",webViewHeight);
    CGFloat bei=(SCREEN_WIDTH)/W;
    NSString *str=[NSString stringWithFormat:@"document.body.style.zoom=%f",bei];
    [webView
     stringByEvaluatingJavaScriptFromString:str];
    
    
    self.scrollView.contentSize=CGSizeMake(0, webViewHeight+70);
    
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
