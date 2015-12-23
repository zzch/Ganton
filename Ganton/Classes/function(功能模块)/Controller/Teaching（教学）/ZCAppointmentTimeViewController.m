//
//  ZCAppointmentTimeViewController.m
//  Ganton
//
//  Created by hh on 15/12/23.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAppointmentTimeViewController.h"

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
@end

@implementation ZCAppointmentTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"预约";
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    [self addControls];
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
    [webView loadHTMLString:@"2013年3月11日 - 4.pop返回table时,cell自动取消选中状态 首先我有一个UITableViewController,其中每个UITableViewCell点击后都会push另一个ViewController,每次点击Ce..." baseURL:nil];
    
    
    UIView *lastView=[[UIView alloc] init];
    lastView.frame=CGRectMake(0, webView.frame.origin.y+1, SCREEN_WIDTH, 290);
   
    [scrollView addSubview:lastView];
    self.lastView=lastView;
    [self addControlsWith:lastView];

   

    
    UIButton *button=[[UIButton alloc] init];
    button.frame=CGRectMake(0, self.view.frame.size.height-108, SCREEN_WIDTH, 45);
    button.backgroundColor=ZCColor(229, 91, 52);
    [button setTitle:@"预约" forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:button];
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
    self.scrollView.contentSize=CGSizeMake(0, self.lastView.frame.origin.y+webViewHeight+310);
    
}





-(void)addControlsWith:(UIView *)lastView
{
    UILabel *timeLabel=[[UILabel alloc] init];
    timeLabel.frame=CGRectMake(0, 18, SCREEN_WIDTH, 30);
    timeLabel.text=@"上课时间";
    timeLabel.textAlignment=NSTextAlignmentCenter;
    timeLabel.font=[UIFont systemFontOfSize:15];
    timeLabel.textColor=ZCColor(34, 34, 34);
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
//    if (self.weathersArray.count!=0) {
//        ZCWeathersModel *model=self.weathersArray[0];
//        [self theTextOnTheAddButton:firstButton andTime:model.date];
//        //默认点击第一个
//        [self clickTheFirstButton];
//    }
    [self theTextOnTheAddButton:firstButton andTime:1450828800];
    //默认点击第一个
    [self clickTheFirstButton];
    
    UIButton *secondButton=[[UIButton alloc] init];
    CGFloat secondButtonX=firstButtonX+firstButtonW+10;
    secondButton.frame=CGRectMake(secondButtonX, firstButtonY, firstButtonW, firstButtonH);
    [secondButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [secondButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    
    [secondButton addTarget:self action:@selector(clickTheSecondButton) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:secondButton];
    self.secondButton=secondButton;
//    if (self.weathersArray.count!=0) {
//        ZCWeathersModel *model2=self.weathersArray[1];
//        [self theTextOnTheAddButton:secondButton andTime:model2.date];
//    }
    [self theTextOnTheAddButton:secondButton andTime:1450828800];
    
    UIButton *thirdButton=[[UIButton alloc] init];
    CGFloat thirdButtonX=secondButtonX+firstButtonW+10;
    thirdButton.frame=CGRectMake(thirdButtonX, firstButtonY, firstButtonW, firstButtonH);
    [thirdButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_moren"] forState:UIControlStateNormal];
    [thirdButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateSelected];
    [thirdButton addTarget:self action:@selector(clickTheThirdButton) forControlEvents:UIControlEventTouchUpInside];
    [lastView addSubview:thirdButton];
    self.thirdButton=thirdButton;
    [self theTextOnTheAddButton:thirdButton andTime:1450828800];


    
    UIView *timeView=[[UIView alloc] init];
   // timeView.backgroundColor=[UIColor redColor];
    timeView.frame=CGRectMake(0, firstButtonY+firstButtonH+5, SCREEN_WIDTH, 175);
    [lastView addSubview:timeView];
    [self addTimeView:timeView];
    self.timeView=timeView;
    
    
   
    
    
}



-(void)addTimeView:(UIView *)view
{
    //间隙
    CGFloat marginX = 11;
    CGFloat marginY = 11;
    
    int totalColumns = 3;
    // 1.数字的尺寸
    CGFloat appW = (view.frame.size.width-(totalColumns+1)*marginX)/totalColumns;
    CGFloat appH=41;
    
    
    
    
    for (int j=0; j<9; j++) {
        
        UIButton *button=[[UIButton alloc] init];
        //button.backgroundColor=[UIColor whiteColor];
        button.tag=300+j;
        // 计算行号和列号
        int row = j / totalColumns;
        int col = j % totalColumns;
        
        // 计算x和y
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginY+row * (appH + marginY);
        
        [button setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_mr"] forState:UIControlStateNormal];
        button.frame = CGRectMake(appX, appY, appW, appH);
        
        [view addSubview:button];
        
        
        if (j==0) {
           [button setTitle:@"09:00-10:00" forState:UIControlStateNormal];
        }else if (j==1){
           [button setTitle:@"12:00-13:00" forState:UIControlStateNormal];
        }else if (j==2){
            [button setTitle:@"15:00-16:00" forState:UIControlStateNormal];
        }else if (j==3){
            [button setTitle:@"10:00-11:00" forState:UIControlStateNormal];
        }else if (j==4){
            [button setTitle:@"13:00-14:00" forState:UIControlStateNormal];
        }else if (j==5){
            [button setTitle:@"16:00-17:00" forState:UIControlStateNormal];
        }else if (j==6){
            [button setTitle:@"11:00-12:00" forState:UIControlStateNormal];
        }else if (j==7){
            [button setTitle:@"14:00-15:00" forState:UIControlStateNormal];
        }else if (j==8){
            [button setTitle:@"17:00-18:00" forState:UIControlStateNormal];
        }
        
        [button setTitleColor:ZCColor(166, 166, 166) forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(clickTheTimeViewButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    

}


//选择时间
-(void)clickTheTimeViewButton:(UIButton *)button
{
//    for (UIButton *tempbutton in self.timeView.subviews) {
//        [tempbutton setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_mr"] forState:UIControlStateNormal];
//    }

    
    [self.timeButton setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_mr"] forState:UIControlStateNormal];
    [self.timeButton setTitleColor:ZCColor(166, 166, 166) forState:UIControlStateNormal];
    
    self.timeButton=button;
    
    [button setBackgroundImage:[UIImage imageNamed:@"xttk_sj_bj_xz"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



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
    //    if ([ZCTool _valueOrNil:self.coachDetailsModel.portrait]==nil) {
    //        personImage.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    //    }else{
    //        [personImage sd_setImageWithURL:[NSURL URLWithString:self.coachDetailsModel.portrait] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
    //    }
    [view addSubview:personImage];
    
    
    UILabel *nameLabel=[[UILabel alloc] init];
    CGFloat nameLabelX=personImageX+personImageW+15;
    CGFloat nameLabelY=personImageY;
    CGFloat nameLabelW=100;
    CGFloat nameLabelH=25;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.font=[UIFont systemFontOfSize:18];
    nameLabel.text=@"青少年套课";
    [view addSubview:nameLabel];
    
    
    UILabel *titleLabel=[[UILabel alloc] init];
    CGFloat titleLabelX=nameLabelX;
    CGFloat titleLabelY=nameLabelY+nameLabelH+30;
    CGFloat titleLabelW=150;
    CGFloat titleLabelH=25;
    titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    titleLabel.textColor=ZCColor(85, 85, 85);
    titleLabel.font=[UIFont systemFontOfSize:14];
    titleLabel.text=@"教练: 刘阳";
    titleLabel.font=[UIFont systemFontOfSize:15];
    [view addSubview:titleLabel];
    //self.titleLabel=titleLabel;
    
    UILabel *typeLabel=[[UILabel alloc] init];
    CGFloat  typeLabelX=nameLabelX;
    CGFloat  typeLabelY=titleLabelY+titleLabelH+5;
    CGFloat  typeLabelW=200;
    CGFloat  typeLabelH=15;
    typeLabel.frame=CGRectMake(typeLabelX, typeLabelY, typeLabelW, typeLabelH);
    typeLabel.text=@"主教练";
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
//    ZCWeathersModel *model=self.weathersArray[1];
//    [self ToControlTheAssignmentOnTheWeather:model];
    
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
//    ZCWeathersModel *model=self.weathersArray[2];
//    [self ToControlTheAssignmentOnTheWeather:model];
    
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
