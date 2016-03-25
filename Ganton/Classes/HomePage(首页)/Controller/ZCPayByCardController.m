//
//  ZCPayByCardController.m
//  Ganton
//
//  Created by hh on 16/3/18.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCPayByCardController.h"
#import "MJRefresh.h"
#import "ZCPayByCardModel.h"
#import "ZCPayByCardCell.h"
#import "ZCCardDetailsViewController.h"
@interface ZCPayByCardController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
//数据源
@property(nonatomic,strong)NSMutableArray *dataArray;
//控制刷新的2个属性
@property(nonatomic,assign) int page;
@property(nonatomic,assign)BOOL isYes;

@end

@implementation ZCPayByCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"交易记录";
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=self.view.frame;
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=70;
    self.tableView=tableView;
    self.tableView.backgroundColor=ZCColor(239, 239, 244);
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    
    self.dataArray=[NSMutableArray array];
    
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(theDropDownRefresh)];
    [self.tableView headerBeginRefreshing];

   
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
    self.isYes=NO;
    self.page++;
    [self addData];
    
}




-(void)addData{

    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    params[@"token"]=token;
    params[@"member_uuid"]=self.uuid;
    params[@"page"]=@(self.page);
    NSString *URL=[NSString stringWithFormat:@"%@v1/members/transaction_records.json",API];

    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        if (self.isYes==YES) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject) {
            ZCPayByCardModel *model=[ZCPayByCardModel payByCardModelWithDict:dict];
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


//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return ;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPayByCardCell *cell=[ZCPayByCardCell cellWithTableView:tableView];
    cell.payByCardModel=self.dataArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCPayByCardModel *model=self.dataArray[indexPath.row];
    
    ZCLog(@"%@",model.tabUuid);
    
    if ([ZCTool _valueOrNil:model.tabUuid]) {
        ZCCardDetailsViewController *VC=[[ZCCardDetailsViewController alloc] init];
        VC.uuid=model.tabUuid;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        ZCLog(@"空的111111111");
    }
    
    
    

}


@end
