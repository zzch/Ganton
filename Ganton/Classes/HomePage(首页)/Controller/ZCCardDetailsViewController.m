//
//  ZCCardDetailsViewController.m
//  Ganton
//
//  Created by hh on 16/3/25.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//

#import "ZCCardDetailsViewController.h"
#import "ZCConsumptionCell.h"

#import "ZCRecordsOfConsumptionModel.h"
@interface ZCCardDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ZCCardDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"详情";
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor=ZCColor(237, 237, 237);
    self.tableView=tableView;

    self.dataArray=[NSMutableArray array];
    
    [self addData];
}



-(void)addData{
    
    [MBProgressHUD showMessage:@"数据加载中..."];


    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
   // NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"uuid"]=self.uuid;
   
    NSString *URL=[NSString stringWithFormat:@"%@v1/tabs/detail.json",API];
    
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
    
        
            ZCRecordsOfConsumptionModel *model=[ZCRecordsOfConsumptionModel recordsOfConsumptionModelWithDict:responseObject];
            [self.dataArray addObject:model];
        
        
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
        
    }];
    
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
    //cell.delegete=self;
    cell.isYes=YES;
    cell.recordsOfConsumptionModel=self.dataArray[indexPath.row];
    return cell;
    
    
    //    ZCConsumptionCell *cell=[ZCConsumptionCell cellWithTable:tableView];
    //
    //    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCConsumptionCell *cell=(ZCConsumptionCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    //cell.delegete=self;
    return cell.cellHight;
    
}





@end
