//
//  ZCReservationViewController.m
//  Ganton
//
//  Created by hh on 15/10/9.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCReservationViewController.h"
#import "ZCWeathersModel.h"
@interface ZCReservationViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,weak)UILabel *timeLabel;
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UILabel *temperatureLabel;
@property(nonatomic,weak)UILabel *textLabel;
@property(nonatomic,strong)NSMutableArray *weathersArray;
@property(nonatomic,strong)NSArray *pickArray;

@property(nonatomic,weak)UIPickerView *pickView;

@property(nonatomic,copy)NSString *chooseTime;
//选中今天  明天 的时间戳
@property(nonatomic,assign)long time;
@end

@implementation ZCReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
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
        return @"今天";
    }else if (cmps.day == 1){
       return @"明天";
    }else if (cmps.day == 2){
       return @"后天";
    }else if (cmps.day == 3){
        return @"大后天";
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
    
    ZCWeathersModel *model=self.weathersArray[0];
    
     //NSString *whichDay=[self JudgmentIsWhichDay:model.date];

    [firstButton setTitle:[self JudgmentIsWhichDay:model.date] forState:UIControlStateNormal];
    [firstButton addTarget:self action:@selector(clickTheFirstButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstButton];
    
    
    UIButton *secondButton=[[UIButton alloc] init];
    CGFloat secondButtonX=firstButtonX+firstButtonW+10;
    secondButton.frame=CGRectMake(secondButtonX, firstButtonY, firstButtonW, firstButtonH);
    secondButton.backgroundColor=[UIColor redColor];
    ZCWeathersModel *model2=self.weathersArray[1];
    
    [secondButton setTitle:[self JudgmentIsWhichDay:model2.date] forState:UIControlStateNormal];
    [secondButton addTarget:self action:@selector(clickTheSecondButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondButton];
    
    
    UIButton *thirdButton=[[UIButton alloc] init];
    CGFloat thirdButtonX=secondButtonX+firstButtonW+10;
    thirdButton.frame=CGRectMake(thirdButtonX, firstButtonY, firstButtonW, firstButtonH);
    thirdButton.backgroundColor=[UIColor redColor];
    ZCWeathersModel *model3=self.weathersArray[2];
    [thirdButton setTitle:[self JudgmentIsWhichDay:model3.date] forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(clickTheThirdButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdButton];

    
    
    
    
    
    UIPickerView *pickView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    pickView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickView.delegate=self;
    pickView.dataSource = self;
    //pickView.tintColor=[UIColor whiteColor];
    CGFloat pickViewW=SCREEN_WIDTH;
    CGFloat pickViewH=260;
    CGFloat pickViewX=0;
    CGFloat pickViewY=thirdButton.frame.size.height+thirdButton.frame.origin.y+20;
    pickView.frame = CGRectMake(pickViewX, pickViewY, pickViewW, pickViewH);
    pickView.showsSelectionIndicator = YES;
    self.pickView=pickView;
    
    [self.view addSubview:pickView];
    

    
    UIButton *reserveButton=[[UIButton alloc] init];
    reserveButton.frame=CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [reserveButton setTitle:@"预定" forState:UIControlStateNormal];
    reserveButton.backgroundColor=[UIColor brownColor];
    [reserveButton addTarget:self action:@selector(clickTheReserveButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    
}


-(void)clickTheFirstButton
{
    ZCWeathersModel *model=self.weathersArray[0];
    
    self.timeLabel.text=[self whatDayIsNow:model.date];
    self.imageView.backgroundColor=[UIColor redColor];
    self.textLabel.text=[NSString stringWithFormat:@"%@",model.content];
    self.temperatureLabel.text=[NSString stringWithFormat:@"%@°",model.maximum_temperature];

    self.time=model.date;

}

-(void)clickTheSecondButton
{
    ZCWeathersModel *model=self.weathersArray[1];
    
    self.timeLabel.text=[self whatDayIsNow:model.date];
    self.imageView.backgroundColor=[UIColor blackColor];
    self.textLabel.text=[NSString stringWithFormat:@"%@",model.content];
    self.temperatureLabel.text=[NSString stringWithFormat:@"%@°",model.maximum_temperature];

    self.time=model.date;

}

-(void)clickTheThirdButton
{
    ZCWeathersModel *model=self.weathersArray[2];
    
    self.timeLabel.text=[self whatDayIsNow:model.date];
    self.imageView.backgroundColor=[UIColor yellowColor];
    self.textLabel.text=[NSString stringWithFormat:@"%@",model.content];
    self.temperatureLabel.text=[NSString stringWithFormat:@"%@°",model.maximum_temperature];


    self.time=model.date;
}


//点击预定
-(void)clickTheReserveButton
{
    NSDate *selfDate=[NSDate dateWithTimeIntervalSince1970:self.time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateFormatter stringFromDate:selfDate];
    
    NSString *timeStr=[NSString stringWithFormat:@"%@ %@:00",selfStr,self.chooseTime];
    ZCLog(@"%@",timeStr);
    
     NSDate *date=[dateFormatter dateFromString:selfStr];
    
    //吧时间变成时间濯
    long time=(long)[date timeIntervalSince1970];
    ZCLog(@"%ld",time);
    
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
    ZCWeathersModel *model=self.weathersArray[0];
    self.time=model.date;
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(10, 10, 180, 20);
    timeLabel.text=[self whatDayIsNow:model.date];
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
    
    UILabel *textLabel=[[UILabel alloc] init];
    CGFloat textLabelX=imageViewX+imageViewW+10;
    CGFloat textLabelY=imageViewY;
    CGFloat textLabelW=100;
    CGFloat textLabelH=30;
    textLabel.text=[NSString stringWithFormat:@"%@",model.content];
    textLabel.frame=CGRectMake(textLabelX, textLabelY, textLabelW, textLabelH);
    [view addSubview:textLabel];
    self.textLabel=textLabel;
    
    UILabel *temperatureLabel=[[UILabel alloc] init];
    temperatureLabel.frame=CGRectMake(view.frame.size.width-60, 10, 40, 30);
    temperatureLabel.text=[NSString stringWithFormat:@"%@°",model.maximum_temperature];
    [view addSubview:temperatureLabel];
    self.temperatureLabel=temperatureLabel;
    
    
}




-(NSArray *)pickArray
{
    if (_pickArray==nil) {
        _pickArray=[NSArray array];
//        NSMutableArray *pickArray1=[NSMutableArray array];
//        for (int i = 0; i < 81; i ++) {
//            [pickArray1 addObject:[NSString stringWithFormat:@"%d",i*5]];
//        }
        
        
        //NSArray *pickArray2=[NSArray array];
        _pickArray=@[@"8:30",@"8:45",@"9:00",@"9:15",@"9:30",@"9:45",@"10:00",@"10:15",@"10:30",@"10:45",@"11:00",@"11:15",@"11:30",@"11:45",@"12:00",@"12:15",@"12:30",@"12:45",@"13:00"];
        
        //_pickArray=@[pickArray1,pickArray2];
        
    }
    
    return _pickArray;
}



#pragma mark - 数据源方法


/**
 *  一共有多少列
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    ZCLog(@"%lu",(unsigned long)self.pickArray.count);
    return 1;
    
    
    
}

/**
 *  第component列显示多少行
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.pickArray.count;
}


/**
 *  第component列的第row行显示什么文字
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickArray[component][row];
}


/**
 *  选中了第component列的第row行
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    self.chooseTime=self.pickArray[row];
    
//    if (component == 0) { //
//        self.distanceLabel.text = self.pickArray[component][row];
//    } else if (component == 1) { //
//        self.hitLabel.text = self.pickArray[component][row];
//    }
    
    
    
    
    
    
}

//改变pickview的字体颜色

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    title = [NSString stringWithFormat:@"%@",self.pickArray[row]];
//    if (component==0) {
//        title = [NSString stringWithFormat:@"%@码",self.pickArray[row]];
//    }else{
//        title = [NSString stringWithFormat:@"%@",self.pickArray[component][row]];
//    }
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:ZCColor(85, 85, 85)}];
    
    return attString;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return 120;
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
