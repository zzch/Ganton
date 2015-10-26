//
//  ZCViewsOnContentViewController.m
//  Ganton
//
//  Created by hh on 15/10/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCViewsOnContentViewController.h"
#import "DCTextView.h"
@interface ZCViewsOnContentViewController ()
@property(nonatomic,weak)DCTextView *content;
@end

@implementation ZCViewsOnContentViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"反馈内容";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
   // self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRightBarButtonItem)];
    
    
    //看这个UIViewController的这个属性你就明白了，此属性默认为YES，这样UIViewController下如果只有一个UIScollView或者其子类，那么会自动留出空白，让scollview滚动经过各种bar下面时能隐约看到内容。但是每个UIViewController只能有唯一一个UIScollView或者其子类，如果超过一个，需要将此属性设置为NO,自己去控制留白以及坐标问题。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    DCTextView *content = [[DCTextView alloc] init];
    CGFloat contentX = 10;
    CGFloat contentY =  10;
    CGFloat contentW = SCREEN_WIDTH - 2*contentX;
    CGFloat contentH = 276/2;
    content.frame = CGRectMake(contentX, contentY, contentW, contentH);
    
    content.font=[UIFont systemFontOfSize:18];
    content.backgroundColor = [UIColor whiteColor];
    content.placehoder=@"输入您的建议...";
    [self.view addSubview:content];
    self.content=content;
    
    
    
    UIButton *button=[[UIButton alloc] init];
    CGFloat buttonW=215;
    CGFloat buttonH=40;
    CGFloat buttonX=(SCREEN_WIDTH-buttonW)/2;
    CGFloat buttonY=contentY+contentH+37;
    button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
    button.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"yjfk_anniu"]];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickTheRightBarButtonItem) forControlEvents:UIControlEventTouchUpInside];
    
    
}

//点击提交
-(void)clickTheRightBarButtonItem
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    params[@"content"]=self.content.text;
    NSString *URL=[NSString stringWithFormat:@"%@v1/feedbacks",API];
    
    
    [ZCTool postWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        [MBProgressHUD showSuccess:@"意见提交成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
    
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
