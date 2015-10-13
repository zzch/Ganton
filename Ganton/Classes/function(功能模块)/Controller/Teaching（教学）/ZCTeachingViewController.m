//
//  ZCTeachingViewController.m
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCTeachingViewController.h"
#import "ZCTeachingHeaderCell.h"
#import "ZCTeachingCell.h"
#import "ZCCoachViewController.h"
@interface ZCTeachingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZCTeachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"教学信息";
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else{
        return 5;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        ZCTeachingHeaderCell *cell=[ZCTeachingHeaderCell cellWithTable:tableView];
        return cell;
    }else{
        ZCTeachingCell *cell=[ZCTeachingCell cellWithTable:tableView];
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 200;
    }else{
        return 100;
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }else{
        return 0;
    }
    

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCoachViewController *vc=[[ZCCoachViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
