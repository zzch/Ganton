//
//  ZCYouZanViewController.m
//  Ganton
//
//  Created by hh on 16/2/26.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCYouZanViewController.h"
#import "YZSDK.h"
#import "YZUserModel.h"
#import "CacheUserInfo.h"
#import "CommonWebViewController.h"


/*页面的链接： 主要的事情多说几遍！！！！
 
 记住不要用短连接，短链接类似：http://kdt.im/......, 使用长连接，不然会多一次跳转https://wap.koudaitong.com/v2/showcase/homepage?alias=xxxxxx
 记住不要用短连接，短链接类似：http://kdt.im/......, 使用长连接，不然会多一次跳转https://wap.koudaitong.com/v2/showcase/homepage?alias=xxxxxx
 
 方式: 直接打开浏览器，输入短链接，打开的就是长链接地址
 方式: 直接打开浏览器，输入短链接，打开的就是长链接地址
 
 */
static NSString *homePageUrl = @"https://wap.koudaitong.com/v2/showcase/homepage?alias=5payljne";


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
/* 存在的问题，会员信息页面一定要记得先登录，登录只能从商品页面进入哦 【关键点】 【关键点】 【关键点】
 
 会员页面没登录不会做登陆回调事件！！！！
 会员页面没登录不会做登陆回调事件！！！！
 
 【我的购物记录】和【我的返现】里面因为有赞账号和三方账号没有打通，所以暂时还不能进行红包等等查看，我们已经在开发中了，敬请期待！！
 【我的购物记录】和【我的返现】里面因为有赞账号和三方账号没有打通，所以暂时还不能进行红包等等查看，我们已经在开发中了，敬请期待！！
 
 */



@interface ZCYouZanViewController ()<UIWebViewDelegate>
@property (weak, nonatomic)  UIWebView *webView;
@end

@implementation ZCYouZanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title=@"会员商城";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:webView];
    webView.delegate=self;
    self.webView=webView;
    
    
    
    [self loadRequestFromString:homePageUrl];
}
//因为同步信息有时间限制，精良保证在每次进入入口时，都重新registerYZUser
- (void) dealloc {
    CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
    cacheModel.isValid = NO;//重置为无效
}

//登陆 登陆账号和有赞交互  SDK 和  JS注入式相互登陆
- (void)loadRequestFromString:(NSString*)urlString {
    
    CacheUserInfo *cacheModel = [CacheUserInfo sharedManage];
    if(!cacheModel.isValid) {//无效的话 可以调用sdk的同步方法去同步信息，不会在webview中有多次交互的现象
        YZUserModel *userModel = [CacheUserInfo getYZUserModelFromCacheUserModel:cacheModel];
        //注意:只要调用接口，一定要记得appID和appSecret的值的设置
        [YZSDK registerYZUser:userModel callBack:^(NSString *message, BOOL isError) {
            if(isError) {
                cacheModel.isValid = NO;
            } else {
                cacheModel.isValid = YES;
                NSURL *url = [NSURL URLWithString:urlString];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
                [self.webView loadRequest:urlRequest];
            }
        }];
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];
    }
}


#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //    self.navigationItem.title = @"载入中...";
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView stringByEvaluatingJavaScriptFromString:[[YZSDK sharedInstance] jsBridgeWhenWebDidLoad]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}




/**
 *  页面监听请看这里
 *
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = [request URL];
    
    NSLog(@"测试url的链接数据:  %@ " , [url absoluteString]);
    
    if([[url absoluteString] isEqualToString:homePageUrl]) {//第一个页面加载
        
    }else if(![[url absoluteString] hasPrefix:@"http"]){//非http
        
        NSString *jsBridageString = [[YZSDK sharedInstance] parseYOUZANScheme:url];
        
        if(jsBridageString) {
            
            if([jsBridageString isEqualToString:CHECK_LOGIN]) {//首页面不涉及到登录  具体实现看commonVC
                
            } else if([jsBridageString isEqualToString:SHARE_DATA]) {
                
                NSDictionary * shareDic = [[YZSDK sharedInstance] shareDataInfo:url];
                NSString *message = [NSString stringWithFormat:@"title:%@ \\n 链接: %@ " , shareDic[SHARE_TITLE],shareDic[SHARE_LINK]];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"数据已经获取到了,赶紧来分享吧" message:message delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
                
            } else if([jsBridageString isEqualToString:WEB_READY]) {
               // self.navigationItem.rightBarButtonItem.enabled = YES;
//                if(_shareButton) {
//                    _shareButton.hidden = NO;
//                }
                
            } else if([jsBridageString isEqualToString:WX_PAY]) { //首页面不涉及到微信支付  具体实现看commonVC
            }
        }
    } else if ([[url absoluteString] hasSuffix:@"common/prefetching"]) {//加载静态资源 暂时先屏蔽
        return YES;
    } else {
        
        CommonWebViewController *commonWebViewViewController = [[CommonWebViewController alloc] init];
        commonWebViewViewController.commonWebViewUrl = [url absoluteString];
        [self.navigationController pushViewController:commonWebViewViewController animated:YES];
        
        return NO;
    }
    return YES;
}



@end
