//
//  ZCAnnouncementViewController.m
//  Ganton
//
//  Created by hh on 15/10/16.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAnnouncementViewController.h"
#import "ZCAnnouncementCell.h"
#import "ZCAnnouncementListModel.h"
#import "ZCAnnouncementDetailsViewController.h"
@interface ZCAnnouncementViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *announcementListArray;

@end

@implementation ZCAnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"球场公告";
    
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    tableView.rowHeight=70;
    self.tableView=tableView;
    
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    self.announcementListArray=[NSMutableArray array];
    
    [self onlineData];
    
}


//网络数据
-(void)onlineData
{
    [MBProgressHUD showMessage:@"数据加载中..."];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=token;
    params[@"club_uuid"]=[defaults objectForKey:@"uuid"];;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/announcements",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        for (NSDictionary *dict in responseObject) {
            ZCAnnouncementListModel *announcementListModel=[ZCAnnouncementListModel announcementListModelWithDict:dict];
            [self.announcementListArray addObject:announcementListModel];
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        ZCLog(@"%@",error);
    }];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.announcementListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCAnnouncementCell *cell=[ZCAnnouncementCell cellWithTable:tableView];
    cell.announcementListModel=self.announcementListArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCAnnouncementDetailsViewController *vc=[[ZCAnnouncementDetailsViewController alloc] init];
    vc.uuid=[self.announcementListArray[indexPath.row] uuid];
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
