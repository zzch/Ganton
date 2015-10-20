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
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"会员卡";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"卡包" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRightBarButtonItem)];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"个人" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheLiftBarButtonItem)];
    
    
    
    [self addData];
    
}


// 网络加载
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/clubs/home",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        ZCHomeModel *homeModel=[ZCHomeModel homeModelWithDict:responseObject];
        self.homeModel=homeModel;
        
        [self addControls];
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
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
      self.automaticallyAdjustsScrollViewInsets = NO;

    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 74, self.view.frame.size.width, 200);
    //scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    scrollView.pagingEnabled = YES;
    
    //int index=3;
    
    for (int i=0; i<self.homeModel.members.count; i++) {
        UIView *imageView=[[UIView alloc] init];
        //imageView.backgroundColor=[UIColor yellowColor];
        
        
        
        
        imageView.frame=CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, 200);
        [self.scrollView addSubview:imageView];
        
        [self addControlsForCard:imageView andData:self.homeModel.members[i]];
        
        self.scrollView.contentSize=CGSizeMake((i+1)*self.view.frame.size.width, 0);
        
    }
    
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(0, scrollView.frame.origin.y+scrollView.frame.size.height, self.view.frame.size.width, 1);
    bjView.backgroundColor=[UIColor redColor];
    [self.view addSubview:bjView];
    
    
    
    UIView *noticeView=[[UIView alloc] init];
    noticeView.frame=CGRectMake(0, bjView.frame.origin.y+2, self.view.frame.size.width, 30);
    [self.view addSubview:noticeView];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.backgroundColor=[UIColor redColor];
    imageView.frame=CGRectMake(0, 0, 20, 30);
    [noticeView addSubview:imageView];
    
    
    ZCAnnouncementView *textLabel=[[ZCAnnouncementView alloc] init];
    textLabel.frame=CGRectMake(30, 0, self.view.frame.size.width-30, 30);

    [noticeView addSubview:textLabel];
    textLabel.announcements=self.homeModel.announcements;
    
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(30, 0, self.view.frame.size.width-30, 30);
    
    [noticeView addSubview:button];
    
    
    [button addTarget:self action:@selector(clickThetextLabel) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lastView=[[UIView alloc] init];
    
    lastView.frame=CGRectMake(0, noticeView.frame.size.height+noticeView.frame.origin.y, self.view.frame.size.width, 300);
    
    [self.view addSubview:lastView];
    
    //九宫格算法
    
    
    int totalColumns = 3;
    // 1.数字的尺寸
    CGFloat appW = (self.view.frame.size.width-80)/3;
    CGFloat appH=appW;
    
    //间隙
    CGFloat marginX = 20;
    CGFloat marginY = 20;

    
    for (int j=0; j<6; j++) {
        
        UIButton *button=[[UIButton alloc] init];
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
            [button setTitle:@"打位预约" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor brownColor]];
        }else if (j==1)
        {
            [button setTitle:@"教练教学" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor blueColor]];

        }else if (j==2)
        {
            [button setTitle:@"会员商城" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor redColor]];
            
        }else if (j==3)
        {
            [button setTitle:@"消费记录" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor greenColor]];
            
        }else if (j==4)
        {
            [button setTitle:@"餐饮服务" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor grayColor]];
            
        }else if (j==5)
        {
            [button setTitle:@"意见反馈" forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor greenColor]];
            
        }
        
    }
    
    
}



-(void)addControlsForCard:(UIView *)view andData:(ZCMemberModel *)memberModel
{
    
    
//    unsigned result=0;
//    NSScanner *scanner=[NSScanner scannerWithString:memberModel.background_color];
//    [scanner setScanLocation:1];
//    [scanner scanHexInt:&result];
    view.backgroundColor=[ZCTool colorWithHexString:memberModel.background_color];
    
    
    UIImageView *logoImage=[[UIImageView alloc] init];
    CGFloat logoImageX=10;
    CGFloat logoImageY=10;
    CGFloat logoImageW=50;
    CGFloat logoImageH=30;
    logoImage.frame=CGRectMake(logoImageX, logoImageY, logoImageW, logoImageH);
    [logoImage sd_setImageWithURL:[NSURL URLWithString:self.homeModel.logo] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2"] ];
    [view addSubview:logoImage];
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=logoImageX+logoImageW+10;
    CGFloat nameLabelY=logoImageY;
    CGFloat nameLabelW=200;
    CGFloat nameLabelH=30;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=self.homeModel.name;
    nameLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    [view addSubview:nameLabel];
    
    UILabel *cardName=[[UILabel alloc] init];
    CGFloat cardNameW=SCREEN_WIDTH;
    CGFloat cardNameH=30;
    CGFloat cardNameX=0;
    CGFloat cardNameY=(view.frame.size.height-cardNameH)/2;
    cardName.frame=CGRectMake(cardNameX, cardNameY, cardNameW, cardNameH);
    cardName.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    cardName.textAlignment=NSTextAlignmentCenter;
    cardName.text=memberModel.name;
    [view addSubview:cardName];
    
    UILabel *remainingLabel=[[UILabel alloc] init];
    CGFloat remainingLabelX=SCREEN_WIDTH-200;
    CGFloat remainingLabelY=view.frame.size.height-70;
    CGFloat remainingLabelW=150;
    CGFloat remainingLabelH=30;
    remainingLabel.frame=CGRectMake(remainingLabelX, remainingLabelY, remainingLabelW, remainingLabelH);
    remainingLabel.textAlignment=NSTextAlignmentRight;
    remainingLabel.text=[NSString stringWithFormat:@"剩余: ￥%@",memberModel.balance];
    remainingLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    [view addSubview:remainingLabel];
    
    UILabel *numberLabel=[[UILabel alloc] init];
    CGFloat numberLabelX=10;
    CGFloat numberLabelY=view.frame.size.height-40;
    CGFloat numberLabelW=300;
    CGFloat numberLabelH=30;
    numberLabel.frame=CGRectMake(numberLabelX, numberLabelY, numberLabelW, numberLabelH);
    numberLabel.textColor=[ZCTool colorWithHexString:memberModel.font_color];
    numberLabel.text=[NSString stringWithFormat:@"NO: %@",memberModel.number];
    [view addSubview:numberLabel];
    
    
    

}



/**
 *  当scrollView正在滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
   // self.pageControl.currentPage = page;
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
