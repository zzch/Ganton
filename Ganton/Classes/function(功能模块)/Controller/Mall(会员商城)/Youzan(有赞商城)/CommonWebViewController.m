//
//  CommonWebViewController.m
//  YouzaniOSDemo
//
//  Created by youzan on 15/11/6.
//  Copyright (c) 2015年 youzan. All rights reserved.
//

#import "CommonWebViewController.h"
#import "YZSDK.h"
//#import "LoginViewController.h"
#import "CacheUserInfo.h"

//返回参数函数处理
static NSString *CHECK_LOGIN = @"check_login";
static NSString *SHARE_DATA = @"share_data";
static NSString *WEB_READY = @"web_ready";
static NSString *WX_PAY = @"wx_pay";

//分享相关参数
static NSString *SHARE_TITLE = @"title";
static NSString *SHARE_LINK = @"link";
static NSString *SHARE_IMAGE_URL = @"img_url";
static NSString *SHARE_DESC = @"desc";


@interface CommonWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic)  UIWebView *commonWebView;
@property (strong, nonatomic) UIView *backView;
//@property (strong, nonatomic) UIButton *shareButton;
//@property (strong, nonatomic) UIBarButtonItem *navigationRightBarButtonItem;

@end

@implementation CommonWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIWebView *commonWebView=[[UIWebView alloc] init];
    commonWebView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:commonWebView];
    commonWebView.delegate=self;
    self.commonWebView=commonWebView;
    
    
    self.navigationItem.title = @"载入中...";
    
    [self initBackButton];
    _commonWebView.delegate = self;
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:_backView];
    leftBar.style = UIBarButtonItemStylePlain;
    
    
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7) {
         UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
                negativeSpacer.width = -10;
                self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBar];
            }else{
                self.navigationItem.leftBarButtonItem = leftBar;
            }

    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self loadRequestFromString:_commonWebViewUrl];
    
//    _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
//    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_shareButton addTarget:self action:@selector(sharePage) forControlEvents:UIControlEventTouchUpInside];
//    _shareButton.tag = 10001;
//    
//    _navigationRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_shareButton];
//    NSDictionary* textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
//    _navigationRightBarButtonItem.enabled = NO;
//    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    
    //self.navigationItem.rightBarButtonItem = _navigationRightBarButtonItem;
    
    //_shareButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRequestFromString:(NSString*)urlString {
    
    CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
    if(!cacheModel.isValid) {
        
        YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
        [YZSDK registerYZUser:userModel callBack:^(NSString *message, BOOL isError) {
            if(isError) {
                cacheModel.isValid = NO;
            } else {
                cacheModel.isValid = YES;
                NSURL *url = [NSURL URLWithString:urlString];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
                [self.commonWebView loadRequest:urlRequest];
            }
        }];
    } else {
        cacheModel.isValid = YES;
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.commonWebView loadRequest:urlRequest];
    }
}
- (void)initBackButton {
    
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 50, 44)];
   // [self.view addSubview:_backView];
    
    UIButton *sysButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [sysButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [sysButton setTitle:@" 返回" forState:UIControlStateNormal];
    [sysButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sysButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    sysButton.titleLabel.font=[UIFont systemFontOfSize:16];
    sysButton.tag = 10001;
    
    [_backView addSubview:sysButton];
    
   
    

}

/**
 *  如果您想使用返回和关闭，一定记得在这里实现，回退时修改backView，然后添加关闭按钮，可以参照微信的实现哦
 */
- (void)backButtonPressed:(UIButton *)button {
    if ([_commonWebView canGoBack] && button.tag == 10001) {
        [_commonWebView goBack];
    } else {
        [self.navigationController  popViewControllerAnimated:YES];
    }
    
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
    self.navigationItem.title = [self.commonWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.commonWebView stringByEvaluatingJavaScriptFromString:[[YZSDK sharedInstance] jsBridgeWhenWebDidLoad]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    
   if(![[url absoluteString] hasPrefix:@"http"]){//非http
        
        NSString *jsBridageString = [[YZSDK sharedInstance] parseYOUZANScheme:url];
        
        if(jsBridageString) {
            
            CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
            if([jsBridageString isEqualToString:CHECK_LOGIN] && !cacheModel.isValid) {

                if(cacheModel.isLogined) {//【如果是您是先登录，在打开我们商城，走这种方式】
                    YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
                    NSString *string = [[YZSDK sharedInstance] webUserInfoLogin:userModel];
                    [self.commonWebView stringByEvaluatingJavaScriptFromString:string];
                    return YES;
                }
                //【如果您需要使用自己原生的登录，看这里的代码】
//               UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                UINavigationController *navigation = [board instantiateViewControllerWithIdentifier:@"loginnav"];
//                LoginViewController *loginVC = [navigation.viewControllers objectAtIndex:0];
//                loginVC.loginBlock = ^(CacheUserInfo *cacheModel) {
//                    NSString *string = [[YZSDK sharedInstance] webUserInfoLogin:[CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel]];
//                    [self.commonWebView stringByEvaluatingJavaScriptFromString:string];
//                };
//                [self presentViewController:navigation animated:YES completion:^{
//                    
//                }];
                return NO;
                
            } else if([jsBridageString isEqualToString:SHARE_DATA]) {//【分享请看这里】
                
                NSDictionary * shareDic = [[YZSDK sharedInstance] shareDataInfo:url];
                NSString *message = [NSString stringWithFormat:@"title:%@ \\n 链接: %@ " , shareDic[SHARE_TITLE],shareDic[SHARE_LINK]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据已经获取到了,赶紧来分享吧" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
                
            } else if([jsBridageString isEqualToString:WEB_READY]) {
                
//                self.navigationItem.rightBarButtonItem.enabled = YES;
//                _shareButton.hidden = NO;
                
            } else if ([[url absoluteString] hasSuffix:@"common/prefetching"]) {//加载静态资源 暂时先屏蔽
                
                return YES;
                
            }  else if([jsBridageString isEqualToString:WX_PAY]) { //【微信支付暂时用的有赞wap微信支付，我们给您的链接已经包含了微信支付所有信息，直接可以唤起您手机上的微信，进行支付，分享之后因为不是走微信注册的模式，所以无法直接返回您的App，详细可以看文档说明】
                
                //如果是微信自有支付或者app支付，现在基本没有商户在使用app支付了，因此这里默认是微信自有支付
                
                [YZSDK selfWXPayURL:url callback:^(NSDictionary *response, NSError *error) {
                   
                    //返回的是一个包含微信支付的字典，取出微信支付相对应的参数
                    /*
                    PayReq* req  = [[PayReq alloc] init];
                    req.openID   = response[@"response"][@"appid"];
                    req.partnerId  = response[@"response"][@"partnerid"];
                    req.prepayId  = response[@"response"][@"prepayid"];
                    req.nonceStr  = response[@"response"][@"noncestr"];
                    req.timeStamp   = (unsigned int)[response[@"response"][@"timestamp"] longValue];
                    req.package  = response[@"response"][@"package"];
                    req.sign   = response[@"response"][@"sign"];
                    [WXApi sendReq:req]; */
                }];
            }
        }
   } else {
      // _shareButton.hidden = YES;//进入新的链接后，记得隐藏分享按钮，等到下个页面完全打开(获取webready后显示)
   }
    return YES;
}

- (void) sharePage {//【分享是被动的，所以要给出点击事件进行触发】
    NSString *jsonString = [[YZSDK sharedInstance] jsBridgeWhenShareBtnClick];
    [self.commonWebView stringByEvaluatingJavaScriptFromString:jsonString];
    
}

@end
