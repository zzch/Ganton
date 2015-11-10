//
//  ZCOpinionViewController.m
//  Ganton
//
//  Created by hh on 15/10/14.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCOpinionViewController.h"
#import "ZCViewsOnContentViewController.h"
@interface ZCOpinionViewController ()
@property(nonatomic,assign)int index;
@end

@implementation ZCOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"意见反馈";
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRightBarButtonItem)];
    
    
   
    [self addControls];
    
    
}


//添加控件
-(void)addControls
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(15, 25, SCREEN_WIDTH-30, 96);
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    [self addControlsWithView:view andTopText:@"Manager" andLastText:@"总经理" andImageStr:@"yjfk_zongjingli"];
    
    UIView *view2=[[UIView alloc] init];
    view2.frame=CGRectMake(15, view.frame.size.height+view.frame.origin.y+35, SCREEN_WIDTH-30, 96);
    view2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view2];
    [self addControlsWithView:view2 andTopText:@"Reception" andLastText:@"前台经理" andImageStr:@"yjfk_qiantai"];
    
    UIView *view3=[[UIView alloc] init];
    view3.frame=CGRectMake(15, view2.frame.size.height+view2.frame.origin.y+35, SCREEN_WIDTH-30, 96);
    view3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view3];
    [self addControlsWithView:view3 andTopText:@"Restaurant" andLastText:@"餐厅经理" andImageStr:@"yjfk_iocn_canting"];

}


-(void)addControlsWithView:(UIView *)view andTopText:(NSString *)topText andLastText:(NSString *)lastStr andImageStr:(NSString *)imageStr
{
    
    UILabel *topLable=[[UILabel alloc] init];
    topLable.frame=CGRectMake(0, 5, view.frame.size.width, 42.5);
    topLable.text=topText;
    topLable.textAlignment=NSTextAlignmentCenter;
    topLable.textColor=[UIColor grayColor];
    [view addSubview:topLable];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake((view.frame.size.width-30)/2, -18, 35, 35);
    //imageView.image=[UIImage imageNamed:@"yjfk_iocn_canting"];
    imageView.image=[UIImage imageNamed:imageStr];
    [view addSubview:imageView];
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(10, 47.5, view.frame.size.width-20, 1);
    bjView.backgroundColor=ZCColor(240, 240, 240);
    [view addSubview:bjView];
    
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(0, bjView.frame.origin.y+1, view.frame.size.width, 47.5);
    [button setTitle:lastStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:button];
    
    [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
    self.index++;
    button.tag=1100+self.index;
    
    
    
    UIImageView *rightImage=[[UIImageView alloc] init];
    rightImage.frame=CGRectMake(button.frame.size.width-6-18, (button.frame.size.height-11)/2, 6, 11);
    rightImage.image=[UIImage imageNamed:@"yjfk_iocn_zuo"];
    [button addSubview:rightImage];
    
    
    
    

}


-(void)clickTheButton:(UIButton *)button
{
    if (button.tag==1101) {
      
        ZCViewsOnContentViewController *vc=[[ZCViewsOnContentViewController alloc] init];
        vc.chooseIndex=1;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag==1102){
        ZCViewsOnContentViewController *vc=[[ZCViewsOnContentViewController alloc] init];
        vc.chooseIndex=2;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        ZCViewsOnContentViewController *vc=[[ZCViewsOnContentViewController alloc] init];
        vc.chooseIndex=3;
        [self.navigationController pushViewController:vc animated:YES];
    
    }
        

}


////点击提交
//-(void)clickTheRightBarButtonItem
//{
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *token = [defaults objectForKey:@"token"];
//    NSString *uuid = [defaults objectForKey:@"uuid"];
//    params[@"token"]=token;
//    params[@"club_uuid"]=uuid;
//    params[@"content"]=self.content.text;
//    NSString *URL=[NSString stringWithFormat:@"%@v1/feedbacks",API];
//    
//    
//    [ZCTool postWithUrl:URL params:params success:^(id responseObject) {
//        ZCLog(@"%@",responseObject);
//        
//        [MBProgressHUD showSuccess:@"意见提交成功"];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        
//       
//    } failure:^(NSError *error) {
//        ZCLog(@"%@",error);
//    }];
//
//
//}

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
