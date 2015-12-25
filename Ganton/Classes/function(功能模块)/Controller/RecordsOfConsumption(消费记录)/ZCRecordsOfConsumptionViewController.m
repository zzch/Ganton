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
#import "ZCRecordsOfConsumptionModel.h"
#import "MJRefresh.h"
//#import "UMSocialSnsService.h"
#import "UMSocial.h"
@interface ZCRecordsOfConsumptionViewController ()<UITableViewDelegate,UITableViewDataSource,ZCConsumptionCellDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,assign) int page;
@property(nonatomic,assign)BOOL isYes;
@end

@implementation ZCRecordsOfConsumptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"消费记录";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.dataArray=[NSMutableArray array];
    
    [self addControls];
    
   // [self addData];
}


//网络数据
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    params[@"page"]=@(self.page);
    NSString *URL=[NSString stringWithFormat:@"%@v1/tabs",API];
    
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        if (self.isYes==YES) {
            [self.dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject) {
            ZCRecordsOfConsumptionModel *model=[ZCRecordsOfConsumptionModel recordsOfConsumptionModelWithDict:dict];
            [self.dataArray addObject:model];
        }
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        ZCLog(@"%@",error);
        
        if (self.isYes==NO) {
            self.page--;
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];

}





//添加控件
-(void)addControls
{
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.backgroundColor=ZCColor(237, 237, 237);
    self.tableView=tableView;

    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 85, 0);
    
    // 3.增加刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreShops)];
    
    [self.tableView addHeaderWithTarget:self action:@selector(theDropDownRefresh)];
    [self.tableView headerBeginRefreshing];
    
}

//下拉刷新
-(void)theDropDownRefresh
{
    self.page=1;
    self.isYes=YES;
    [self addData];
}
//上啦加载更多
-(void)loadMoreShops
{
    self.isYes=NO;
    self.page++;
    [self addData];

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
    cell.delegete=self;
    cell.recordsOfConsumptionModel=self.dataArray[indexPath.row];
    return cell;
    
    
//    ZCConsumptionCell *cell=[ZCConsumptionCell cellWithTable:tableView];
//    
//    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCConsumptionCell *cell=(ZCConsumptionCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.delegete=self;
    return cell.cellHight;
  
}




//代理方法
-(void)clickTheConfirmBtn:(NSString *)uuid
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *club_uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=club_uuid;
    params[@"uuid"]=uuid;

    NSString *URL=[NSString stringWithFormat:@"%@v1/tabs/confirm",API];
    [ZCTool putWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        self.page=1;
        [self addData];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];

}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //取消反选
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"566111f367e58e8d35001ab0"
//                                      shareText:@"红包红包大红包，红包红包大红包，红包红包大红包"
//                                     shareImage:[UIImage imageNamed:@"ic_launcher.png"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
//                                       delegate:self];
//    
//    
//    
//    
////    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"红包红包大红包，红包红包大红包，红包红包大红包" image:[UIImage imageNamed:@"iconfenxiang.png"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
////        if (response.responseCode == UMSResponseCodeSuccess) {
////            NSLog(@"分享成功！");
////        }
////    }];
//    
////    ZCDetailViewController *vc=[[ZCDetailViewController alloc] init];
////    [self.navigationController pushViewController:vc animated:YES];
//
//    
//    
//    //微信
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
//    //如果是朋友圈
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
//    
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
//
//}
//


//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
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
