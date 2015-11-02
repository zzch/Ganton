//
//  ZCBirthdayViewController.m
//  Ganton
//
//  Created by hh on 15/10/28.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCBirthdayViewController.h"

@interface ZCBirthdayViewController ()
@property(nonatomic,weak)UILabel *birthdayLabel;
@property(nonatomic,weak)UILabel *ageLabel;
@property(nonatomic,assign)long time;
@end

@implementation ZCBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title=@"生日";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(clickTheRight)];
    
    
    UIView *ageView=[[UIView alloc] init];
    ageView.frame=CGRectMake(0, 20, SCREEN_WIDTH, 50);
    ageView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:ageView];
    [self addControlsWithView:ageView];
    
    
    UIView *bjxView=[[UIView alloc] init];
    bjxView.frame=CGRectMake(0, ageView.frame.size.height+ageView.frame.origin.y, 10, 1);
    bjxView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bjxView];
    
    UIView *birthdayView=[[UIView alloc] init];
    birthdayView.frame=CGRectMake(0, ageView.frame.size.height+ageView.frame.origin.y+1, SCREEN_WIDTH, 50);
    birthdayView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:birthdayView];
    [self addControlsWithView2:birthdayView];
    
    
    UIView *datePickView=[[UIView alloc] init];
    datePickView.frame=CGRectMake(0, SCREEN_HEIGHT-264, SCREEN_WIDTH, 200);
    [self.view addSubview:datePickView];
    [self addControlsWithView3:datePickView];
    
    
    
    
    
}


-(void)addControlsWithView:(UIView *)view
{
    UILabel *label1=[[UILabel alloc] init];
    label1.frame=CGRectMake(10, 0, 100, view.frame.size.height);
    label1.text=@"年龄";
    [view addSubview:label1];
    
    
    UILabel *agelabel=[[UILabel alloc] init];
    agelabel.frame=CGRectMake(view.frame.size.width-110, 0, 100, view.frame.size.height);
    agelabel.text=@"22";
    agelabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:agelabel];
    self.ageLabel=agelabel;
    
    
    if ([ZCTool _valueOrNil:self.birthday]==nil) {
        self.ageLabel.text=@"";
    }else{
        
        long data=[self.birthday longLongValue];
        // 创建一个日期格式器
        self.ageLabel.text=[self timeDifferenceAlgorithm:data];
    }

}


-(void)addControlsWithView2:(UIView *)view
{
    UILabel *label1=[[UILabel alloc] init];
    label1.frame=CGRectMake(10, 0, 100, view.frame.size.height);
    label1.text=@"生日";
    [view addSubview:label1];
    
    
    UILabel *birthdayLabel=[[UILabel alloc] init];
    birthdayLabel.frame=CGRectMake(view.frame.size.width-110, 0, 100, view.frame.size.height);
    birthdayLabel.text=@"1993-1-1";
    birthdayLabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:birthdayLabel];
    self.birthdayLabel=birthdayLabel;
    
    
    if ([ZCTool _valueOrNil:self.birthday]==nil) {
        self.birthdayLabel.text=@"未设置";
    }else{
        
       
        long data=[self.birthday longLongValue];
        // 创建一个日期格式器
        NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
        // 为日期格式器设置格式字符串
        [nowDateFormatter setDateFormat:@"yyyy-MM-dd"];
        // 使用日期格式器格式化日期、时间
        NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:data];
        NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
        
        self.birthdayLabel.text=nowDateString;
    }

    
}




-(NSString *)timeDifferenceAlgorithm:(long)data
{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:data];
    
    NSString *person = [dateFormatter stringFromDate:confromTimesp];
    
    int age=[person intValue];
    
    
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *nowDate = [NSDate date];
    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    
    int now=[nowDateString intValue];
    
    return [NSString stringWithFormat:@"%d",now-age];
}



-(void)addControlsWithView3:(UIView *)view
{

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:0];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    [comps setYear:-100];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    
    
    UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:CGRectZero];
    //模式
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //[datePicker setValue:ZCColor(85, 85, 85) forKeyPath:@"textColor"];
    // [ datePicker setDate:[datePicker date] animated:YES];
    
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];
    
    [view addSubview:datePicker];

}



-(void)dateChange:(UIDatePicker *)datePicker
{
    // ZCLog(@"%@",[ datePicker date]);
    
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    self.birthdayLabel.text=destDateString;
    //[self.birtdayLabel setTitle:destDateString forState:UIControlStateNormal];
    
    //吧时间变成时间濯
    long time=(long)[selected timeIntervalSince1970];
    self.time=time;
    
    self.ageLabel.text=[self timeDifferenceAlgorithm:time];
}



-(void)clickTheRight
{
    if ([self.delegate respondsToSelector:@selector(birthdayViewControllerDelegate:)]) {
        [self.delegate birthdayViewControllerDelegate:self.time];
        [self.navigationController popViewControllerAnimated:YES];
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
