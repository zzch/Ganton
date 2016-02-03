//
//  ZCAppointmentCoachViewController.m
//  Ganton
//
//  Created by hh on 15/12/22.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAppointmentCoachViewController.h"
#import "ZCAppointmentCoachCell.h"
#import "ZCAppointmentTimeViewController.h"
#import "ZCOpenCoursesModel.h"
@interface ZCAppointmentCoachViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,ZCAppointmentCoachCellDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)ZCOpenCoursesModel *openCoursesModel;

@property(nonatomic,weak)UIView *headerView;
@property(nonatomic,assign)CGFloat webViewHight;
//预约选中的课程id
@property(nonatomic,copy)NSString *courseUuid;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation ZCAppointmentCoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"预约";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    [self onlineData];
}

//请求数据
-(void)onlineData
{
    [MBProgressHUD showMessage:@"正在加载..."];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *club_uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=club_uuid;
    params[@"uuid"]=self.uuid;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/open_courses/detail.json",API];

//    ZCLog(@"%@",token);
//    ZCLog(@"%@",club_uuid);
//    ZCLog(@"%@",self.uuid);
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        ZCOpenCoursesModel *openCoursesModel=[ZCOpenCoursesModel openCoursesModelWithDict:responseObject];
        self.openCoursesModel=openCoursesModel;
        
        [self webViewForHight];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        ZCLog(@"%@",error);
        
    }];

}


//添加控件
-(void)addControls
{
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=ZCColor(237, 237, 237);
    tableView.sectionHeaderHeight = self.webViewHight+152;
    NSLog(@"%f",self.webViewHight);
    
    
    tableView.tableHeaderView=[self tableViewHeaderView];
    
    tableView.rowHeight=93;
    tableView.backgroundColor=ZCColor(237, 237, 237);
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 75, 0);
    [self.view addSubview:tableView];
    self.tableView=tableView;
    //让下面没内容的分割线不显示
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}


//提前调查处webView的高度 零时控件
-(void)webViewForHight
{
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(5, 0, SCREEN_WIDTH-10, 1);
    webView.delegate=self;
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    [self.view addSubview:webView];
    
    NSString *newStr=[NSString stringWithFormat:@"<html><head><title>Example</title><style>img { width: 100%%}</style></head><body>%@</body></html>",self.openCoursesModel.Description];
    [webView loadHTMLString:newStr baseURL:nil];
    //[webView loadHTMLString:self.openCoursesModel.Description baseURL:nil];
    
    webView.hidden=YES;
}


-(UIView *)tableViewHeaderView
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, SCREEN_WIDTH, self.webViewHight+152);
    
    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 122);
    [view addSubview:topView];
    topView.backgroundColor=[UIColor whiteColor];
    [self addTopViewControls:topView];
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(5, topView.frame.size.height+topView.frame.origin.y+15, SCREEN_WIDTH-10, self.webViewHight);
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    
    [view addSubview:webView];
    
    NSString *newStr=[NSString stringWithFormat:@"<html><head><title>Example</title><style>img { width: 100%%}</style></head><body>%@</body></html>",self.openCoursesModel.Description];
    [webView loadHTMLString:newStr baseURL:nil];
    return view;
    
}




- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    ZCLog(@"%f",webViewHeight);
   
    self.webViewHight=webViewHeight;
    //添加控件
    [self addControls];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.openCoursesModel.unstarted_lessonsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ZCAppointmentCoachCell *cell=[ZCAppointmentCoachCell cellWithTableView:tableView];
    cell.delegate=self;
    cell.unstartedLessonsModel=self.openCoursesModel.unstarted_lessonsArray[indexPath.row];
    return cell;
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ZCAppointmentTimeViewController *vc=[[ZCAppointmentTimeViewController alloc] init];
//   // vc.uuid=[self.coachDetailsModel.courses[indexPath.row] uuid];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

//代理方法
-(void)clickTheButton:(UIButton *)sender andnName:(NSString *)str andUUID:(NSString *)uuid
{
    self.courseUuid=uuid;
    
    //拿到对应cell的indexPath
    UIView *view=(UIView *)sender;
    UIView *superView=view.superview;
    while (![superView isKindOfClass:[UITableViewCell class]]) {
        superView=superView.superview;
    }
    NSIndexPath *indexPath=[self.tableView  indexPathForCell:(UITableViewCell *)superView ];
    self.indexPath=indexPath;
    
    
    ZCLog(@"%@",self.indexPath);
    
    [self alertView:self Title:[NSString stringWithFormat:@"是否确定预约 %@ 课程",str] message:nil andcancel:@"取消"];

}


-(void)alertView:(UIViewController *)vc Title:(NSString *)title message:(NSString *)message andcancel:(NSString *)cancel
{

    // 弹框
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:message delegate:vc cancelButtonTitle:cancel otherButtonTitles:@"确定", nil];
    // 设置对话框的类型
    alert.alertViewStyle=UIKeyboardTypeNumberPad;
    [alert show];
    
}


#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        ZCLog(@"asdasda");
        //[self.navigationController popViewControllerAnimated:YES];
    }else
    {
        ZCLog(@"asdasda");
        [self uploadTime];
    }
    
    // 按钮的索引肯定不是0
    
}

//上传服务器选中的时间
-(void)uploadTime
{
    [MBProgressHUD showMessage:@"正在加载..."];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *club_uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=club_uuid;
    params[@"uuid"]=self.courseUuid;
   
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/lessons/reserve_open.json",API];
    
    [ZCTool postWithUrl:URL params:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        ZCLog(@"%@",responseObject);
        
        [self alertView:nil Title:@"预定成功" message:@"课程预定成功，请在个人中心查看" andcancel:nil];
        
        
        ZCUnstartedLessonsModel *model=  self.openCoursesModel.unstarted_lessonsArray[self.indexPath.row];
        model.state=@"reserved";
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
    
    
}



-(void)addTopViewControls:(UIView *)view
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=15;
    CGFloat personImageY=(view.frame.size.height-104)/2;
    CGFloat personImageW=75;
    CGFloat personImageH=104;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.layer.cornerRadius=5;//设置圆角的半径为10
    personImage.layer.masksToBounds=YES;
   // personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    if ([ZCTool _valueOrNil:self.openCoursesModel.portrait]==nil) {
        personImage.image=[UIImage imageNamed:@"shape-87"];
    }else{
        [personImage sd_setImageWithURL:[NSURL URLWithString:self.openCoursesModel.portrait] placeholderImage:[UIImage imageNamed:@"shape-87"]];
    }
    [view addSubview:personImage];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=25;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.font=[UIFont systemFontOfSize:18];
    nameLabel.text=@"青少年套课";
    [view addSubview:nameLabel];
    
    
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH+30;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.textColor=ZCColor(85, 85, 85);
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.text=[NSString stringWithFormat:@"教练: %@",self.openCoursesModel.coachName ];
    titleLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:titleLabel];
    //self.titleLabel=titleLabel;
    
    UILabel *typeLabel=[[UILabel alloc] init];
    CGFloat  typeLabelX=nameLabelX;
    CGFloat  typeLabelY=titleLabelY+titleLabelH+5;
    CGFloat  typeLabelW=200;
    CGFloat  typeLabelH=15;
    typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    typeLabel.text=[NSString stringWithFormat:@"%@",self.openCoursesModel.title];
    typeLabel.textColor=ZCColor(85, 85, 85);
    typeLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:typeLabel];
    
    
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
