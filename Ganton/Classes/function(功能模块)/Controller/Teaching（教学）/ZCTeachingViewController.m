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
#import "ZCTeachingCourseCell.h"
#import "ZCAppointmentCoachViewController.h"
#import "ZCAppointmentTimeViewController.h"
@interface ZCTeachingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZCTeachingModel *teachingModel;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ZCTeachingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"教练教学";
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped] ;
    
    //tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    self.tableView=tableView;
    tableView.backgroundColor=ZCColor(237, 237, 237);
    
    [self.tableView   setSeparatorColor:ZCColor(211, 211, 211)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 45, 0);
    //设置组头可以随着tableView往上滚动
   // self.automaticallyAdjustsScrollViewInsets = NO;
    [self addData];
}

////设置组头可以随着tableView往上滚动
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat sectionHearderHeight = 30;
//    if (scrollView.contentOffset.y<=sectionHearderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    }else if(scrollView.contentOffset.y>=sectionHearderHeight){
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHearderHeight, 0, 0, 0);
//    }
//    
//}


// 网络加载
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/students_and_coaches.json",API];
    
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
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return self.teachingModel.students.count;
        
    }else if (section==1) {
        return self.teachingModel.featured.count;
    }else{
        return self.teachingModel.normal.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ZCTeachingCourseCell *cell=[ZCTeachingCourseCell cellWithTableView:tableView];
        cell.studentModel=self.teachingModel.students[indexPath.row];
        return cell;
    }
    
    if (indexPath.section==1) {
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
        
        return 80;
    }else if (indexPath.section==1) {
        
        return 125;
    }else{
        
        return 80;
    }

}



//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//    //获取indexPath
//    NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:section];
//    if (0 == indexPath.section) {//第一组
//        return 0;
//    }else
//        return 15;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.5;
    }else{
    
        if (self.teachingModel.featured.count==0){
            return 0.5;
        }else
        {
            return 20;
        }
    }
    

}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//
//    if (section==0) {
//        
//        
//       return 0;
//        
//        
//    }else{
//        if (self.teachingModel.featured.count==0) {
//            return 0;
//        }else{
//            return 20;
//        }
//    }
//
//}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        ZCStudentModel *Model=self.teachingModel.students[indexPath.row];
        ZCLog(@"%@",Model);
        
        if ([ Model.type isEqual:@"open"]) {
            ZCAppointmentCoachViewController *vc=[[ZCAppointmentCoachViewController alloc] init];
            vc.uuid=Model.uuid;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        
            ZCAppointmentTimeViewController *vc=[[ZCAppointmentTimeViewController alloc] init];
            vc.uuid=Model.uuid;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }else{
    
    ZCCoachViewController *vc=[[ZCCoachViewController alloc] init];
    if (indexPath.section==1) {
        vc.uuid=[self.teachingModel.featured[indexPath.row] uuid];
    }else{
        vc.uuid=[self.teachingModel.normal[indexPath.row] uuid];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    }
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
