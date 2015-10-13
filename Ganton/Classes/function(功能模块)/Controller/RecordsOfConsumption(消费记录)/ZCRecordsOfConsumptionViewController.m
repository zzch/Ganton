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
@interface ZCRecordsOfConsumptionViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZCRecordsOfConsumptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"消费记录";
    
    
    [self addControls];
    
}

//添加控件
-(void)addControls
{
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    tableView.rowHeight=110;

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCConsumptionCell *cell=[ZCConsumptionCell cellWithTable:tableView];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCDetailViewController *vc=[[ZCDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

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
