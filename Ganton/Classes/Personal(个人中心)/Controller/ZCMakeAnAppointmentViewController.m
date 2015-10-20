//
//  ZCMakeAnAppointmentViewController.m
//  Ganton
//
//  Created by hh on 15/10/15.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMakeAnAppointmentViewController.h"
#import "ZCMakeAnAppointmentCell.h"
@interface ZCMakeAnAppointmentViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZCMakeAnAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:tableView];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.rowHeight=120;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCMakeAnAppointmentCell *cell=[ZCMakeAnAppointmentCell cellWithTable:tableView];
    
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
