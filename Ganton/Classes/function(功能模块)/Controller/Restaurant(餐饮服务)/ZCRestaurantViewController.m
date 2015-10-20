//
//  ZCRestaurantViewController.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCRestaurantViewController.h"
#import "ZCRestaurantCell.h"
#import "ZCRestaurantListModel.h"
#import "ZCGoodsModel.h"
@interface ZCRestaurantViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString *imageStr;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,weak)UITableView *tableView;
//有多少行
@property(nonatomic,assign)int count;
@property(nonatomic,strong)NSMutableArray *goodsArray;
@end

@implementation ZCRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"餐饮服务";
    
    self.imageStr=@"3088644_150703431167_2.jpg";
    self.nameStr=@"大闸蟹";
    
    
   
   
    
    self.array=[NSMutableArray array];
    
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

    ZCLog(@"%@",token);
    ZCLog(@"%@",uuid);
    NSString *URL=[NSString stringWithFormat:@"%@v1/provisions",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
       
        for (NSDictionary *dict in responseObject) {
            ZCRestaurantListModel *model=[ZCRestaurantListModel restaurantListModelWithDict:dict];
            [self.array addObject:model];
        }
      
        
       [self addControls];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}



-(void)addControls
{
    
    //看这个UIViewController的这个属性你就明白了，此属性默认为YES，这样UIViewController下如果只有一个UIScollView或者其子类，那么会自动留出空白，让scollview滚动经过各种bar下面时能隐约看到内容。但是每个UIViewController只能有唯一一个UIScollView或者其子类，如果超过一个，需要将此属性设置为NO,自己去控制留白以及坐标问题。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 40);
    scrollView.backgroundColor=[UIColor redColor];
    //scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollView];
    //self.scrollView=scrollView;
    [self addControlsForScrollView:scrollView];
    
    //设置数据默认为第0组
    ZCRestaurantListModel *model1=self.array[0] ;
    
    self.goodsArray=model1.provisions;
    
    UITableView *tableView=[[UITableView alloc] init];
    tableView.frame=CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
    [self.view addSubview:tableView];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.rowHeight=120;
    self.tableView=tableView;
    

    

}



-(void)addControlsForScrollView:(UIScrollView *)scrollView
{
   
    
    for (int i=0; i<self.array.count; i++) {
        UIButton *button=[[UIButton alloc] init];
        button.backgroundColor=[UIColor redColor];
        button.tag=i+200;
        button.frame=CGRectMake(i*SCREEN_WIDTH/self.array.count, 0, SCREEN_WIDTH/self.array.count,scrollView.frame.size.height );
        ZCRestaurantListModel *RestaurantListModel=self.array[i];
        [button setTitle:[NSString stringWithFormat:@"%@",RestaurantListModel.name ] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        
        
    }
    
    scrollView.contentSize=CGSizeMake(self.array.count*SCREEN_WIDTH/self.array.count, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
   

}


-(void)clickTheButton:(UIButton *)button
{
    for (ZCRestaurantListModel *model in self.array) {
        if ([button.titleLabel.text isEqual:model.name]) {
            self.goodsArray=model.provisions;
            break;
        }
    }
    
    [self.tableView reloadData];

}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZCRestaurantCell *cell=[ZCRestaurantCell cellWithTableView:tableView];
    cell.goodsModel=self.goodsArray[indexPath.row];
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
