//
//  ZCAccountViewController.m
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAccountViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ZCHomeViewController.h"
@interface ZCAccountViewController ()<CLLocationManagerDelegate>
@property(nonatomic,weak)UITextField *phoneTextField;
@property(nonatomic,weak)UITextField *VerificationTextField;

//定位
@property(nonatomic,retain) CLLocationManager *locationMgr;

@property(nonatomic,assign) double latitude;

@property(nonatomic,assign) double longitude;

@end

@implementation ZCAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self addControls];
    
    
    //创建CLLocationManager定位
    [self initCLLocationManager];
}


//创建定位GPS
-(void)initCLLocationManager
{
    self.locationMgr=[[CLLocationManager alloc] init];
    self.locationMgr.delegate=self;
    self.locationMgr.desiredAccuracy=kCLLocationAccuracyBest;
    // 移动多少米开始重新定位
    self.locationMgr.distanceFilter=255.0;
    
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
        
    {
        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
        [self.locationMgr requestAlwaysAuthorization]; // 请求前台和后台定位权限
        [self.locationMgr startUpdatingLocation];
        
    }else
    {
        ZCLog(@"是iOS7");
        // 3.开始监听(开始获取位置)
        [self.locationMgr startUpdatingLocation];
    }
    
    
}



//代理方法实现

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
    // 如果只需要获取一次, 可以获取到位置之后就停止
    //  [self.locationMgr stopUpdatingLocation];
    
    // 1.获取最后一次的位置
    /*
     location.coordinate; 坐标, 包含经纬度
     location.altitude; 设备海拔高度 单位是米
     location.course; 设置前进方向 0表示北 90东 180南 270西
     location.horizontalAccuracy; 水平精准度
     location.verticalAccuracy; 垂直精准度
     location.timestamp; 定位信息返回的时间
     location.speed; 设备移动速度 单位是米/秒, 适用于行车速度而不太适用于不行
     */
    /*
     可以设置模拟器模拟速度
     bicycle ride 骑车移动
     run 跑动
     freeway drive 高速公路驾车
     */
    CLLocation *location = [locations lastObject];
    ZCLog(@"%f, %f ", location.coordinate.latitude , location.coordinate.longitude);
    self.longitude=location.coordinate.longitude;
    self.latitude=location.coordinate.latitude;
    
    //网络数据加载
    [self addControls];
    
}



//获取失败时候调用或者用户拒绝时候调用
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    ZCLog(@"%@",error);
    
    self.longitude=0;
    self.latitude=0;
    
    //网络数据加载
    [self addControls];
}



-(void)addControls
{

    UITextField *phoneTextField=[[UITextField alloc] init];
    phoneTextField.frame=CGRectMake(20, 100, SCREEN_WIDTH-40, 40);
    phoneTextField.backgroundColor=[UIColor redColor];
    [self.view addSubview:phoneTextField];
    self.phoneTextField=phoneTextField;
    
    [phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}


-(void)phoneTextFieldDidChange:(UITextField *)textField
{
    if (textField.text.length==11) {
        if ([ZCTool validateMobile:textField.text]) {
            [self networkRequest];
        }else{
            [MBProgressHUD showError:@"手机号输入有误"];
        }
        
    }

}


//网络请求
-(void)networkRequest
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"phone"]=self.phoneTextField.text;
    if (!self.longitude==0) {
        params[@"longitude"] = @(self.longitude);
        params[@"latitude"]=@(self.latitude) ;
    }
    
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/welcome",API];
    [ZCTool  getWithUrl:URL params:params success:^(id responseObject) {
        
        //成功
        [self theRequestIsSuccessful:responseObject[@"sentences"]];
        ZCLog(@"%@",responseObject[@"sentences"]);
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
   
}


//成功
-(void)theRequestIsSuccessful:(NSArray *)array
{
    UILabel *welcomeLabel=[[UILabel alloc] init];
    welcomeLabel.text=[NSString stringWithFormat:@"%@",array[0]];
    welcomeLabel.alpha=0.1;
    welcomeLabel.textAlignment=NSTextAlignmentCenter;
    welcomeLabel.frame=CGRectMake(0, 200, SCREEN_WIDTH, 30);
    [self.view addSubview:welcomeLabel];
    
    UILabel *welcomeLabel2=[[UILabel alloc] init];
    welcomeLabel2.text=[NSString stringWithFormat:@"%@",array[1]];
    welcomeLabel2.alpha=0.1;
    welcomeLabel2.textAlignment=NSTextAlignmentCenter;
    welcomeLabel2.frame=CGRectMake(0, 250, SCREEN_WIDTH, 30);
    [self.view addSubview:welcomeLabel2];

    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        welcomeLabel.transform = CGAffineTransformMakeScale(1.3, 1.3);
        welcomeLabel.alpha=1.0;
        
        welcomeLabel2.transform = CGAffineTransformMakeScale(1.3, 1.3);
        welcomeLabel2.alpha=1.0;
        
    } completion:^(BOOL finished) {
       
     
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        
        UITextField *VerificationTextField=[[UITextField alloc] init];
        VerificationTextField.frame=CGRectMake(120, 300, SCREEN_WIDTH-240, 40);
        VerificationTextField.backgroundColor=[UIColor redColor];
        [self.view addSubview:VerificationTextField];
        self.VerificationTextField=VerificationTextField;
        
    } completion:^(BOOL finished) {
        
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        UIButton *landingButton=[[UIButton alloc] init];
        landingButton.frame=CGRectMake(100, 370, SCREEN_WIDTH-200, 30);
        [landingButton setTitle:@"登陆" forState:UIControlStateNormal];
        [landingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        landingButton.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:landingButton];
        [landingButton addTarget:self action:@selector(clickTheLandingButton) forControlEvents:UIControlEventTouchUpInside];
        
    } completion:^(BOOL finished) {
        
    }];
        
    }];
     

        
    }];
    
}

//点击登陆
-(void)clickTheLandingButton
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"phone"]=self.phoneTextField.text;
    params[@"verification_code"]=self.VerificationTextField.text;
    if (!self.longitude==0) {
        params[@"longitude"] = @(self.longitude);
        params[@"latitude"]=@(self.latitude) ;
    }

    NSString *URL=[NSString stringWithFormat:@"%@v1/sign_in",API];
    
    [ZCTool postWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        NSUserDefaults *userDf = [NSUserDefaults standardUserDefaults];
        [userDf setObject:responseObject[@"club"][@"uuid"] forKey:@"uuid"];
        if ([ZCTool _valueOrNil:responseObject[@"user"][@"birthday"]] ) {
            [userDf setObject:responseObject[@"user"][@"birthday"] forKey:@"birthday"];
        }
        if ([ZCTool _valueOrNil:responseObject[@"user"][@"birthday"]] ) {
            [userDf setObject:responseObject[@"user"][@"portrait"] forKey:@"portrait"];
        }
        
        [userDf setObject:responseObject[@"user"][@"gender"] forKey:@"gender"];
        [userDf setObject:responseObject[@"user"][@"name"] forKey:@"name"];
        
        [userDf setObject:responseObject[@"user"][@"token"] forKey:@"token"];
        
        ZCLog(@"%@",[userDf objectForKey:@"token"]);
        
        UIWindow *window=[[UIApplication sharedApplication].delegate window];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ZCHomeViewController alloc] init]];
        window.rootViewController = nav;
        
        
    } failure:^(NSError *error) {
        
        ZCLog(@"%@",error);
        
    }];
  
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
