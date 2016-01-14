//
//  ZCAppointmentTimeViewController.m
//  Ganton
//
//  Created by hh on 15/12/23.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAppointmentTimeViewController.h"
#import "ZCPrivateCoursesModel.h"
#import "ZCRecentlyScheduleModel.h"
#import "ZCScheduleModel.h"
#import "ZCPrivateAppointmentView.h"
@interface ZCAppointmentTimeViewController ()<UIWebViewDelegate>
@property(nonatomic,assign)CGFloat webViewHight;
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIWebView *webView;

@property(nonatomic,weak)UIView *lastView;
@property(nonatomic,weak)UIButton *firstButton;
@property(nonatomic,weak)UIButton *secondButton;
@property(nonatomic,weak)UIButton *thirdButton;

@property(nonatomic,weak)UIView *timeView;

@property(nonatomic,weak)UIButton *timeButton;

@property(nonatomic,strong)ZCPrivateCoursesModel *privateCoursesModel;
//选中的数组，传递给pickerView的值
@property(nonatomic,strong)NSMutableArray *pickArray;
@property(nonatomic,weak)UIView *rightView;
@end

@implementation ZCAppointmentTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"预约";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    [self onlineData];
}



//请求数据
-(void)onlineData
{
    [MBProgressHUD showMessage:@"正在加载..."];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *club_uuid = [defaults objectForKey:@"uuid"];
    params[@"token"]=token;
    params[@"club_uuid"]=club_uuid;
    params[@"uuid"]=self.uuid;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/private_courses/detail.json",API];
    
        ZCLog(@"%@",token);
        ZCLog(@"%@",club_uuid);
        ZCLog(@"%@",self.uuid);
    
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        ZCPrivateCoursesModel *privateCoursesModel=[ZCPrivateCoursesModel privateCoursesModelWithDict:responseObject];
        self.privateCoursesModel=privateCoursesModel;
        
        [self addControls];
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        ZCLog(@"%@",error);
        
    }];
    
}






//添加控件
-(void)addControls
{
    
    UIScrollView *scrollView=[[UIScrollView alloc] init];
    scrollView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //scrollView.delaysContentTouches=YES;
    [self.view addSubview:scrollView];
    self.scrollView=scrollView;
    
    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 122);
    [scrollView addSubview:topView];
    topView.backgroundColor=[UIColor whiteColor];
    [self addTopViewControls:topView];
    
    
    UIWebView *webView=[[UIWebView alloc] init];
    webView.frame=CGRectMake(0, topView.frame.size.height+topView.frame.origin.y+15, SCREEN_WIDTH, 1);
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.scrollEnabled = NO;
    [webView sizeToFit];
    
    webView.delegate=self;
    
    [scrollView addSubview:webView];
    self.webView=webView;
    [webView loadHTMLString:self.privateCoursesModel.Description baseURL:nil];
    
    
    UIView *lastView=[[UIView alloc] init];
    lastView.frame=CGRectMake(0, webView.frame.origin.y+1, SCREEN_WIDTH, 400);
    
    [scrollView addSubview:lastView];
    self.lastView=lastView;
    [self addControlsWith:lastView];

   

    
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(0, self.view.frame.size.height-45, SCREEN_WIDTH, 45);
    button.backgroundColor=ZCColor(229, 91, 52);
    [button setTitle:@"预约" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(clickTheYuDing) forControlEvents:UIControlEventTouchUpInside];
}

//点击预订
-(void)clickTheYuDing
{
    ZCPrivateAppointmentView *PrivateAppointmentView=[[ZCPrivateAppointmentView alloc] init];
    UIWindow *win=[[UIApplication sharedApplication].delegate window];
    PrivateAppointmentView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    PrivateAppointmentView.delegate=self;
    PrivateAppointmentView.array=self.pickArray;
    [win addSubview:PrivateAppointmentView];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    // self.scrollView.contentSize=CGSizeMake(0, webViewHeight+130);
    CGFloat W=[webView.scrollView contentSize].width;
    ZCLog(@"%f",webViewHeight);
    CGFloat bei=(SCREEN_WIDTH)/W;
    NSString *str=[NSString stringWithFormat:@"document.body.style.zoom=%f",bei];
    [webView
     stringByEvaluatingJavaScriptFromString:str];
    
    self.lastView.frame=CGRectMake(0, webView.frame.origin.y+webViewHeight, SCREEN_WIDTH, 290);
    self.scrollView.contentSize=CGSizeMake(0, self.lastView.frame.origin.y+webViewHeight+450);
    
}





-(void)addControlsWith:(UIView *)lastView
{
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(0, 18, SCREEN_WIDTH, 30);
    timeLabel.text=@"上课时间";
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.font=[UIFont systemFontOfSize:15];
    timeLabel.textColor=ZCColor(85, 85, 85);
    [lastView addSubview:timeLabel];
    
    UIButton *firstButton=[[UIButton alloc] init];
    CGFloat firstButtonX=10;
    CGFloat firstButtonY=timeLabel.frame.size.height+timeLabel.frame.origin.y+10;
    CGFloat firstButtonW=(SCREEN_WIDTH-40)/3;
    CGFloat firstButtonH=59;
    firstButton.frame=CGRectMake(firstButtonX, firstButtonY, firstButtonW, firstButtonH);
    [firstButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [firstButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    [firstButton addTarget:self action:@selector(clickTheFirstButton) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:firstButton];
    
    self.firstButton=firstButton;
    if (self.privateCoursesModel.recently_scheduleArray.count!=0) {
        ZCRecentlyScheduleModel *model=self.privateCoursesModel.recently_scheduleArray[0];
       // ZCLog(@"%ld",model.date);
        [self theTextOnTheAddButton:firstButton andTime:model.date];
        //默认点击第一个
        
        [self clickTheFirstButton];
    }
//    [self theTextOnTheAddButton:firstButton andTime:1450828800];
//    //默认点击第一个
//    [self clickTheFirstButton];
    
    UIButton *secondButton=[[UIButton alloc] init];
    CGFloat secondButtonX=firstButtonX+firstButtonW+10;
    secondButton.frame=CGRectMake(secondButtonX, firstButtonY, firstButtonW, firstButtonH);
    [secondButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [secondButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    
    [secondButton addTarget:self action:@selector(clickTheSecondButton) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:secondButton];
    self.secondButton=secondButton;
    if (self.privateCoursesModel.recently_scheduleArray.count!=0) {
        ZCRecentlyScheduleModel *model2=self.privateCoursesModel.recently_scheduleArray[1];
        [self theTextOnTheAddButton:secondButton andTime:model2.date];
    }
  //  [self theTextOnTheAddButton:secondButton andTime:1450828800];
    
    UIButton *thirdButton=[[UIButton alloc] init];
    CGFloat thirdButtonX=secondButtonX+firstButtonW+10;
    thirdButton.frame=CGRectMake(thirdButtonX, firstButtonY, firstButtonW, firstButtonH);
    [thirdButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [thirdButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    [thirdButton addTarget:self action:@selector(clickTheThirdButton) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:thirdButton];
    self.thirdButton=thirdButton;
    if (self.privateCoursesModel.recently_scheduleArray.count!=0) {
        ZCRecentlyScheduleModel *model3=self.privateCoursesModel.recently_scheduleArray[2];
        [self theTextOnTheAddButton:thirdButton andTime:model3.date];
    }

    


    
    UIView *timeView=[[UIView alloc] init];
    timeView.frame=CGRectMake(0, firstButtonY+firstButtonH+5, SCREEN_WIDTH, 250);
    [lastView addSubview:timeView];
    [self addTimeView:timeView];
    self.timeView=timeView;
    
    
   //337
    
    
}






//时间显示View
-(void)addTimeView:(UIView *)view
{
    
    UILabel *topLabel=[[UILabel alloc] init];
    topLabel.frame=CGRectMake(0, 5, SCREEN_WIDTH, 20);
    topLabel.textAlignment=NSTextAlignmentCenter;
    topLabel.text=@"注释:一个方格等于15分钟";
    topLabel.textColor=ZCColor(85, 85, 85);
    topLabel.font=[UIFont systemFontOfSize:14];
    [view addSubview:topLabel];
    
    UIImageView *leftView=[[UIImageView alloc] init];
    leftView.frame=CGRectMake(10, 30, 60, 168);
    leftView.image=[UIImage imageNamed:@"sw" ];
    [view addSubview:leftView];

    
    UIView *rightView=[[UIView alloc] init];
    
    rightView.frame=CGRectMake(70, 30, SCREEN_WIDTH-80, 168);
    [view addSubview:rightView];
    self.rightView=rightView;
    
    UIImageView *imageview=[[UIImageView alloc] init];
    imageview.frame=CGRectMake((view.frame.size.width-211)/2, 210, 211, 20);
    imageview.image=[UIImage imageNamed:@"bukeyuyue"];
    [view addSubview:imageview];
    
    
    
    
    //间隙
    CGFloat marginX = 0.5;
    CGFloat marginY = 0.5;
    
    int totalColumns = 8;
    // 1.数字的尺寸
    CGFloat appW = (rightView.frame.size.width-(totalColumns+1)*marginX)/totalColumns;
    CGFloat appH=(rightView.frame.size.height-(8)*marginX)/7;
    
    //ZCLog(@"%lu",(unsigned long)[self.privateCoursesModel.recently_scheduleArray[0] scheduleArray].count);
    
    
    for (int j=0; j<56; j++) {
        
        UIButton *button=[[UIButton alloc] init];
        //label.backgroundColor=[UIColor blueColor];
        //label.tag=300+j;
        // 计算行号和列号
        int row = j / totalColumns;
        int col = j % totalColumns;
        
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);
        
        //[button setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_mr"] forState:UIControlStateNormal];
        button.frame = CGRectMake(appX, appY, appW, appH);
        button.titleLabel.font=[UIFont systemFontOfSize:9];
        [rightView addSubview:button];
        
        

    }
    
 //   ZCLog(@"%d",self.rightView.subviews.count);
    //给九宫格赋值
    [self refreshTimeView:[self.privateCoursesModel.recently_scheduleArray[0] scheduleArray]];
    

    

}


////选择时间
//-(void)clickTheTimeViewButton:(UIButton *)button
//{
//    [self.timeButton setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_mr"] forState:UIControlStateNormal];
//    [self.timeButton setTitleColor:ZCColor(166, 166, 166) forState:UIControlStateNormal];
//    
//    self.timeButton=button;
//    
//    [button setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_xz"] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//}



-(void)addTopViewControls:(UIView *)view
{
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=15;
    CGFloat personImageY=(view.frame.size.height-104)/2;
    CGFloat personImageW=75;
    CGFloat personImageH=104;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.layer.cornerRadius=5;//设置圆角的半径为10
    personImage.layer.masksToBounds=YES;
    personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
        if ([ZCTool _valueOrNil:self.privateCoursesModel.portrait]==nil) {
            personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
        }else{
            [personImage sd_setImageWithURL:[NSURL URLWithString:self.privateCoursesModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
        }
    [view addSubview:personImage];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=SCREEN_WIDTH-nameLabelX-20;
    CGFloat nameLabelH=25;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.font=[UIFont systemFontOfSize:18];
    nameLabel.text=[NSString stringWithFormat:@"%@",self.privateCoursesModel.name];
    [view addSubview:nameLabel];
    
    
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH+30;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.textColor=ZCColor(85, 85, 85);
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.text=[NSString stringWithFormat:@"教练: %@",self.privateCoursesModel.coachName];
    titleLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:titleLabel];
    //self.titleLabel=titleLabel;
    
    UILabel *typeLabel=[[UILabel alloc] init];
    CGFloat  typeLabelX=nameLabelX;
    CGFloat  typeLabelY=titleLabelY+titleLabelH+5;
    CGFloat  typeLabelW=200;
    CGFloat  typeLabelH=15;
    typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    typeLabel.text=[NSString stringWithFormat:@"%@",self.privateCoursesModel.title];
    typeLabel.textColor=ZCColor(85, 85, 85);
    typeLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:typeLabel];
    
    
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




-(void)clickTheFirstButton
{
   // ZCWeathersModel *model=self.weathersArray[0];
    //[self ToControlTheAssignmentOnTheWeather:model];
    [self refreshTimeView:[self.privateCoursesModel.recently_scheduleArray[0] scheduleArray]];
    
    self.pickArray=[self.privateCoursesModel.recently_scheduleArray[0] scheduleArray];
    
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
    self.pickArray=[self.privateCoursesModel.recently_scheduleArray[1] scheduleArray];
//    ZCWeathersModel *model=self.weathersArray[1];
//    [self ToControlTheAssignmentOnTheWeather:model];
    [self refreshTimeView:[self.privateCoursesModel.recently_scheduleArray[1] scheduleArray]];
    
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
    self.pickArray=[self.privateCoursesModel.recently_scheduleArray[2] scheduleArray];
//    ZCWeathersModel *model=self.weathersArray[2];
//    [self ToControlTheAssignmentOnTheWeather:model];
    
    [self refreshTimeView:[self.privateCoursesModel.recently_scheduleArray[2] scheduleArray]];
    
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




//刷新timeView里的九宫格数据
-(void)refreshTimeView:(NSMutableArray *)array
{
    

   
    
    for (int i=0; i<self.rightView.subviews.count; i++) {
        UIButton *label=self.rightView.subviews[i];
        ZCScheduleModel *model=array[i];
        if ([model.state isEqual:@"available"]) {
            label.backgroundColor=ZCColor(27, 162, 62);
        }else{
            label.backgroundColor=ZCColor(204, 87, 27);
        }
        
        
        if (i==0) {
           // label.text=@"08:00";
            [label setTitle:@"08:00" forState:UIControlStateNormal];
        }else if (i==4){
           //  label.text=@"09:00";
            [label setTitle:@"09:00" forState:UIControlStateNormal];
        }else if (i==8){
           // label.text=@"10:00";
            [label setTitle:@"10:00" forState:UIControlStateNormal];
        }else if (i==12){
           // label.text=@"11:00";
            [label setTitle:@"11:00" forState:UIControlStateNormal];
        }else if (i==16){
            //label.text=@"12:00";
            [label setTitle:@"12:00" forState:UIControlStateNormal];
        }else if (i==20){
            //label.text=@"13:00";
            [label setTitle:@"13:00" forState:UIControlStateNormal];
        }else if (i==24){
           // label.text=@"14:00";
            [label setTitle:@"14:00" forState:UIControlStateNormal];
        }else if (i==28){
            //label.text=@"15:00";
            [label setTitle:@"15:00" forState:UIControlStateNormal];
        }else if (i==32){
            //label.text=@"16:00";
            [label setTitle:@"16:00" forState:UIControlStateNormal];
        }else if (i==36){
           // label.text=@"17:00";
            [label setTitle:@"17:00" forState:UIControlStateNormal];
        }else if (i==40){
           // label.text=@"18:00";
            [label setTitle:@"18:00" forState:UIControlStateNormal];
        }else if (i==44){
            //label.text=@"19:00";
            [label setTitle:@"19:00" forState:UIControlStateNormal];
        }else if (i==48){
            //label.text=@"20:00";
            [label setTitle:@"20:00" forState:UIControlStateNormal];
        }else if (i==52){
            //label.text=@"21:00";
            [label setTitle:@"21:00" forState:UIControlStateNormal];
        }
//
        
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
