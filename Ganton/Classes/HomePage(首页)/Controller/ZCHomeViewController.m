//
//  ZCHomeViewController.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCHomeViewController.h"
#import "ZCReservationViewController.h"
#import "ZCCardPackageViewController.h"
#import "ZCTeachingViewController.h"
#import "ZCRecordsOfConsumptionViewController.h"
#import "ZCMallViewController.h"
#import "ZCRestaurantViewController.h"
#import "ZCOpinionViewController.h"
#import "ZCPersonalViewController.h"

#import "ZCHomeModel.h"
#import "ZCMemberModel.h"
#import "ZCAnnouncementModel.h"
#import "ZCAnnouncementViewController.h"
#import "ZCYouZanViewController.h"

#import "ZCMembershipCardView.h"
#import "ZCNoticeView.h"
#import "ZCScrollCardView.h"
#import "ZCPayByCardController.h"

@interface ZCHomeViewController ()<UIScrollViewDelegate,ZCCardPackageViewControllerDelegate,ZCScrollCardViewDelegate>

@property(nonatomic,strong)ZCHomeModel *homeModel;


@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"首页";
    self.view.backgroundColor=ZCColor(239, 239, 244);
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"window" hightImageName:nil action:@selector(clickTheRightBarButtonItem) target:self withBtnName:nil];
    
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"user-profile" hightImageName:nil action:@selector(clickTheLiftBarButtonItem) target:self withBtnName:nil];
    
     //self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addOnlineData];
    
   
    
}





// 网络加载
-(void)addOnlineData
{
   // [MBProgressHUD showMessage:@"加载中"];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/clubs/home",API];
    ZCLog(@"%@",token);
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        //移除
       // [MBProgressHUD hideHUD];
        ZCLog(@"%@",responseObject);
        
        ZCHomeModel *homeModel=[ZCHomeModel homeModelWithDict:responseObject];
        self.homeModel=homeModel;
        
        
        
        [self addControls];
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
        //移除
       // [MBProgressHUD hideHUD];
    }];

}


//代理方法 切换球场
-(void)clickTheOtherCardWithcardPackageViewController:(ZCCardPackageViewController *)cardPackageViewController
{
    
     ZCLog(@"%lu",(unsigned long)self.view.subviews.count);
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    

    [self addOnlineData];
    
    
     ZCLog(@"%lu",(unsigned long)self.view.subviews.count);
}







//添加控件
-(void)addControls
{
    
    ZCScrollCardView *scrollView=[[ZCScrollCardView alloc] init];
    scrollView.frame=CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT*0.34);
    scrollView.delegate=self;
    scrollView.homeModel=self.homeModel;
    [self.view addSubview:scrollView];
    
    
    UIView *widthXian=[[UIView alloc] init];
    widthXian.frame=CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height, self.view.frame.size.width, 0.5);
    widthXian.backgroundColor=[ZCTool colorWithHexString:@"#484848"];
    [self.view addSubview:widthXian];

    //公告背景条
    ZCNoticeView *noticeView=[[ZCNoticeView alloc] init];
    noticeView.frame=CGRectMake(0, SCREEN_HEIGHT*0.34+0.5, self.view.frame.size.width, 54);
    noticeView.backgroundColor=ZCColor(43, 45, 46);
    noticeView.homeModel=self.homeModel;
    [self.view addSubview:noticeView];
    
    //监听 公告
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(128, 0, self.view.frame.size.width-128, 39.5);
    [noticeView addSubview:button];
    [button addTarget:self action:@selector(clickThetextLabel) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lastView=[[UIView alloc] init];
    CGFloat Y=noticeView.frame.size.height+noticeView.frame.origin.y;
    lastView.backgroundColor=ZCColor(211, 211, 211);
    lastView.frame=CGRectMake(0, Y, self.view.frame.size.width, self.view.frame.size.height-Y);
    
    [self.view addSubview:lastView];
    
    //九宫格算法
    
    
    int totalColumns = 3;
    // 1.数字的尺寸
    CGFloat appW = (self.view.frame.size.width-1)/3;
    CGFloat appH=(lastView.frame.size.height-0.5)/2;
    
    //间隙
    CGFloat marginX = 0.5;
    CGFloat marginY = 0.5;

    
    for (int j=0; j<6; j++) {
        
        UIButton *button=[[UIButton alloc] init];
        button.backgroundColor=[UIColor whiteColor];
        button.tag=100+j;
        // 计算行号和列号
        int row = j / totalColumns;
        int col = j % totalColumns;
        
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);

         button.frame = CGRectMake(appX, appY, appW, appH);
        
        [lastView addSubview:button];
        
        
        [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        if (j==0) {
            
            [self addControlsWithButton:button andImage:@"yuyue" andName:@"打位预约"];

        }else if (j==1)
        {
            [self addControlsWithButton:button andImage:@"shouye_jiaolian_icon" andName:@"教练教学"];

        }else if (j==2)
        {
            [self addControlsWithButton:button andImage:@"shouye_shangcheng_icon" andName:@"会员商城"];
            
        }else if (j==3)
        {
            [self addControlsWithButton:button andImage:@"shouye_xiaofei_icon" andName:@"消费记录"];
        }else if (j==4)
        {
            [self addControlsWithButton:button andImage:@"shouye_canyin_icon" andName:@"餐饮服务"];
            
        }else if (j==5)
        {
            [self addControlsWithButton:button andImage:@"shouye_yijian_icon" andName:@"意见反馈"];
            
        }
        
    }
    
    ZCLog(@"%f",SCREEN_HEIGHT);
}


-(void)addControlsWithButton:(UIButton *)button andImage:(NSString *)image andName:(NSString *)nameStr
{
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW;
    CGFloat imageViewH;
   //CGFloat imageViewY;
    
    if (SCREEN_HEIGHT==480) {
        imageViewW=45;
        imageViewH=45;
        
    }else{
        imageViewW=59;
        imageViewH=59;
    }
    CGFloat imageViewX=(button.frame.size.width-imageViewW)/2;
    CGFloat imageViewY=(button.frame.size.height-imageViewH-30)/3+10;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:image];
    [button addSubview:imageView];
    
    
    UILabel *textLabel=[[UILabel alloc] init];
    CGFloat textLabelX=0;
    CGFloat textLabelY=2*imageViewY+imageViewH-10;
    CGFloat textLabelW=button.frame.size.width;
    CGFloat textLabelH=20;
    textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
    textLabel.text=nameStr;
    textLabel.textAlignment=NSTextAlignmentCenter;
    textLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:textLabel];
    

}




//点击按钮
-(void)clickTheButton:(UIButton *)button
{
    if (button.tag==100) {
        
        ZCReservationViewController *VC=[[ZCReservationViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
       }else if (button.tag==101){
           
        ZCTeachingViewController *VC=[[ZCTeachingViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    
    }else if (button.tag==102){
        ZCYouZanViewController *VC=[[ZCYouZanViewController alloc] init];
//        ZCMallViewController *VC=[[ZCMallViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (button.tag==103){
       
        ZCRecordsOfConsumptionViewController *VC=[[ZCRecordsOfConsumptionViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];

     }else if (button.tag==104){
         
         ZCRestaurantViewController *VC=[[ZCRestaurantViewController alloc] init];
         [self.navigationController pushViewController:VC animated:YES];
         
    }else if (button.tag==105){
        
        ZCOpinionViewController *VC=[[ZCOpinionViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    

}

//zcscrollCardView的代理方法
-(void)scrollCardView:(UIView *)view clickTheCardUuid:(NSString *)uuid
{
    ZCPayByCardController *vc=[[ZCPayByCardController alloc] init];
    vc.uuid=uuid;
    [self.navigationController pushViewController:vc animated:YES];
    
    ZCLog(@"%@",uuid);
}




//点击右上角按钮
-(void)clickTheRightBarButtonItem
{
    ZCCardPackageViewController *vc=[[ZCCardPackageViewController alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}


//点击左上角按钮
-(void)clickTheLiftBarButtonItem
{
    ZCPersonalViewController *vc=[[ZCPersonalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}


-(void)clickThetextLabel
{
    ZCAnnouncementViewController *vc=[[ZCAnnouncementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
