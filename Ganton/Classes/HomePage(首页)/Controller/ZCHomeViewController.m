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
@interface ZCHomeViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation ZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"会员卡";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"卡包" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRightBarButtonItem)];
    
    [self addControls];
    
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
    
    int index=3;
    
    for (int i=0; i<index; i++) {
        UILabel *imageView=[[UILabel alloc] init];
        imageView.backgroundColor=[UIColor yellowColor];
        imageView.text=[NSString stringWithFormat:@"%d",i];
        imageView.textColor=[UIColor redColor];
        imageView.textAlignment=NSTextAlignmentCenter;
        
        imageView.frame=CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, 200);
        [self.scrollView addSubview:imageView];
        
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
    
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.frame=CGRectMake(30, 0, self.view.frame.size.width-30, 30);
    textLabel.textColor=[UIColor blackColor];
    textLabel.backgroundColor=[UIColor yellowColor];
    textLabel.text=@"9月到店有礼领取高尔夫一枚";
    [noticeView addSubview:textLabel];
    
    
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


-(void)clickTheButton:(UIButton *)button
{
    if (button.tag==100) {
        ZCReservationViewController *VC=[[ZCReservationViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
        
       
    }else if (button.tag==101){
    
    }else if (button.tag==102){
        
    }else if (button.tag==103){
        
    }else if (button.tag==104){
        
    }else if (button.tag==105){
        
    }
    

}



//点击右上角按钮
-(void)clickTheRightBarButtonItem
{
    ZCCardPackageViewController *vc=[[ZCCardPackageViewController alloc] init];
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
