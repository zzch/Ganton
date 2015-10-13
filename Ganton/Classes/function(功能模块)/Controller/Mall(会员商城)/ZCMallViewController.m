//
//  ZCMallViewController.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMallViewController.h"
#import "ZCMallCell.h"
#import "ZCGoodsDetailsViewController.h"
@interface ZCMallViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZCMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.dataSource=self;
    tableView.delegate=self;
    [self.view addSubview:tableView];
    tableView.rowHeight=100;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCMallCell *cell=[ZCMallCell cellWithTableView:tableView];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCGoodsDetailsViewController *vc=[[ZCGoodsDetailsViewController alloc] init];
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
