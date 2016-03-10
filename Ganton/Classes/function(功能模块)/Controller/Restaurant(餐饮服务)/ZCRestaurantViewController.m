//
//  ZCRestaurantViewController.m
//  Ganton
//
//  Created by hh on 15/10/13.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCRestaurantViewController.h"

#import "ZCRestaurantListModel.h"
#import "ZCGoodsModel.h"
#import "ZCRestaurantCollectionViewCell.h"
static NSString *const identifier=@"cell";

@interface ZCRestaurantViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString *imageStr;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,weak)UITableView *tableView;
//有多少行
@property(nonatomic,assign)int count;
@property(nonatomic,strong)NSMutableArray *goodsArray;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ZCRestaurantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"餐饮服务";
    
//    self.imageStr=@"3088644_150703431167_2.jpg";
//    self.nameStr=@"大闸蟹";
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
   
    
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
      
        if (self.array.count>0) {
            [self addControls];
        }
        
       
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}



-(void)addControls
{
    
    //看这个UIViewController的这个属性你就明白了，此属性默认为YES，这样UIViewController下如果只有一个UIScollView或者其子类，那么会自动留出空白，让scollview滚动经过各种bar下面时能隐约看到内容。但是每个UIViewController只能有唯一一个UIScollView或者其子类，如果超过一个，需要将此属性设置为NO,自己去控制留白以及坐标问题。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    scrollView.backgroundColor=ZCColor(41, 45, 47);
    //scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    [self addControlsForScrollView:scrollView];
    
    //设置数据默认为第0组
    ZCRestaurantListModel *model1=self.array[0] ;
    
    self.goodsArray=model1.provisions;
    
//    UITableView *tableView=[[UITableView alloc] init];
//    tableView.frame=CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT-104);
//    [self.view addSubview:tableView];
//    tableView.dataSource=self;
//    tableView.delegate=self;
//    tableView.rowHeight=120;
//    self.tableView=tableView;
    

     UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //设置每个格子宽高100
     layout.itemSize=CGSizeMake((SCREEN_WIDTH-30)/2, ((SCREEN_WIDTH-30)/2)*0.7586+55);
   // layout.minimumInteritemSpacing=10;
   // layout.minimumInteritemSpacing=10;
   // layout.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    UICollectionView *clView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40) collectionViewLayout:layout];
    
    clView.contentInset = UIEdgeInsetsMake(10, 10, 75, 10);
    
    //在成为数据源之前，告诉系统通过哪一个类来创建UICollectionViewCell
    [clView registerClass:[ZCRestaurantCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    //设置UICollectionView的数据源为当前控制器
    clView.dataSource=self;
    clView.delegate=self;
    clView.backgroundColor=ZCColor(237, 237, 237);
    [self.view addSubview:clView];
    self.collectionView=clView;
    
    //self.collectionView.contentOffset
   // self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);

}



-(void)addControlsForScrollView:(UIScrollView *)scrollView
{
   
    CGFloat w = 0.0;
    for (int i=0; i<self.array.count; i++) {
        UIButton *button=[[UIButton alloc] init];
        button.backgroundColor=ZCColor(41, 45, 47);
        button.tag=i+200;
        
        if (self.array.count<5) {
            w=SCREEN_WIDTH/self.array.count;
        }else
        {
         w=SCREEN_WIDTH/4;
        }
        
        
        button.frame=CGRectMake(i*w, 0, w,scrollView.frame.size.height );
        ZCRestaurantListModel *RestaurantListModel=self.array[i];
        [button setTitle:[NSString stringWithFormat:@"%@",RestaurantListModel.name ] forState:UIControlStateNormal];
        if (i==0) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
        
            [button setTitleColor:ZCColor(152, 152, 152) forState:UIControlStateNormal];
        }
        
        
        //添加控件
        [self addControlsWithButton:button andIndex:i];
        [button addTarget:self action:@selector(clickTheButton:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        
        
        
    }
    
    scrollView.contentSize=CGSizeMake(self.array.count*w, 0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
   

}


//添加button上的控件
-(void)addControlsWithButton:(UIButton *)button andIndex:(int) index
{
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake((button.frame.size.width-(button.frame.size.width*0.6))/2, button.frame.size.height-4, button.frame.size.width*0.6, 3);
    view.backgroundColor=[UIColor whiteColor];
    if (index==0) {
        view.hidden=NO;
    }else{
    view.hidden=YES;
    }
    [button addSubview:view];
    

}



-(void)clickTheButton:(UIButton *)button
{
    for (UIButton *button in self.scrollView.subviews) {
        
        [button setTitleColor:ZCColor(152, 152, 152) forState:UIControlStateNormal];
        for (id  view in button.subviews) {
            if ([view isKindOfClass:[UIView class]]) {
                UIView *view1=(UIView*)view;
                view1.hidden=YES;
                break;
            }
   
        }
    }
    
   [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    for (UIView * view in button.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            view.hidden=NO;
            break;
        }


    }

    
    for (ZCRestaurantListModel *model in self.array) {
        if ([button.titleLabel.text isEqual:model.name]) {
            self.goodsArray=model.provisions;
            break;
        }
    }
    
    [self.collectionView reloadData];

}




//告诉UICollectionView 一共多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//告诉UICollectionView 每一组中需要展示多少个小方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return self.goodsArray.count;
}


//告诉系统 每个小方块展示什么内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //UICollectionViewCell和UITableViewCell的区别UICollectionView的dequeueReusableCellWithReuseIdentifier这个方法如果去缓存池中去取，没有取到cell，那么该方法内部会自动创建一个cell 但是需要注意的是:通过哪一类来创建cell必须由我们来制定
    
    //    //如果缓存池中没有，创建一个collectionView
    //    if (cell==nil) {
    //
    //    }
    
    
    //1.从缓存池中获取cell
    ZCRestaurantCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    // cell.backgroundColor=[UIColor whiteColor];
    
    cell.goodsModel=self.goodsArray[indexPath.item];
    
    //添加阴影效果
    
    
    //    cell.layer.borderWidth=4;
    //
    //    cell.layer.borderColor=[UIColor redColor].CGColor;
    
    //cell.delegate = self;
    
    return cell;
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    ZCRestaurantCell *cell=[ZCRestaurantCell cellWithTableView:tableView];
//    cell.goodsModel=self.goodsArray[indexPath.row];
//    return cell;
//    
//}




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
