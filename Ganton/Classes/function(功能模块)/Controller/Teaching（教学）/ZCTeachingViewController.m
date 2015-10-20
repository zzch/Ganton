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
#import "ZCTeachingModel.h"
#import "ZCCoachModel.h"
@interface ZCTeachingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZCTeachingModel *teachingModel;
@property(nonatomic,weak)UITableView *tableView;
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
    self.tableView=tableView;
    
    [self addData];
}


// 网络加载
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    NSString *URL=[NSString stringWithFormat:@"%@v1/coaches",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        self.teachingModel=[ZCTeachingModel teachingModelWithDict:responseObject];
//        ZCHomeModel *homeModel=[ZCHomeModel homeModelWithDict:responseObject];
//        self.homeModel=homeModel;
//        
//        [self addControls];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.teachingModel.featured.count;
    }else{
        return self.teachingModel.normal.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        ZCTeachingHeaderCell *cell=[ZCTeachingHeaderCell cellWithTable:tableView];
        cell.coachModel=self.teachingModel.featured[indexPath.row];
        return cell;
    }else{
        ZCTeachingCell *cell=[ZCTeachingCell cellWithTable:tableView];
        cell.coachModel=self.teachingModel.normal[indexPath.row];
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
    if (indexPath.section==0) {
        vc.uuid=[self.teachingModel.featured[indexPath.row] uuid];
    }else{
        vc.uuid=[self.teachingModel.normal[indexPath.row] uuid];
    }
    
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
