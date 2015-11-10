//
//  ZCMakeAnAppointmentViewController.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMakeAnAppointmentViewController.h"
#import "ZCMakeAnAppointmentCell.h"
#import "ZCMakeAnAppointmentModel.h"
#import "MJRefresh.h"
@interface ZCMakeAnAppointmentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)BOOL isYes;

@end

@implementation ZCMakeAnAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"打位预约";
    
    self.dataArray=[NSMutableArray array];
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:tableView];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.rowHeight=80;
    self.tableView=tableView;
    
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(TheDropDownRefresh)];
    [self.tableView headerBeginRefreshing];

   
}


//下拉刷新
-(void)TheDropDownRefresh
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
    NSString *URL=[NSString stringWithFormat:@"%@v1/reservations",API];
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        if (self.isYes==YES) {
            [self.dataArray removeAllObjects];
        }
        
        ZCLog(@"%@",responseObject);
        for (NSDictionary *dict in responseObject) {
            [self.dataArray addObject:[ZCMakeAnAppointmentModel makeAnAppointmentModelWithDict:dict]];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCMakeAnAppointmentCell *cell=[ZCMakeAnAppointmentCell cellWithTable:tableView];
    cell.makeAnAppointmentModel=self.dataArray[indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
