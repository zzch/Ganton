//
//  ZCCourseDetailsViewController.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCourseDetailsViewController.h"
#import "ZCCourseDetailsModel.h"
@interface ZCCourseDetailsViewController ()
@property(nonatomic,strong)ZCCourseDetailsModel *courseDetailsModel;
@end

@implementation ZCCourseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"授课详情";
    
    
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
    params[@"uuid"]=self.uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/courses/detail",API];
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        self.courseDetailsModel=[ZCCourseDetailsModel courseDetailsModelWithDict:responseObject];
        
       
        [self addControls];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}



-(void)addControls
{
    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 200);
    [self.view addSubview:topView];
    [self addTopViewControls:topView];
    
    
    UIView *middleView=[[UIView alloc] init];
    middleView.frame=CGRectMake(0, 264, SCREEN_WIDTH, 100);
    [self.view addSubview:middleView];
    [self addMiddleViewControls:middleView];
    
    UIView *lastView=[[UIView alloc] init];
    lastView.frame=CGRectMake(0, 370, SCREEN_WIDTH, 100);
    [self.view addSubview:lastView];
    [self addLastViewControls:lastView];

}

-(void)addTopViewControls:(UIView *)view
{

    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(10, 20, 200, 30);
    nameLabel.text=[NSString stringWithFormat:@"课程名称: %@",self.courseDetailsModel.name];
    [view addSubview:nameLabel];
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(10, 60, 200, 30);
    timeLabel.text=[NSString stringWithFormat:@"有效期: %@个月",self.courseDetailsModel.valid_months ];
    [view addSubview:timeLabel];
    
    UILabel *modelLabel=[[UILabel alloc] init];
    modelLabel.frame=CGRectMake(10, 100, 200, 30);
    modelLabel.text=[NSString stringWithFormat:@"授课形式: 1对%@",self.courseDetailsModel.maximum_students ];
    [view addSubview:modelLabel];
    
    
    UILabel *money=[[UILabel alloc] init];
    money.frame=CGRectMake(SCREEN_WIDTH-100, 10, 100, 30);
    money.text=[NSString stringWithFormat:@"￥%@", self.courseDetailsModel.price];
    [view addSubview:money];
    
    
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
