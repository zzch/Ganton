//
//  ZCReservationViewController.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCReservationViewController.h"
#import "ZCWeathersModel.h"
#import "ZCTimeView.h"
@interface ZCReservationViewController ()<ZCTimeViewDelegate>
@property(nonatomic,weak)UIView *weatherView;
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *temperatureLabel;
@property(nonatomic,weak)UILabel *textLabel;
@property(nonatomic,weak)UILabel *windLabel;
@property(nonatomic,weak)UIView *xianView;
@property(nonatomic,strong)NSMutableArray *weathersArray;




@property(nonatomic,copy)NSString *chooseTime;
//选中今天  明天 的时间戳
@property(nonatomic,assign)long time;

@property(nonatomic,weak)UILabel *chooseTimeLabel;

@property(nonatomic,weak)UIButton *firstButton;
@property(nonatomic,weak)UIButton *secondButton;
@property(nonatomic,weak)UIButton *thirdButton;

@property(nonatomic,weak)UIScrollView *scrollView;
@end

@implementation ZCReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"打位预约";
    
    self.weathersArray=[NSMutableArray array];
    
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
    NSString *URL=[NSString stringWithFormat:@"%@v1/weathers/recently",API];
    ZCLog(@"%@",token);
    ZCLog(@"%@",uuid);
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        for (NSDictionary *dict in responseObject) {
            ZCWeathersModel *weathersModel=[ZCWeathersModel weathersModelWithDict:dict];
            [self.weathersArray addObject:weathersModel];
        }
        
//        ZCHomeModel *homeModel=[ZCHomeModel homeModelWithDict:responseObject];
//        self.homeModel=homeModel;
        
        [self addControls];
        
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}



- (NSDate *)dateWithYMDDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateFormatter stringFromDate:date];
    return [dateFormatter dateFromString:selfStr];
}

-(NSString * )JudgmentIsWhichDay:(long )dateTime
{
    
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:dateTime];
   
    NSDate *nowDate = [self dateWithYMDDate:[NSDate date]];
    NSDate *selfDate = [self dateWithYMDDate:confromTimesp];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:nowDate toDate:selfDate options:0];
    //return cmps.day == 1;
    ZCLog(@"%@",nowDate);
    ZCLog(@"%@",selfDate);
    ZCLog(@"%ld",(long)cmps.day);
    
    if (cmps.day == 0) {
        return @"今天 ";
    }else if (cmps.day == 1){
       return @"明天 ";
    }else if (cmps.day == 2){
       return @"后天 ";
    }else if (cmps.day == 3){
        return @"大后天 ";
    }else{
        return nil;
    }
    
}


-(NSString *)whatDayIsNow:(long)dateTime
{
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
    
    NSString *str=[NSString stringWithFormat:@"%@%@",[self JudgmentIsWhichDay:dateTime],nowDateString];
    
    return str;

}



//添加控件
-(void)addControls
{
    UIView *weatherView=[[UIView alloc] init];
    weatherView.backgroundColor=ZCColor(40, 45, 46);
    weatherView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 195);
    [self.view addSubview:weatherView];
    self.weatherView=weatherView;
    [self addControlsForweatherView:weatherView];
    
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(0, weatherView.frame.size.height+weatherView.frame.origin.y+18, SCREEN_WIDTH, 30);
    timeLabel.text=@"打球时间";
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:timeLabel];
    
    UIButton *firstButton=[[UIButton alloc] init];
    CGFloat firstButtonX=10;
    CGFloat firstButtonY=timeLabel.frame.size.height+timeLabel.frame.origin.y+10;
    CGFloat firstButtonW=(SCREEN_WIDTH-40)/3;
    CGFloat firstButtonH=59;
    firstButton.frame=CGRectMake(firstButtonX, firstButtonY, firstButtonW, firstButtonH);
    [firstButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [firstButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    [firstButton addTarget:self action:@selector(clickTheFirstButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];
    
    self.firstButton=firstButton;
     ZCWeathersModel *model=self.weathersArray[0];
    [self theTextOnTheAddButton:firstButton andTime:model.date];
    //默认点击第一个
    [self clickTheFirstButton];
    
    UIButton *secondButton=[[UIButton alloc] init];
    CGFloat secondButtonX=firstButtonX+firstButtonW+10;
    secondButton.frame=CGRectMake(secondButtonX, firstButtonY, firstButtonW, firstButtonH);
    [secondButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [secondButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    
    [secondButton addTarget:self action:@selector(clickTheSecondButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
    self.secondButton=secondButton;
    ZCWeathersModel *model2=self.weathersArray[1];
    [self theTextOnTheAddButton:secondButton andTime:model2.date];
    
    
    UIButton *thirdButton=[[UIButton alloc] init];
    CGFloat thirdButtonX=secondButtonX+firstButtonW+10;
    thirdButton.frame=CGRectMake(thirdButtonX, firstButtonY, firstButtonW, firstButtonH);
    [thirdButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [thirdButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    [thirdButton addTarget:self action:@selector(clickTheThirdButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdButton];
    self.thirdButton=thirdButton;

    
    ZCWeathersModel *model3=self.weathersArray[2];
    [self theTextOnTheAddButton:thirdButton andTime:model3.date];
    
    
    
    
    UIButton *timeButton=[[UIButton alloc] init];
    CGFloat timeButtonY=firstButtonY+firstButtonH+17;
    timeButton.frame=CGRectMake(10, timeButtonY, SCREEN_WIDTH-20, 59);
    [timeButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [timeButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateHighlighted];
    [self.view addSubview:timeButton];
    [timeButton addTarget:self action:@selector(clickTheTimeButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewW=25;
    CGFloat imageViewH=25;
    CGFloat imageViewX=timeButton.frame.size.width/2-imageViewW-10;
    CGFloat imageViewY=(timeButton.frame.size.height-imageViewH)/2;
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:@"dqyy_clock"];
    [timeButton addSubview:imageView];
    
    UILabel *chooseTimeLabel=[[UILabel alloc] init];
    CGFloat chooseTimeLabelX=timeButton.frame.size.width/2+10;
    CGFloat chooseTimeLabelY=(timeButton.frame.size.height-imageViewH)/2;
    CGFloat chooseTimeLabelW=timeButton.frame.size.width-chooseTimeLabelX;
    CGFloat chooseTimeLabelH=25;
    chooseTimeLabel.frame=CGRectMake(chooseTimeLabelX, chooseTimeLabelY, chooseTimeLabelW, chooseTimeLabelH);
    [timeButton addSubview:chooseTimeLabel];
    chooseTimeLabel.text=@"11:00";
    self.chooseTime=@"11:00";
    self.chooseTimeLabel=chooseTimeLabel;
    
    
    
    
    
    
    

    
    UIButton *reserveButton=[[UIButton alloc] init];
    reserveButton.frame=CGRectMake(0, SCREEN_HEIGHT-45-64, SCREEN_WIDTH, 45);
    [reserveButton setTitle:@"预约" forState:UIControlStateNormal];
    reserveButton.backgroundColor=ZCColor(229, 91, 52);
    [reserveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reserveButton addTarget:self action:@selector(clickTheReserveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    
}



//添加按钮上的文字布局
-(void)theTextOnTheAddButton:(UIButton *)button andTime:(long)dateTime
{
    
    
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"MM月dd日"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:dateTime];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
    
   // NSString *str=[NSString stringWithFormat:@"%@%@",[self JudgmentIsWhichDay:dateTime],nowDateString];
    
    
    UILabel *todayLabel=[[UILabel alloc] init];
    todayLabel.frame=CGRectMake(0, 7, button.frame.size.width, 20);
    todayLabel.text=[self JudgmentIsWhichDay:dateTime];
    todayLabel.textAlignment=NSTextAlignmentCenter;
    todayLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:todayLabel];
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(0, todayLabel.frame.size.height+7+5, button.frame.size.width, 20);
    timeLabel.text=nowDateString;
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.font=[UIFont systemFontOfSize:14];
    [button addSubview:timeLabel];
    

}





-(void)clickTheFirstButton
{
    ZCWeathersModel *model=self.weathersArray[0];
    [self ToControlTheAssignmentOnTheWeather:model];
    

    self.firstButton.selected=YES;
    self.secondButton.selected=NO;
    self.thirdButton.selected=NO;
    

    for (id label in self.firstButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=[UIColor whiteColor];
        }
    }
   
    for (id label in self.secondButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=ZCColor(85, 85, 85);
        }
    }

    for (id label in self.thirdButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=ZCColor(85, 85, 85);
        }
    }

    

}

-(void)clickTheSecondButton
{
    ZCWeathersModel *model=self.weathersArray[1];
    [self ToControlTheAssignmentOnTheWeather:model];
    
    self.firstButton.selected=NO;
    self.secondButton.selected=YES;
    self.thirdButton.selected=NO;
    
    
    for (id label in self.firstButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=ZCColor(85, 85, 85);
        }
    }
    
    for (id label in self.secondButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=[UIColor whiteColor];
        }
    }
    
    for (id label in self.thirdButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=ZCColor(85, 85, 85);
        }
    }

   
}

-(void)clickTheThirdButton
{
    ZCWeathersModel *model=self.weathersArray[2];
    [self ToControlTheAssignmentOnTheWeather:model];
    
    self.firstButton.selected=NO;
    self.secondButton.selected=NO;
    self.thirdButton.selected=YES;
   
    
    for (id label in self.firstButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=ZCColor(85, 85, 85);
        }
    }
    
    for (id label in self.secondButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=ZCColor(85, 85, 85);
        }
    }
    
    for (id label in self.thirdButton.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            UILabel *label1=label;
            label1.textColor=[UIColor whiteColor];
        }
    }

}


//点击预定
-(void)clickTheReserveButton
{
    NSDate *selfDate=[NSDate dateWithTimeIntervalSince1970:self.time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateFormatter stringFromDate:selfDate];
    //
   
    NSString *timeStr=[NSString stringWithFormat:@"%@ %@:00",selfStr,self.chooseTime];
    ZCLog(@"%@",timeStr);
    
    
    
     NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
     dateFormatter2.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter2 setLocale:[NSLocale currentLocale]];
   
     NSDate *timeDate=[dateFormatter2 dateFromString:timeStr];
    
     ZCLog(@"%@",timeDate);
//    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
//    NSInteger frominterval = [fromzone secondsFromGMTForDate: date];
//    NSDate *fromDate = [date  dateByAddingTimeInterval: frominterval];
    //吧时间变成时间濯
    long time=(long)[timeDate timeIntervalSince1970];
    
    ZCLog(@"%ld",time);
    
    
    
//    // 创建一个日期格式器
//    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
//    // 为日期格式器设置格式字符串
//    [nowDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    // 使用日期格式器格式化日期、时间
//    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:time];
//    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
//    
//    ZCLog(@"%@",nowDateString);
    
    
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=uuid;
    params[@"reserve_at"]=@(time);
    NSString *URL=[NSString stringWithFormat:@"%@v1/reservations",API];
    ZCLog(@"%@",token);
    ZCLog(@"%@",uuid);

    [ZCTool postWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        // 弹框
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"预定成功" message:@"球场预定成功，请在个人中心查看" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        // 设置对话框的类型
        alert.alertViewStyle=UIKeyboardTypeNumberPad;
        [alert show];
        
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
    
    
    
   
}


//点击选取时间
-(void)clickTheTimeButton
{
    ZCTimeView *timeView=[[ZCTimeView alloc] init];
    UIWindow *win=[[UIApplication sharedApplication].delegate window];
    timeView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    timeView.delegate=self;
    timeView.timeStr=self.chooseTime;
    [win addSubview:timeView];

}

-(void)timeViewChooseTime:(NSString *)chooseTime
{
    self.chooseTime=chooseTime;

    self.chooseTimeLabel.text=chooseTime;
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



//添加控件天气上的控件
-(void)addControlsForweatherView:(UIView *)view
{
   
    
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.textColor=ZCColor(180, 191, 195);
    [view addSubview:timeLabel];
    self.timeLabel=timeLabel;
    
    UIImageView *imageView=[[UIImageView alloc] init];
    
    [view addSubview:imageView];
    self.imageView=imageView;
    
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.textColor=ZCColor(180, 191, 195);
    textLabel.font=[UIFont systemFontOfSize:16];
    [view addSubview:textLabel];
    self.textLabel=textLabel;
    
    UILabel *temperatureLabel=[[UILabel alloc] init];
    
    temperatureLabel.font=[UIFont systemFontOfSize:75];
    temperatureLabel.textColor=ZCColor(180, 191, 195);
    [view addSubview:temperatureLabel];
    self.temperatureLabel=temperatureLabel;
    
    
    UIView *xianView=[[UIView alloc] init];
    xianView.backgroundColor=ZCColor(93, 94, 94);
    [view addSubview:xianView];
    self.xianView=xianView;
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
//    scrollView.frame=self.view.frame;
    [view addSubview:scrollView];
    self.scrollView=scrollView;
    
    UILabel *windLabel=[[UILabel alloc] init];
    windLabel.textColor=ZCColor(180, 191, 195);
    //windLabel.backgroundColor=[UIColor redColor];
    windLabel.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:windLabel];
    self.windLabel=windLabel;
    
    
//     ZCWeathersModel *model=self.weathersArray[0];
//    [self ToControlTheAssignmentOnTheWeather:model];
    
}


//给天气上面的控件赋值
-(void)ToControlTheAssignmentOnTheWeather:(ZCWeathersModel *)model
{
    //保存选中的时间
    self.time=model.date;
    
    self.timeLabel.frame=CGRectMake(10, 13, 180, 20);
    self.timeLabel.text=[self whatDayIsNow:model.date];

    
    
    
    CGFloat temperatureLabelH=80;
    CGFloat temperatureLabelW=[ZCTool getFrame:CGSizeMake(1000, temperatureLabelH) content:[NSString stringWithFormat:@"%@°",model.maximum_temperature] fontSize:[UIFont systemFontOfSize:75]].size.width;
    CGFloat temperatureLabelX=(self.view.frame.size.width-temperatureLabelW)/2;
    CGFloat temperatureLabelY=37+26+5;
    self.temperatureLabel.frame=CGRectMake(temperatureLabelX, temperatureLabelY, temperatureLabelW, temperatureLabelH);
    self.temperatureLabel.text=[NSString stringWithFormat:@"%@°",model.maximum_temperature];

    
    
    
    CGFloat imageViewW=32;
    CGFloat imageViewH=26;
    CGFloat imageViewX=temperatureLabelX;
    CGFloat imageViewY=37;
    self.imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
   
    self.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_icon",model.code]];
    //self.imageView.image=[UIImage imageNamed:@"3_icon"];
    CGFloat textLabelX=imageViewX+imageViewW+10;
    CGFloat textLabelY=imageViewY;
    CGFloat textLabelW=150;
    CGFloat textLabelH=30;
    self.textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
    self.textLabel.text=[NSString stringWithFormat:@"%@",model.content];

    
    
    
    
    

    CGFloat xianViewY=self.weatherView.frame.size.height-40;
    self.xianView.frame=CGRectMake(0, xianViewY, self.weatherView.frame.size.width, 0.5);
    
    
    self.scrollView.frame=CGRectMake(10, xianViewY+1, self.weatherView.frame.size.width-10, 39);
    
    self.windLabel.frame=CGRectMake(0, 0, [ZCTool getFrame:CGSizeMake(1000, 39) content:[NSString stringWithFormat:@"%@，降水概率%@",model.wind,model.probability_of_precipitation] fontSize:[UIFont systemFontOfSize:18]].size.width, 39);
    self.windLabel.text=[NSString stringWithFormat:@"%@，降水概率%@",model.wind,model.probability_of_precipitation];
    
    self.scrollView.contentSize=CGSizeMake([ZCTool getFrame:CGSizeMake(1000, 39) content:self.windLabel.text fontSize:[UIFont systemFontOfSize:18]].size.width+10, 0);
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
