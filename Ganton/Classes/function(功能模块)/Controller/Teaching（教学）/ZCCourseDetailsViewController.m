//
//  ZCCourseDetailsViewController.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCourseDetailsViewController.h"
#import "ZCCourseDetailsModel.h"
@interface ZCCourseDetailsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)ZCCourseDetailsModel *courseDetailsModel;
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation ZCCourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"课程详情";
    
    
    [self addData];
}


// 网络加载
-(void)addData
{
    [MBProgressHUD showMessage:@"数据加载中..."];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    params[@"uuid"]=self.uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/courses/detail",API];
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        self.courseDetailsModel=[ZCCourseDetailsModel courseDetailsModelWithDict:responseObject];
        
       
        [self addControls];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
    
}



-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=self.view.frame;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 100);
    topView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:topView];
    [self addTopViewControls:topView];
    
    
//    UIView *middleView=[[UIView alloc] init];
//    middleView.frame=CGRectMake(0, 264, SCREEN_WIDTH, 100);
//    [self.view addSubview:middleView];
//    [self addMiddleViewControls:middleView];
//    
//    UIView *lastView=[[UIView alloc] init];
//    lastView.frame=CGRectMake(0, 370, SCREEN_WIDTH, 100);
//    [self.view addSubview:lastView];
//    [self addLastViewControls:lastView];
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, topView.frame.size.height+topView.frame.origin.y+15, SCREEN_WIDTH, 200);
     webView.delegate=self;
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    //webView.backgroundColor=[UIColor redColor];
    //[webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.description] baseURL:nil];
    [scrollView addSubview:webView];
    [webView loadHTMLString:[NSString stringWithFormat:@"%@",self.courseDetailsModel.Description] baseURL:nil];

}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    self.scrollView.contentSize=CGSizeMake(0, webViewHeight+130);
    
    ZCLog(@"%f",webViewHeight);
}


-(void)addTopViewControls:(UIView *)view
{

    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(18, 12, 200, 20);
    nameLabel.text=[NSString stringWithFormat:@"课程名称: %@",self.courseDetailsModel.name];
    nameLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:nameLabel];
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(18, 40, 200, 20);
    timeLabel.text=[NSString stringWithFormat:@"有效期: %@个月",self.courseDetailsModel.valid_months ];
    timeLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:timeLabel];
    
    UILabel *modelLabel=[[UILabel alloc] init];
    modelLabel.frame=CGRectMake(18, 68, 200, 20);
    modelLabel.text=[NSString stringWithFormat:@"授课形式: 1对%@",self.courseDetailsModel.maximum_students ];
    modelLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:modelLabel];
    
    
    UILabel *money=[[UILabel alloc] init];
    CGFloat moneyW=[ZCTool getFrame:CGSizeMake(300, 20) content:self.courseDetailsModel.price fontSize:[UIFont systemFontOfSize:22]].size.width;
    CGFloat moneyH=20;
    CGFloat moneyX=SCREEN_WIDTH-moneyW-15;
    CGFloat moneyY=view.frame.size.height-20-12;
    money.frame=CGRectMake(moneyX, moneyY, moneyW, moneyH);
    money.text=[NSString stringWithFormat:@"%@", self.courseDetailsModel.price];
    money.font=[UIFont systemFontOfSize:22];
    money.textColor=[UIColor redColor];
    [view addSubview:money];
    
    UILabel *fuhaoLabel=[[UILabel alloc] init];
    CGFloat fuhaoLabelX=moneyX-12;
    CGFloat fuhaoLabelY=view.frame.size.height-12-10;
    fuhaoLabel.frame=CGRectMake(fuhaoLabelX, fuhaoLabelY, 12, 8);
    fuhaoLabel.text=@"￥";
    fuhaoLabel.textColor=[UIColor redColor];
    fuhaoLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:fuhaoLabel];
    
    
    
}



-(void)addMiddleViewControls:(UIView *)view
{
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(10, 10, 100, 30);
    nameLabel.text=@"课程特色:";
    [view addSubview:nameLabel];
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.frame=CGRectMake(10, 30, SCREEN_WIDTH-20, 80);
    textLabel.text=self.courseDetailsModel.Description;
    textLabel.numberOfLines=0;
    [view addSubview:textLabel];

}


-(void)addLastViewControls:(UIView *)view
{
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(10, 10, 100, 30);
    nameLabel.text=@"适用人群:";
    [view addSubview:nameLabel];
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.frame=CGRectMake(10, 30, SCREEN_WIDTH-20, 80);
    textLabel.text=@"适用人群适用人群适用人群适用人群适用人群适用人群适用人群适用人群适用人群适用人群适用人群适用人群适用人群";
    textLabel.numberOfLines=0;
    [view addSubview:textLabel];
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
