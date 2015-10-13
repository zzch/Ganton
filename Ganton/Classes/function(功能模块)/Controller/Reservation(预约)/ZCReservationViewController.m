//
//  ZCReservationViewController.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCReservationViewController.h"

@interface ZCReservationViewController ()
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *temperatureLabel;
@end

@implementation ZCReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"打位预约";
    
    
    [self addControls];
}

//添加控件
-(void)addControls
{
    UIView *weatherView=[[UIView alloc] init];
    weatherView.backgroundColor=[UIColor blueColor];
    weatherView.frame=CGRectMake(0, 64, SCREEN_WIDTH, 200);
    [self.view addSubview:weatherView];
    [self addControlsForweatherView:weatherView];
    
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(0, weatherView.frame.size.height+weatherView.frame.origin.y, SCREEN_WIDTH, 30);
    timeLabel.text=@"打球时间";
    timeLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
    
    UIButton *firstButton=[[UIButton alloc] init];
    CGFloat firstButtonX=10;
    CGFloat firstButtonY=timeLabel.frame.size.height+timeLabel.frame.origin.y;
    CGFloat firstButtonW=(SCREEN_WIDTH-40)/3;
    CGFloat firstButtonH=40;
    firstButton.frame=CGRectMake(firstButtonX, firstButtonY, firstButtonW, firstButtonH);
    firstButton.backgroundColor=[UIColor redColor];
    [firstButton setTitle:@"今天" forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(clickTheFirstButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];
    
    
    UIButton *secondButton=[[UIButton alloc] init];
    CGFloat secondButtonX=firstButtonX+firstButtonW+10;
    secondButton.frame=CGRectMake(secondButtonX, firstButtonY, firstButtonW, firstButtonH);
    secondButton.backgroundColor=[UIColor redColor];
    [secondButton setTitle:@"明天" forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(clickTheSecondButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
    
    
    UIButton *thirdButton=[[UIButton alloc] init];
    CGFloat thirdButtonX=secondButtonX+firstButtonW+10;
    thirdButton.frame=CGRectMake(thirdButtonX, firstButtonY, firstButtonW, firstButtonH);
    thirdButton.backgroundColor=[UIColor redColor];
    [thirdButton setTitle:@"后天" forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(clickTheThirdButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdButton];

    
    
    
    
    
    UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:CGRectZero];
    //模式
    datePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    //[datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //[datePicker setValue:ZCColor(85, 85, 85) forKeyPath:@"textColor"];
    // [ datePicker setDate:[datePicker date] animated:YES];
    
//    [datePicker setMaximumDate:maxDate];
//    [datePicker setMinimumDate:minDate];
    
    datePicker.frame=CGRectMake(0, thirdButton.frame.size.height+thirdButton.frame.origin.y, SCREEN_WIDTH, 200);
    
    [self.view addSubview:datePicker];
    

    
    UIButton *reserveButton=[[UIButton alloc] init];
    reserveButton.frame=CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [reserveButton setTitle:@"预定" forState:UIControlStateNormal];
    reserveButton.backgroundColor=[UIColor brownColor];
    [reserveButton addTarget:self action:@selector(clickTheReserveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    
}


-(void)clickTheFirstButton
{
    self.timeLabel.text=@"今天9月26号";
    self.imageView.backgroundColor=[UIColor redColor];
    self.temperatureLabel.text=@"24℃";


}

-(void)clickTheSecondButton
{
    self.timeLabel.text=@"明天9月27号";
    self.imageView.backgroundColor=[UIColor yellowColor];
    self.temperatureLabel.text=@"27℃";


}

-(void)clickTheThirdButton
{
    self.timeLabel.text=@"后天9月28号";
    self.imageView.backgroundColor=[UIColor brownColor];
    self.temperatureLabel.text=@"37℃";

}


//点击预定
-(void)clickTheReserveButton
{
    // 弹框
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"预定成功" message:@"球场预定成功，请在个人中心查看" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    // 设置对话框的类型
    alert.alertViewStyle=UIKeyboardTypeNumberPad;
    [alert show];
}


//-(void)alert
//{
//    // 弹框
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您已修改数据是否保存" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    
//    // 设置对话框的类型
//    alert.alertViewStyle = UIKeyboardTypeNumberPad;
//    
//    [alert show];
//    
//}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        ZCLog(@"asdasda");
//        //[self.navigationController popViewControllerAnimated:YES];
//    }else
//    {
//        ZCLog(@"asdasda");
//        //[self saveOtherView];
//    }
//    
//    // 按钮的索引肯定不是0
//    
//}




-(void)addControlsForweatherView:(UIView *)view
{
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(10, 10, 100, 20);
    timeLabel.text=@"今天9月28号";
    [view addSubview:timeLabel];
    self.timeLabel=timeLabel;
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW=50;
    CGFloat imageViewH=50;
    CGFloat imageViewX=(SCREEN_WIDTH-imageViewW)/2;
    CGFloat imageViewY=(view.frame.size.height-imageViewH)/2;
    imageView.backgroundColor=[UIColor redColor];
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [view addSubview:imageView];
    self.imageView=imageView;
    
    
    UILabel *temperatureLabel=[[UILabel alloc] init];
    temperatureLabel.frame=CGRectMake(view.frame.size.width-60, 10, 40, 30);
    temperatureLabel.text=@"24℃";
    [view addSubview:temperatureLabel];
    self.temperatureLabel=temperatureLabel;
    
    
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
