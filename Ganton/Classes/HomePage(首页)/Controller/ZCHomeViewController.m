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
#import "ZCAnnouncementView.h"
#import "ZCHomeModel.h"
#import "ZCMemberModel.h"
#import "ZCAnnouncementModel.h"
#import "ZCAnnouncementViewController.h"
@interface ZCHomeViewController ()<UIScrollViewDelegate,ZCCardPackageViewControllerDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)ZCHomeModel *homeModel;

@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"首页";
    self.view.backgroundColor=ZCColor(239, 239, 244);
    
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"window" hightImageName:nil action:@selector(clickTheRightBarButtonItem) target:self withBtnName:nil];
    
    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"卡包" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRightBarButtonItem)];
    
    //self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"个人" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheLiftBarButtonItem)];
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"user-profile" hightImageName:nil action:@selector(clickTheLiftBarButtonItem) target:self withBtnName:nil];
    
    [self addData];
    
}


// 网络加载
-(void)addData
{
    //[MBProgressHUD showMessage:@"数据加载中..."];
    
    
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/clubs/home",API];
    
    //[MBProgressHUD showMessage:@"数据加载中..."];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        ZCHomeModel *homeModel=[ZCHomeModel homeModelWithDict:responseObject];
        self.homeModel=homeModel;
        
        
        //移除
       // [MBProgressHUD hideHUD];
        [self addControls];
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
        //移除
       // [MBProgressHUD hideHUD];
    }];

}



-(void)clickTheOtherCardWithcardPackageViewController:(ZCCardPackageViewController *)cardPackageViewController
{
    
     ZCLog(@"%lu",(unsigned long)self.view.subviews.count);
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    

    [self addData];
    
    
     ZCLog(@"%lu",(unsigned long)self.view.subviews.count);
}


//添加控件
-(void)addControls
{
    //移除
    [MBProgressHUD hideHUD];
    
      self.automaticallyAdjustsScrollViewInsets = NO;

    //公告背景条
    UIView *noticeView=[[UIView alloc] init];
    noticeView.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);
    noticeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:noticeView];
    
    
    
    UILabel *weatherLabel=[[UILabel alloc] init];
    weatherLabel.frame=CGRectMake(0, 0, 90, 40);
    weatherLabel.text=[NSString stringWithFormat:@"%@ %@ ℃",[ZCTool JudgmentIsWhichDay:self.homeModel.date],self.homeModel.maximum_temperature ];
    weatherLabel.font=[UIFont systemFontOfSize:14];
    weatherLabel.textAlignment=NSTextAlignmentCenter;
    [noticeView addSubview:weatherLabel];

    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(90, 5, 1, 30);
    bjView.backgroundColor=ZCColor(240, 240, 240);
    [noticeView addSubview:bjView];
    
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake(100, 14, 18, 12.5);
    imageView.image=[UIImage imageNamed:@"shouye_laba_icon"];
    [noticeView addSubview:imageView];

    
    ZCAnnouncementView *textLabel=[[ZCAnnouncementView alloc] init];
    textLabel.frame=CGRectMake(128, 0, self.view.frame.size.width-128-6-10, 40);
    [noticeView addSubview:textLabel];
    textLabel.announcements=self.homeModel.announcements;
    
    UIImageView *rightImage=[[UIImageView alloc] init];
    rightImage.frame=CGRectMake(self.view.frame.size.width-6-10, 14.5, 6, 11);
    rightImage.image=[UIImage imageNamed:@"shouye_arrow_icon"];
    [noticeView addSubview:rightImage];
    
    
    
    //监听 公告
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(128, 0, self.view.frame.size.width-128, 40);
    [noticeView addSubview:button];
    [button addTarget:self action:@selector(clickThetextLabel) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 50, self.view.frame.size.width, SCREEN_HEIGHT*0.34);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    //int index=3;
    
    for (int i=0; i<self.homeModel.members.count; i++) {
        UIView *imageView=[[UIView alloc] init];
        //imageView.backgroundColor=[UIColor yellowColor];
        imageView.layer.cornerRadius=5;
        imageView.layer.masksToBounds=YES;
        
        
        
        imageView.frame=CGRectMake(i*self.view.frame.size.width+10, 0, self.view.frame.size.width-20, SCREEN_HEIGHT*0.34);
        [self.scrollView addSubview:imageView];
        
        [self addControlsForCard:imageView andData:self.homeModel.members[i]];
        
        self.scrollView.contentSize=CGSizeMake((i+1)*self.view.frame.size.width, 0);
        
    }
    
    
    UIView *PageControlView=[[UIView alloc] init];
    PageControlView.frame=CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height, self.view.frame.size.width, 23);
   // PageControlView.backgroundColor=[UIColor redColor];
    [self.view addSubview:PageControlView];
    [self setupPageControl:PageControlView];
    
    
    
    
   
    
    
    
    UIView *lastView=[[UIView alloc] init];
    CGFloat Y=scrollView.frame.size.height+scrollView.frame.origin.y+23;
    lastView.backgroundColor=ZCColor(240, 240, 240);
    lastView.frame=CGRectMake(0, Y, self.view.frame.size.width, self.view.frame.size.height-Y);
    
    [self.view addSubview:lastView];
    
    //九宫格算法
    
    
    int totalColumns = 3;
    // 1.数字的尺寸
    CGFloat appW = (self.view.frame.size.width-2)/3;
    CGFloat appH=(lastView.frame.size.height-1)/2;
    
    //间隙
    CGFloat marginX = 1;
    CGFloat marginY = 1;

    
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
            
            [self addControlsWithButton:button andImage:@"shouye_yuyue_icon" andName:@"打位预约"];

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





/**
 *  添加pageControl
 */
- (void)setupPageControl:(UIView *)view
{
    if (self.homeModel.members.count==1) {
        return ;
    }else{
    
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.homeModel.members.count;
    CGFloat centerX = view.frame.size.width * 0.5;
    CGFloat centerY = view.frame.size.height*0.5 ;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 23);
    pageControl.userInteractionEnabled = NO;
    [view addSubview:pageControl];
    self.pageControl = pageControl;
    //pageControl.backgroundColor=[UIColor redColor];
    
//    // 2.设置圆点的颜色
//    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shouye_xuanzhong_icon"]];
//    pageControl.pageIndicatorTintColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"shouye_moren_icon"]];
    
    
        // 2.设置圆点的颜色
        pageControl.currentPageIndicatorTintColor = ZCColor(102, 102, 102);
        pageControl.pageIndicatorTintColor = ZCColor(203, 203, 203);
    }
}

/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
    
    //    if (pageInt==2) {
    //        self.pageControl.hidden=YES ;
    //    }else
    //    {
    //        self.pageControl.hidden=NO;
    //    }
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




-(void)addControlsForCard:(UIView *)view andData:(ZCMemberModel *)memberModel
{
    
    
//    unsigned result=0;
//    NSScanner *scanner=[NSScanner scannerWithString:memberModel.background_color];
//    [scanner setScanLocation:1];
//    [scanner scanHexInt:&result];
    view.backgroundColor=[ZCTool colorWithHexString:memberModel.background_color];
    
    
    UIImageView *logoImage=[[UIImageView alloc] init];
    CGFloat logoImageX=20;
    CGFloat logoImageY=20;
    CGFloat logoImageW=23;
    CGFloat logoImageH=32;
    logoImage.frame=CGRectMake(logoImageX, logoImageY, logoImageW, logoImageH);
    if ([ZCTool _valueOrNil:self.homeModel.logo]==nil) {
        
    }else{
    [logoImage sd_setImageWithURL:[NSURL URLWithString:self.homeModel.logo] placeholderImage:nil ];
    }
    
    
    [view addSubview:logoImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=logoImageX+logoImageW+10;
    CGFloat nameLabelY=logoImageY;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=30;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=self.homeModel.name;
    nameLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    nameLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:nameLabel];
    
    UILabel *cardName=[[UILabel alloc] init];
    CGFloat cardNameW=view.frame.size.width;
    CGFloat cardNameH=30;
    CGFloat cardNameX=0;
    CGFloat cardNameY=(view.frame.size.height-cardNameH)/2;
    cardName.frame=CGRectMake(cardNameX, cardNameY, cardNameW, cardNameH);
    cardName.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    cardName.font=[UIFont systemFontOfSize:24];
    cardName.textAlignment=NSTextAlignmentCenter;
    cardName.text=memberModel.name;
    [view addSubview:cardName];
    
    
    
    
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:memberModel.expired_at];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];

    
    //有效期 expired_at
    UILabel *periodLabel=[[UILabel alloc] init];
    CGFloat periodLabelX=20;
    CGFloat periodLabelY=view.frame.size.height-60;
    CGFloat periodLabelW=200;
    CGFloat periodLabelH=30;
    periodLabel.frame=CGRectMake(periodLabelX, periodLabelY, periodLabelW, periodLabelH);
    periodLabel.text=[NSString stringWithFormat:@"有效期: %@",nowDateString ];
    periodLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    periodLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:periodLabel];
    
    
    UILabel *remainingLabel=[[UILabel alloc] init];
    CGFloat remainingLabelX=view.frame.size.width-170;
    CGFloat remainingLabelY=view.frame.size.height-60;
    CGFloat remainingLabelW=150;
    CGFloat remainingLabelH=30;
    remainingLabel.frame=CGRectMake(remainingLabelX, remainingLabelY, remainingLabelW, remainingLabelH);
    remainingLabel.textAlignment=NSTextAlignmentRight;
    remainingLabel.text=[NSString stringWithFormat:@"余额: %@",memberModel.balance];
    remainingLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    remainingLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:remainingLabel];
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(20, view.frame.size.height-29, view.frame.size.width-40, 0.5);
    bjView.backgroundColor=[UIColor whiteColor];
    [view addSubview:bjView];
    
    
    
    UILabel *numberLabel=[[UILabel alloc] init];
    CGFloat numberLabelX=20;
    CGFloat numberLabelY=view.frame.size.height-28;
    CGFloat numberLabelW=300;
    CGFloat numberLabelH=28;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    numberLabel.text=[NSString stringWithFormat:@"NO: %@",memberModel.number];
    numberLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:numberLabel];
    
    
    

}




-(void)clickTheButton:(UIButton *)button
{
    if (button.tag==100) {
        
        ZCReservationViewController *VC=[[ZCReservationViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
       }else if (button.tag==101){
           
        ZCTeachingViewController *VC=[[ZCTeachingViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    
    }else if (button.tag==102){
        
        ZCMallViewController *VC=[[ZCMallViewController alloc] init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
