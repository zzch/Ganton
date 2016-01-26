//
//  ZCMyCourseViewController.m
//  Ganton
//
//  Created by hh on 15/12/21.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMyCourseViewController.h"
#import "ZCMyCourseCell.h"
#import "MJRefresh.h"
#import "ZCPersonCourseDetailsViewController.h"
#import "ZCMyCourseModel.h"
@interface ZCMyCourseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)BOOL isYes;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ZCMyCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的课程";
   
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    self.dataArray=[NSMutableArray array];
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.backgroundColor=ZCColor(237, 237, 237);
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=100;
    [self.view addSubview:tableView];
    self.tableView=tableView;
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(theDropDownRefresh)];
    [self.tableView headerBeginRefreshing];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];

}


//下拉刷新
-(void)theDropDownRefresh
{
    self.page=1;
    self.isYes=YES;
    [self addData];
    
}

//上啦加载更多
-(void)loadMoreShops
{
    self.page++;
    self.isYes=NO;
    [self addData];
    
}


//添加数据
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    params[@"page"]=@(self.page);
    params[@"token"]=token;
    NSString *URL=[NSString stringWithFormat:@"%@v1/curriculums.json",API];
    ZCLog(@"%@",token);
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        if (self.isYes==YES) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject) {
            ZCMyCourseModel *model=[ZCMyCourseModel myCourseModelWithDict:dict];
            [self.dataArray addObject:model];
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        [self.tableView reloadData];
        
        
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
        if (self.isYes==NO) {
            self.page--;
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
    }];

  
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.dataArray.count;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCMyCourseCell *cell=[ZCMyCourseCell CellWithTabaleView:tableView];
    cell.myCourseModel=self.dataArray[indexPath.section];
    return cell;

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPersonCourseDetailsViewController *vc=[[ZCPersonCourseDetailsViewController alloc] init];
    vc.myCourseModel=self.dataArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
