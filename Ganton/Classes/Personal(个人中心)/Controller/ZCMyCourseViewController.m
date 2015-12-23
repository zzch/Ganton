//
//  ZCMyCourseViewController.m
//  Ganton
//
//  Created by hh on 15/12/21.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCMyCourseViewController.h"
#import "ZCMyCourseCell.h"
#import "ZCPersonCourseDetailsViewController.h"
@interface ZCMyCourseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZCMyCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的课程";
   
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.backgroundColor=ZCColor(237, 237, 237);
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.rowHeight=100;
    [self.view addSubview:tableView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 10;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCMyCourseCell *cell=[ZCMyCourseCell CellWithTabaleView:tableView];
    return cell;

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCPersonCourseDetailsViewController *vc=[[ZCPersonCourseDetailsViewController alloc] init];
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
