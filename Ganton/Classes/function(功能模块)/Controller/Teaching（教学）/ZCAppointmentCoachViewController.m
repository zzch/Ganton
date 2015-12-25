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
@interface ZCAppointmentCoachViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,ZCAppointmentCoachCellDelegate>
@property(nonatomic,weak)UITableView *tableView;


@property(nonatomic,weak)UIView *headerView;
@property(nonatomic,assign)CGFloat webViewHight;
@end

@implementation ZCAppointmentCoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"预约";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    [self webViewForHight];
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
    
    tableView.rowHeight=75;
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
    webView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 100);
    webView.delegate=self;
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    [self.view addSubview:webView];
    [webView loadHTMLString:@"2013年3月11日 - 4.pop返回table时,cell自动取消选中状态 首先我有一个UITableViewController,其中每个UITableViewCell点击后都会push另一个ViewController,每次点击Ce..." baseURL:nil];
    
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
    webView.frame=CGRectMake(0, topView.frame.size.height+topView.frame.origin.y+15, SCREEN_WIDTH, self.webViewHight);
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    
    [view addSubview:webView];
    [webView loadHTMLString:@"2013年3月11日 - 4.pop返回table时,cell自动取消选中状态 首先我有一个UITableViewController,其中每个UITableViewCell点击后都会push另一个ViewController,每次点击Ce..." baseURL:nil];
    //[webView loadHTMLString: baseURL:nil];
   
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    ZCAppointmentCoachCell *cell=[ZCAppointmentCoachCell cellWithTableView:tableView];
    cell.delegate=self;
//    cell.courseModel=self.coachDetailsModel.courses[indexPath.row];
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

-(void)clickTheButton:(NSString *)str
{
    // 弹框
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"预定成功" message:@"球场预定成功，请在个人中心查看" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
        //[self saveOtherView];
    }
    
    // 按钮的索引肯定不是0
    
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
    personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
//    if ([ZCTool _valueOrNil:self.coachDetailsModel.portrait]==nil) {
//        personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
//    }else{
//        [personImage sd_setImageWithURL:[NSURL URLWithString:self.coachDetailsModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
//    }
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
    titleLabel.text=@"教练: 刘阳";
    titleLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:titleLabel];
    //self.titleLabel=titleLabel;
    
    UILabel *typeLabel=[[UILabel alloc] init];
    CGFloat  typeLabelX=nameLabelX;
    CGFloat  typeLabelY=titleLabelY+titleLabelH+5;
    CGFloat  typeLabelW=200;
    CGFloat  typeLabelH=15;
    typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    typeLabel.text=@"主教练";
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
