//
//  ZCRecordsOfConsumptionViewController.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCRecordsOfConsumptionViewController.h"
#import "ZCConsumptionCell.h"
#import "ZCDetailViewController.h"
#import "ZCRecordsOfConsumptionModel.h"
#import "MJRefresh.h"
@interface ZCRecordsOfConsumptionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ZCRecordsOfConsumptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"消费记录";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.dataArray=[NSMutableArray array];
    
    [self addControls];
    
   // [self addData];
}


//网络数据
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/tabs",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        for (NSDictionary *dict in responseObject) {
            ZCRecordsOfConsumptionModel *model=[ZCRecordsOfConsumptionModel recordsOfConsumptionModelWithDict:dict];
            [self.dataArray addObject:model];
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];

}





//添加控件
-(void)addControls
{
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor=ZCColor(237, 237, 237);
    self.tableView=tableView;

    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 100, 0);
    
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(theDropDownRefresh)];
    [self.tableView headerBeginRefreshing];
    
}

-(void)theDropDownRefresh
{
    [self addData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSString *ID=[NSString stringWithFormat:@"ZCConsumptionCell%ld",(long)indexPath.row];
    ZCConsumptionCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCConsumptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.recordsOfConsumptionModel=self.dataArray[indexPath.row];
    return cell;
    
    
//    ZCConsumptionCell *cell=[ZCConsumptionCell cellWithTable:tableView];
//    
//    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCConsumptionCell *cell=(ZCConsumptionCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHight;
  
}



//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //取消反选
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    ZCDetailViewController *vc=[[ZCDetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
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
