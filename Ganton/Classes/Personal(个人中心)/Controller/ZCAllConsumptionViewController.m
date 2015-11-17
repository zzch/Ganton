//
//  ZCAllConsumptionViewController.m
//  Ganton
//
//  Created by hh on 15/11/17.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//全部消费列表

#import "ZCAllConsumptionViewController.h"
#import "MJRefresh.h"
#import "ZCAllConsumptionModel.h"
#import "ZCAllConsumptionCell.h"
@interface ZCAllConsumptionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)BOOL isYes;

@end

@implementation ZCAllConsumptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"消费列表";
    
    
    self.dataArray=[NSMutableArray array];
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor=ZCColor(237, 237, 237);
    self.tableView=tableView;
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 85, 0);
    
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(theDropDownRefresh)];
    [self.tableView headerBeginRefreshing];

    
}





//添加数据
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    params[@"page"]=@(self.page);
    params[@"token"]=token;
    NSString *URL=[NSString stringWithFormat:@"%@v1/tabs/all",API];
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        if (self.isYes==YES) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject) {
            ZCAllConsumptionModel *model=[ZCAllConsumptionModel allConsumptionModelWithDict:dict];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *ID=[NSString stringWithFormat:@"ZCConsumptionCell%ld",(long)indexPath.row];
    ZCAllConsumptionCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ZCAllConsumptionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.allConsumptionModel=self.dataArray[indexPath.row];
    return cell;
    
    
    //    ZCConsumptionCell *cell=[ZCConsumptionCell cellWithTable:tableView];
    //
    //    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCAllConsumptionCell *cell=(ZCAllConsumptionCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHight;
    
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
