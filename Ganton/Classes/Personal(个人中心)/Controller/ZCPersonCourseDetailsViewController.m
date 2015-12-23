//
//  ZCPersonCourseDetailsViewController.m
//  Ganton
//
//  Created by hh on 15/12/21.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonCourseDetailsViewController.h"

@interface ZCPersonCourseDetailsViewController ()<UIWebViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIView *view2;
@property(nonatomic,weak)UIView *view3;
@property(nonatomic,weak)UIButton *submitButton;

@end

@implementation ZCPersonCourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"课程详情";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    
    [self addControls];
}

// 添加控件
-(void)addControls
{
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    UIView *view1=[[UIView alloc] init];
    view1.frame=CGRectMake(0, 0, SCREEN_WIDTH, 80);
    view1.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:view1];
    [self addView1Controls:view1];
    
    UIView *view2=[[UIView alloc] init];
    view2.backgroundColor=[UIColor whiteColor];
    view2.frame=CGRectMake(0, 95, SCREEN_WIDTH, 80);
    [scrollView addSubview:view2];
    self.view2=view2;
    [self addView2Controls:view2];
    
    
   
    

    UIView *view3=[[UIView alloc] init];
    view3.frame=CGRectMake(0, 170, SCREEN_WIDTH, 100);
    view3.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:view3];
    self.view3=view3;
    [self addView3Controls:view3];
    
    UIButton *submitButton=[[UIButton alloc] init];
    submitButton.frame=CGRectMake((SCREEN_WIDTH-215)/2, 310, 215, 40);
    submitButton.backgroundColor=[UIColor colorWithPatternImage:[ZCTool imagePullLitre:@"pingjia_anniu"]];
    
    [submitButton setTitle:@"评价" forState:UIControlStateNormal];
    [scrollView addSubview:submitButton];
    self.submitButton=submitButton;

    
    
    
    

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
    
    self.view2.frame=CGRectMake(0, 95, SCREEN_WIDTH, 73+webViewHeight);
    self.view3.frame=CGRectMake(0, 95+webViewHeight+73+15, SCREEN_WIDTH, 100);
    self.submitButton.frame=CGRectMake((SCREEN_WIDTH-215)/2, self.view3.frame.origin.y+self.view3.frame.size.height+40, 215, 40);
    
    self.scrollView.contentSize=CGSizeMake(0, self.submitButton.frame.origin.y+self.submitButton.frame.size.height+70);
    
}



-(void)addView2Controls:(UIView *)view
{
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(15, 10, 100, 15);
    nameLabel.text=@"课程时间:";
    nameLabel.textColor=ZCColor(34, 34, 34);
    [view addSubview:nameLabel];
    
    UILabel *startLabel=[[UILabel alloc] init];
    startLabel.frame=CGRectMake(15, 33, 100, 15);
    startLabel.font=[UIFont systemFontOfSize:13];
    startLabel.textColor=ZCColor(85, 85, 85);
    startLabel.text=@"2015.12.16";
    [view addSubview:startLabel];
    
    
    UILabel *endLabel=[[UILabel alloc] init];
    endLabel.frame=CGRectMake(140, 33, 100, 15);
    endLabel.font=[UIFont systemFontOfSize:13];
    endLabel.textColor=ZCColor(85, 85, 85);
    endLabel.text=@"2015.12.16";
    [view addSubview:endLabel];

    
    UILabel *nameLabel2=[[UILabel alloc] init];
    nameLabel2.frame=CGRectMake(15, 56, 100, 15);
    nameLabel2.text=@"课程特色:";
    nameLabel2.textColor=ZCColor(34, 34, 34);
    [view addSubview:nameLabel2];
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, 73, SCREEN_WIDTH, 10);
    webView.delegate=self;
    [view addSubview:webView];
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    //    webView.scalesPageToFit = YES;
    //    [webView setScalesPageToFit:YES];
    [webView loadHTMLString:@"2013年12月11日 - Charles 中国特惠 Charles 正版五折优惠活动(限时:2015 年 11 月 14 日– 30 日),仅限中国区购买,点击购买。在活动期结束后,价格将从 169 元上涨到 199 元..." baseURL:nil];
    
}

-(void)addView1Controls:(UIView *)view
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=15;
    CGFloat personImageY=(view.frame.size.height-50)/2;
    CGFloat personImageW=50;
    CGFloat personImageH=50;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.layer.cornerRadius=5;//设置圆角的半径为10
    personImage.layer.masksToBounds=YES;
//    if ([ZCTool _valueOrNil:self.coachDetailsModel.portrait]==nil) {
//        personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
//    }else{
//        [personImage sd_setImageWithURL:[NSURL URLWithString:self.coachDetailsModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
//    }
    [view addSubview:personImage];
    personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=25;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.font=[UIFont systemFontOfSize:18];
    nameLabel.text=@"张三";
    [view addSubview:nameLabel];
    
    
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.textColor=ZCColor(85, 85, 85);
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.text=@"主教练";
    [view addSubview:titleLabel];
    //self.titleLabel=titleLabel;
    
    //    UILabel *genderLabel=[[UILabel alloc] init];
    //    CGFloat  genderLabelX=nameLabelX+nameLabelW+30;
    //    CGFloat  genderLabelY=nameLabelY+10;
    //    CGFloat  genderLabelW=40;
    //    CGFloat  genderLabelH=30;
    //    genderLabel.frame=CGRectMake(genderLabelX, genderLabelY, genderLabelW, genderLabelH);
    //    genderLabel.text=[NSString stringWithFormat:@"%@",self.coachDetailsModel.gender];
    //    [view addSubview:genderLabel];
    //self.genderLabel=genderLabel;
    
    
}


-(void)addView3Controls:(UIView *)view
{
    UILabel *typeLabel=[[UILabel alloc] init];
    typeLabel.frame=CGRectMake(0, 24, view.frame.size.width, 15);
    typeLabel.text=@"请对本次课程进行评价";
    typeLabel.textAlignment=NSTextAlignmentCenter;
    typeLabel.textColor=ZCColor(85, 85, 85);
    [view addSubview:typeLabel];
    
   
    
    for (int i=0; i<5; i++) {
        
        CGFloat X=(view.frame.size.width-(5*(29.5+10)))/2+i*(29.5+10);
        UIButton *button=[[UIButton alloc] init];
        button.tag=2000+i;
        button.frame=CGRectMake(X, 50, 29.5, 28);
        [button setImage:[UIImage imageNamed:@"xx_mr"] forState:UIControlStateNormal];
        [view addSubview:button];
        [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    }
  
}

//点击评价
-(void)clickTheButton:(UIButton *)button
{
    
    for (id view in self.view3.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *viewButton=view;
            if (viewButton.tag <button.tag || viewButton.tag ==button.tag) {
                
               [viewButton setImage:[UIImage imageNamed:@"xx_xz"] forState:UIControlStateNormal];
                
                
            }else{
              [viewButton setImage:[UIImage imageNamed:@"xx_mr"] forState:UIControlStateNormal];
                
            }
            
        }
    }
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
