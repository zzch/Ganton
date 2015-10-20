//
//  ZCCoachViewController.m
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCoachViewController.h"
#import "ZCCoachViewCell.h"
#import "ZCCourseDetailsViewController.h"
#import "ZCCoachDetailsModel.h"
@interface ZCCoachViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)ZCCoachDetailsModel *coachDetailsModel;
@end

@implementation ZCCoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    
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
    NSString *URL=[NSString stringWithFormat:@"%@v1/coaches/detail",API];
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        self.coachDetailsModel=[ZCCoachDetailsModel CoachDetailsModelWithDict:responseObject];
        //        ZCHomeModel *homeModel=[ZCHomeModel homeModelWithDict:responseObject];
        //        self.homeModel=homeModel;
        //
        //        [self addControls];
        [self.tableView reloadData];
        [self addControls];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}





//添加控件
-(void)addControls
{
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.sectionHeaderHeight = 400;
    //self.tableView.
    tableView.tableHeaderView=[self tableViewHeaderView];
   // tableView.se=[self tableViewHeaderView];
   // tableView.sectionHeaderHeight=400;
    tableView.rowHeight=40;
    
   [self.view addSubview:tableView];
    self.tableView=tableView;
    
}



-(UIView *)tableViewHeaderView
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, SCREEN_WIDTH, 400);

    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [view addSubview:topView];
    topView.backgroundColor=[UIColor whiteColor];
    [self addTopViewControls:topView];
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, topView.frame.size.height+topView.frame.origin.y+10, SCREEN_WIDTH, 200);
    //webView.backgroundColor=[UIColor redColor];
    //[webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.description] baseURL:nil];
    [view addSubview:webView];
    [webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.Description] baseURL:nil];
    //[webView loadHTMLString: baseURL:nil];
    ZCLog(@"%@",[NSString stringWithFormat:@"%@",self.coachDetailsModel.Description]);
    return view;

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.coachDetailsModel.courses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCoachViewCell *cell=[ZCCoachViewCell cellWithTable:tableView];
    cell.courseModel=self.coachDetailsModel.courses[indexPath.row];
    return cell;
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCourseDetailsViewController *vc=[[ZCCourseDetailsViewController alloc] init];
    vc.uuid=[self.coachDetailsModel.courses[indexPath.row] uuid];
    [self.navigationController pushViewController:vc animated:YES];

}




-(void)addTopViewControls:(UIView *)view
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=10;
    CGFloat personImageY=10;
    CGFloat personImageW=50;
    CGFloat personImageH=view.frame.size.height-20;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    
    if ([ZCTool _valueOrNil:self.coachDetailsModel.portrait]==nil) {
        personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    }else{
    [personImage sd_setImageWithURL:[NSURL URLWithString:self.coachDetailsModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
    }
    [view addSubview:personImage];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+10;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=60;
    CGFloat nameLabelH=30;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.text=self.coachDetailsModel.name;
    [view addSubview:nameLabel];
    
    
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH;
    CGFloat titleLabelW=50;
    CGFloat titleLabelH=30;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.text=self.coachDetailsModel.title;
    [view addSubview:titleLabel];
    //self.titleLabel=titleLabel;
    
    UILabel *genderLabel=[[UILabel alloc] init];
    CGFloat  genderLabelX=nameLabelX+nameLabelW+30;
    CGFloat  genderLabelY=nameLabelY+10;
    CGFloat  genderLabelW=40;
    CGFloat  genderLabelH=30;
    genderLabel.frame=CGRectMake(genderLabelX, genderLabelY, genderLabelW, genderLabelH);
    genderLabel.text=[NSString stringWithFormat:@"%@",self.coachDetailsModel.gender];
    [view addSubview:genderLabel];
    //self.genderLabel=genderLabel;

    
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
