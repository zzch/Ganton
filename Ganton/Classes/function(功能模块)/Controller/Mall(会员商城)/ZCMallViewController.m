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
#import "ZCMallModel.h"
#import "MJRefresh.h"
@interface ZCMallViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *mallArray;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign) int page;
@property(nonatomic,assign) BOOL isYes;

@end

@implementation ZCMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.mallArray=[NSMutableArray array];
    
    self.navigationItem.title=@"会员商城";
    //[self addData];
    
    UITableView *tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
   // tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.dataSource=self;
    tableView.delegate=self;
    [self.view addSubview:tableView];
    self.tableView=tableView;
    
    
    tableView.rowHeight=((SCREEN_WIDTH-20)*0.5468);
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 85, 0);
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableView.cellSeparateStyle = UITableViewCellSeparateStyleNone
    
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(theDropDownRefresh)];
    [self.tableView headerBeginRefreshing];

    
    
}


//上啦加载更多
-(void)loadMoreShops
{
    self.isYes=NO;
    self.page++;
    [self addData];

}

//下拉刷新
-(void)theDropDownRefresh
{
    self.isYes=YES;
    self.page=1;
    [self addData];

}


//网络数据
-(void)addData
{
    
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    params[@"page"]=@(self.page);
    NSString *URL=[NSString stringWithFormat:@"%@v1/promotions",API];

    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        if (self.isYes==YES) {
            [self.mallArray removeAllObjects];
        }
        
        
        for (NSDictionary *dict in responseObject) {
            ZCMallModel *mallModel=[ZCMallModel mallModelWithDict:dict];
            [self.mallArray addObject:mallModel];
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        if (self.isYes==NO) {
            self.page--;
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.mallArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCMallCell *cell=[ZCMallCell cellWithTableView:tableView];
    cell.mallModel=self.mallArray[indexPath.section];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCGoodsDetailsViewController *vc=[[ZCGoodsDetailsViewController alloc] init];
    vc.uuid=[self.mallArray[indexPath.section] uuid];
   // ZCLog(@"%@",[self.mallArray[indexPath.row] uuid]);
    
    [self.navigationController pushViewController:vc animated:YES];
   //bf87c818-d27b-4522-bd76-6345ecd78be0
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;

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
