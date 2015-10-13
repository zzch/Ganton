//
//  ZCDetailViewController.m
//  Ganton
//
//  Created by hh on 15/10/12.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCDetailViewController.h"

@interface ZCDetailViewController ()

@end

@implementation ZCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"明细";
    
    [self addControls];
    
}

//添加控件
-(void)addControls
{
    int index=8;
    
    UIView *detailView=[[UIView alloc] init];
    detailView.frame=CGRectMake(20, 84, SCREEN_WIDTH-40, 210+index*30);
    detailView.backgroundColor=[UIColor redColor];
    [self.view addSubview:detailView];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame=CGRectMake(10,10, 100, 30);
    nameLabel.text=@"消费明细:";
    [detailView addSubview:nameLabel];
    
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(10, 40, detailView.frame.size.width-10, 30);
    timeLabel.text=@"2015年9月16日 19:37分";
    [detailView addSubview:timeLabel];
    
    UILabel *recordLabel=[[UILabel alloc] init];
    recordLabel.frame=CGRectMake(10, 70, detailView.frame.size.width-10, 30);
    recordLabel.text=@"您的消费记录";
    [detailView addSubview:recordLabel];
    
    UILabel *moneyLabel=[[UILabel alloc] init];
    moneyLabel.frame=CGRectMake(10, 100, detailView.frame.size.width-10, 30);
    moneyLabel.text=@"消费金额: 700元";
    [detailView addSubview:moneyLabel];
    
    UILabel *detailsLabel=[[UILabel alloc] init];
    detailsLabel.frame=CGRectMake(10, 130, 100, 30);
    detailsLabel.text=@"消费详情:";
    [detailView addSubview:detailsLabel];
    
    
    
    for (int i=0; i<index; i++) {
        UILabel *label=[[UILabel alloc] init];
        label.frame=CGRectMake(115, 130+i*30, detailView.frame.size.width-130, 30);
        label.text=@"打位费：1000元";
        [detailView addSubview:label];
    }
    
    UILabel *typeLabel=[[UILabel alloc] init];
    typeLabel.frame=CGRectMake(10, 130+index*30, detailView.frame.size.width-10, 30);
    typeLabel.text=@"消费方式: 储蓄卡";
    [detailView addSubview:typeLabel];
    
    UILabel *accountLabel=[[UILabel alloc] init];
    accountLabel.frame=CGRectMake(10, typeLabel.frame.size.height+typeLabel.frame.origin.y, detailView.frame.size.width-10, 30);
    accountLabel.text=@"消费账号: 高洋";
    [detailView addSubview:accountLabel];
    
    
    
    
    
    UIButton *confirmButton=[[UIButton alloc] init];
    confirmButton.frame=CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    confirmButton.backgroundColor=[UIColor blueColor];
    [confirmButton setTitle:@"确认消费" forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    
    [confirmButton addTarget:self action:@selector(clickTheConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    

}

//点击确认消费
-(void)clickTheConfirmButton:(UIButton *)button
{
    [button setTitle:@"领取红包" forState:UIControlStateNormal];
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
