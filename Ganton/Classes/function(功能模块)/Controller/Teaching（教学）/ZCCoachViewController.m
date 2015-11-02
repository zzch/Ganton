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
@interface ZCCoachViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)ZCCoachDetailsModel *coachDetailsModel;

@property(nonatomic,weak)UIView *headerView;
@property(nonatomic,assign)CGFloat webViewHight;
@end

@implementation ZCCoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    self.navigationItem.title=@"教练详情";
    
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
        //[self.tableView reloadData];
        
        
       // self.headerView=[self tableViewHeaderView];
        [self webViewForHight];
        
    } failure:^(NSError *error) {
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
    
    tableView.sectionHeaderHeight = self.webViewHight+110;
    NSLog(@"%f",self.webViewHight);
    
    //self.tableView.
    tableView.tableHeaderView=[self tableViewHeaderView];
   // tableView.se=[self tableViewHeaderView];
   // tableView.sectionHeaderHeight=400;
    tableView.rowHeight=50;
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
    webView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 200);
    webView.delegate=self;
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    //webView.backgroundColor=[UIColor redColor];
    //[webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.description] baseURL:nil];
    [self.view addSubview:webView];
    [webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.Description] baseURL:nil];
    webView.hidden=YES;
}


-(UIView *)tableViewHeaderView
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, SCREEN_WIDTH, self.webViewHight+110);

    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 80);
    [view addSubview:topView];
    topView.backgroundColor=[UIColor whiteColor];
    [self addTopViewControls:topView];
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, topView.frame.size.height+topView.frame.origin.y+15, SCREEN_WIDTH, self.webViewHight);
   // webView.delegate=self;
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    //webView.backgroundColor=[UIColor redColor];
    //[webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.description] baseURL:nil];
    [view addSubview:webView];
    [webView loadHTMLString:[NSString stringWithFormat:@"%@",self.coachDetailsModel.Description] baseURL:nil];
    //[webView loadHTMLString: baseURL:nil];
    ZCLog(@"%@",[NSString stringWithFormat:@"%@",self.coachDetailsModel.Description]);
    return view;

}




- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    ZCLog(@"%f",webViewHeight);
   //self.headerView.frame=CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight+110);
    self.webViewHight=webViewHeight;
    //添加控件
    [self addControls];
    
//    //获取页面高度（像素）
//    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    float clientheight = [clientheight_str floatValue];
//    ZCLog(@"%f",clientheight);
//    
//    //设置到WebView上
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
//    //获取WebView最佳尺寸（点）
//    CGSize frame = [webView sizeThatFits:webView.frame.size];
//    //获取内容实际高度（像素）
//    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
//    float height = [height_str floatValue];
//    //内容实际高度（像素）* 点和像素的比
//    height = height * frame.height / clientheight;
//    //再次设置WebView高度（点）
//   // webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
//    webView.frame=CGRectMake(0, 100, SCREEN_WIDTH, height);
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCCourseDetailsViewController *vc=[[ZCCourseDetailsViewController alloc] init];
    vc.uuid=[self.coachDetailsModel.courses[indexPath.row] uuid];
    [self.navigationController pushViewController:vc animated:YES];

}




-(void)addTopViewControls:(UIView *)view
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=15;
    CGFloat personImageY=(view.frame.size.height-50)/2;
    CGFloat personImageW=50;
    CGFloat personImageH=50;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.layer.cornerRadius=5;//设置圆角的半径为10
    personImage.layer.masksToBounds=YES;
    if ([ZCTool _valueOrNil:self.coachDetailsModel.portrait]==nil) {
        personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    }else{
    [personImage sd_setImageWithURL:[NSURL URLWithString:self.coachDetailsModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
    }
    [view addSubview:personImage];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=25;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.font=[UIFont systemFontOfSize:18];
    nameLabel.text=self.coachDetailsModel.name;
    [view addSubview:nameLabel];
    
    
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.textColor=ZCColor(85, 85, 85);
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.text=self.coachDetailsModel.title;
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
