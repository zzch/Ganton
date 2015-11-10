//
//  ZCCardPackageViewController.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCCardPackageViewController.h"
#import "ZCCardPackageTableViewCell.h"
#import "ZCCardModel.h"
@interface ZCCardPackageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *cardArray;
@property(nonatomic,weak)UITableView *tableView;
@end

@implementation ZCCardPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"卡包";
    
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    //tableView.rowHeight=193;
   // tableView.rowHeight=173;
    self.tableView=tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor=ZCColor(237, 237, 237);
    self.cardArray=[NSMutableArray array];
    
    [self onlineData];
    
}



//网络数据
-(void)onlineData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"token"]=token;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/clubs/membership",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        for (NSDictionary *dict in responseObject) {
            ZCCardModel *cardModel=[ZCCardModel cardModelWithDict:dict];
            [self.cardArray addObject:cardModel];
        }
        [self.tableView reloadData];
        
        ZCLog(@"%@",self.cardArray);
    } failure:^(NSError *error) {
        
        ZCLog(@"%@",error);
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cardArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCardPackageTableViewCell *cell=[ZCCardPackageTableViewCell cellWithTable:tableView];
    cell.cardModel=self.cardArray[indexPath.row];
    [cell adjustFrame];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCCardPackageTableViewCell *cell=(ZCCardPackageTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
    [userDf setObject:[self.cardArray[indexPath.row] uuid] forKey:@"uuid"];
    
    if ([self.delegate respondsToSelector:@selector(clickTheOtherCardWithcardPackageViewController:)]) {
        [self.delegate clickTheOtherCardWithcardPackageViewController:self];
        
        [self.navigationController popViewControllerAnimated:YES];
    }

    
   // self.view.subviews
    
   
    
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
