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
#import "APService.h"
@interface ZCAccountViewController ()<CLLocationManagerDelegate,UITextFieldDelegate>
@property(nonatomic,weak)UITextField *PhoneTextField;
@property(nonatomic,weak)UITextField *VerificationTextField;

//定位
@property(nonatomic,retain) CLLocationManager *locationMgr;

@property(nonatomic,assign) double latitude;

@property(nonatomic,assign) double longitude;




@property(nonatomic,weak)UIView *view1;

@property(nonatomic,weak)UIView *welcomeView;
@property(nonatomic,weak)UIView *welcomeView2;
@property(nonatomic,weak)UIView *thirdView;
@property(nonatomic,weak)UIButton *landingButton;

@property(nonatomic,weak)UIView *failureView;
//验证码按钮
@property(nonatomic,weak)UIButton *getButton;


@property(nonatomic,strong)id time;
@end

@implementation ZCAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self addControls];
    
    self.navigationItem.title=@"用户登录";
   
   
    
    self.view.backgroundColor=[UIColor whiteColor];
    //创建CLLocationManager定位
    [self initCLLocationManager];
    
    [self addControls];
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
    
    
}



//获取失败时候调用或者用户拒绝时候调用
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    ZCLog(@"%@",error);
    
    self.longitude=0;
    self.latitude=0;
    
    //网络数据加载
    //[self addControls];
}



-(void)addControls
{
    
    UIImageView *imageView=[[UIImageView alloc] init];
    CGFloat imageViewX=0;
    CGFloat imageViewY=0;
    CGFloat imageViewW=SCREEN_WIDTH;
    CGFloat imageViewH=310*(SCREEN_WIDTH/(1242/3));
    imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    imageView.image=[UIImage imageNamed:@"dengluBjTu"];
    [self.view addSubview:imageView];
    
    
    
    
    UIView *view=[[UIView alloc] init];
    CGFloat viewX=42;
    CGFloat viewY;
    CGFloat viewW=SCREEN_WIDTH-2*viewX;
    CGFloat viewH=40;
    if (SCREEN_HEIGHT==480) {
        viewY=imageViewH-45;
    }else{
        viewY=imageViewH+5;
    }
    
    view.frame=CGRectMake(viewX, viewY, viewW, viewH);
    [self.view addSubview:view];
    self.view1=view;
    [self addControlsWithView:view];
    
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=0;
    CGFloat personImageY=7;
    CGFloat personImageW=25;
    CGFloat personImageH=25;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.image=[UIImage imageNamed:@"1"];
    [view addSubview:personImage];
    

    UITextField *PhoneTextField=[[UITextField alloc] init];
    CGFloat phoneTextFieldX=personImageH+12;
    CGFloat phoneTextFieldY=0;
    CGFloat phoneTextFieldW=viewW-phoneTextFieldX;
    CGFloat phoneTextFieldH=40;
    PhoneTextField.frame=CGRectMake(phoneTextFieldX, phoneTextFieldY, phoneTextFieldW, phoneTextFieldH);
    PhoneTextField.placeholder=@"请输入手机号码";
    PhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
    [view addSubview:PhoneTextField];
    PhoneTextField.delegate=self;
    self.PhoneTextField=PhoneTextField;
    
    [PhoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}


-(void)phoneTextFieldDidChange:(UITextField *)textField
{
    if (textField.text.length==11) {
        if ([ZCTool validateMobile:textField.text]) {
            [self networkRequest];
        }else{
            [MBProgressHUD showError:@"手机号输入有误"];
        }
        
    }else if (textField.text.length>11)
    {
      self.PhoneTextField.text = [self.PhoneTextField.text substringToIndex:11];
    }else{
        
        [self removeTheAnimation];
    }

}


//移除动画
-(void)removeTheAnimation
{
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat failureViewX=SCREEN_WIDTH;
        CGFloat failureViewY=self.view1.frame.size.height+self.view1.frame.origin.y+15;
        CGFloat failureViewW=self.view1.frame.size.width;
        CGFloat failureViewH=self.view1.frame.size.height;
        self.failureView.frame=CGRectMake(failureViewX, failureViewY, failureViewW, failureViewH);
        
        
    } completion:^(BOOL finished) {
        [self.failureView removeFromSuperview];
    }];

    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat welcomeViewX=SCREEN_WIDTH;
        CGFloat welcomeViewY=self.view1.frame.size.height+self.view1.frame.origin.y+15;
        CGFloat welcomeViewW=self.view1.frame.size.width;
        CGFloat welcomeViewH=self.view1.frame.size.height;
        self.welcomeView.frame=CGRectMake(welcomeViewX, welcomeViewY, welcomeViewW, welcomeViewH);
        
        
    } completion:^(BOOL finished) {
        [self.welcomeView removeFromSuperview];
    }];

    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat welcomeView2X=SCREEN_WIDTH;
        CGFloat welcomeView2Y=self.welcomeView.frame.size.height+self.welcomeView.frame.origin.y+15;
        CGFloat welcomeView2W=self.view1.frame.size.width;
        CGFloat welcomeView2H=self.view1.frame.size.height;
        self.welcomeView2.frame=CGRectMake(welcomeView2X, welcomeView2Y, welcomeView2W, welcomeView2H);
        
        
    } completion:^(BOOL finished) {
        [self.welcomeView2 removeFromSuperview];
    }];
    
    
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat viewX=42;
        CGFloat viewY=self.welcomeView2.frame.size.height+self.welcomeView2.frame.origin.y+15;
        CGFloat viewW=SCREEN_WIDTH-2*viewX;
        CGFloat viewH=40;
        self.thirdView.frame=CGRectMake(viewX, viewY, viewW, viewH);
        
        
    } completion:^(BOOL finished) {
       [self.thirdView removeFromSuperview];
        if (_time==nil) {
            
        }else{
        dispatch_source_cancel(_time);
        }
        
    }];

    
    
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.landingButton.alpha=0.0;
        
        
    } completion:^(BOOL finished) {
        [self.landingButton removeFromSuperview];
    }];
}




//网络请求
-(void)networkRequest
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"phone"]=self.PhoneTextField.text;
    if (!self.longitude==0) {
        params[@"longitude"] = @(self.longitude);
        params[@"latitude"]=@(self.latitude) ;
    }
    
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/welcome",API];
    [ZCTool  getWithUrl:URL params:params success:^(id responseObject) {
        
        ZCLog(@"%@",responseObject[@"sentences"]);
        if (responseObject[@"sentences"]) {
            //成功
          [self theRequestIsSuccessful:responseObject[@"sentences"]];

        }else{
            //不成功
            [self theRequestIsNoSuccessful];
        }
        
        
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
   
}


//手机号不存在这个账户 不成功
-(void)theRequestIsNoSuccessful
{
    UIView *failureView=[[UIView alloc] init];
    CGFloat failureViewX=SCREEN_WIDTH;
    CGFloat failureViewY=self.view1.frame.size.height+self.view1.frame.origin.y+15;
    CGFloat failureViewW=self.view1.frame.size.width;
    CGFloat failureViewH=self.view1.frame.size.height;
    failureView.frame=CGRectMake(failureViewX, failureViewY, failureViewW, failureViewH);
    [self.view addSubview:failureView];
    self.failureView=failureView;
    [self addControlsWithView:failureView];
    
    
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=0;
    CGFloat personImageY=11;
    CGFloat personImageW=15;
    CGFloat personImageH=15;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.alpha=0.0;
    personImage.image=[UIImage imageNamed:@"denglu_cuowu"];
    [failureView addSubview:personImage];
    
    
    UILabel *failureLabel=[[UILabel alloc] init];
    failureLabel.text=@"手机号不存在，请重试";
    failureLabel.alpha=0.1;
    //welcomeLabel.textAlignment=NSTextAlignmentCenter;
    failureLabel.frame=CGRectMake(SCREEN_WIDTH, 0, failureViewW, 40);
    [failureView addSubview:failureLabel];

    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat failureViewX=42;
        CGFloat failureViewY=self.view1.frame.size.height+self.view1.frame.origin.y+15;
        CGFloat failureViewW=self.view1.frame.size.width;
        CGFloat failureViewH=self.view1.frame.size.height;
        failureView.frame=CGRectMake(failureViewX, failureViewY, failureViewW, failureViewH);
        
    } completion:^(BOOL finished) {
        
        personImage.alpha=1.0;
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            failureLabel.frame=CGRectMake(27, 0, failureViewW, 40);
            failureLabel.alpha=0.8;
            
            
            
        } completion:^(BOOL finished) {
            
            
            
        }];

        
    }];

}





//成功
-(void)theRequestIsSuccessful:(NSArray *)array
{
    [self.view endEditing:YES];
    
    UIView *welcomeView=[[UIView alloc] init];
    CGFloat welcomeViewX=SCREEN_WIDTH;
    CGFloat welcomeViewY=self.view1.frame.size.height+self.view1.frame.origin.y+15;
    CGFloat welcomeViewW=self.view1.frame.size.width;
    CGFloat welcomeViewH=self.view1.frame.size.height;
    welcomeView.frame=CGRectMake(welcomeViewX, welcomeViewY, welcomeViewW, welcomeViewH);
    [self.view addSubview:welcomeView];
    self.welcomeView=welcomeView;
    [self addControlsWithView:welcomeView];
    
   
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=0;
    CGFloat personImageY=7;
    CGFloat personImageW=25;
    CGFloat personImageH=25;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.alpha=0.0;
    personImage.image=[UIImage imageNamed:@"2"];
    [welcomeView addSubview:personImage];
    
    
    UILabel *welcomeLabel=[[UILabel alloc] init];
    welcomeLabel.text=[NSString stringWithFormat:@"%@",array[0]];
    welcomeLabel.alpha=0.1;
    //welcomeLabel.textAlignment=NSTextAlignmentCenter;
    welcomeLabel.frame=CGRectMake(SCREEN_WIDTH, 0, welcomeViewW, 40);
    [welcomeView addSubview:welcomeLabel];
    
   //添加第二句话
    [self addSecondView:welcomeView andArray:array];
    
    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        CGFloat welcomeViewX=42;
        CGFloat welcomeViewY=self.view1.frame.size.height+self.view1.frame.origin.y+15;
        CGFloat welcomeViewW=self.view1.frame.size.width;
        CGFloat welcomeViewH=self.view1.frame.size.height;
        welcomeView.frame=CGRectMake(welcomeViewX, welcomeViewY, welcomeViewW, welcomeViewH);

        
        
      
        
//        welcomeLabel2.transform = CGAffineTransformMakeScale(1.3, 1.3);
//        welcomeLabel2.alpha=1.0;
        
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            personImage.alpha=1.0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                welcomeLabel.frame=CGRectMake(37, 0, welcomeViewW, 40);
                welcomeLabel.alpha=0.8;
            } completion:^(BOOL finished) {
                
            }];

        }];
        
     
        
        
        
        

        
    }];
    
}



//添加显示第2
-(void)addSecondView:(UIView *)view andArray:(NSArray *)array
{
    
    UIView *welcomeView2=[[UIView alloc] init];
    CGFloat welcomeView2X=SCREEN_WIDTH;
    CGFloat welcomeView2Y=view.frame.size.height+view.frame.origin.y+15;
    CGFloat welcomeView2W=self.view1.frame.size.width;
    CGFloat welcomeView2H=self.view1.frame.size.height;
    welcomeView2.frame=CGRectMake(welcomeView2X, welcomeView2Y, welcomeView2W, welcomeView2H);
    [self.view addSubview:welcomeView2];
    self.welcomeView2=welcomeView2;
    [self addControlsWithView:welcomeView2];
    
    
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=0;
    CGFloat personImageY=7;
    CGFloat personImageW=25;
    CGFloat personImageH=25;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.alpha=0.0;
    personImage.image=[UIImage imageNamed:@"3"];
    [welcomeView2 addSubview:personImage];

    
    
    UILabel *welcomeLabel2=[[UILabel alloc] init];
    welcomeLabel2.text=[NSString stringWithFormat:@"%@",array[1]];
    welcomeLabel2.alpha=0.1;
    //welcomeLabel2.textAlignment=NSTextAlignmentCenter;
    welcomeLabel2.frame=CGRectMake(SCREEN_WIDTH, 0, welcomeView2W, 40);
    [welcomeView2 addSubview:welcomeLabel2];

    
    
    [UIView animateWithDuration:0.9 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat welcomeView2X=42;
        CGFloat welcomeView2Y=view.frame.size.height+view.frame.origin.y+15;
        CGFloat welcomeView2W=self.view1.frame.size.width;
        CGFloat welcomeView2H=self.view1.frame.size.height;
        welcomeView2.frame=CGRectMake(welcomeView2X, welcomeView2Y, welcomeView2W, welcomeView2H);
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            personImage.alpha=1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                welcomeLabel2.frame=CGRectMake(37, 0, welcomeView2W, 40);
                welcomeLabel2.alpha=0.8;
            } completion:^(BOOL finished) {
                //调用登陆
                [self addThirdView:welcomeView2];
            }];

            
        }];

        
       
        
        
    }];

}




//添加验证码登陆框
-(void)addThirdView:(UIView *)view
{
    
    UIView *thirdView=[[UIView alloc] init];
    CGFloat viewX=42;
    CGFloat viewY=view.frame.size.height+view.frame.origin.y+15;
    CGFloat viewW=SCREEN_WIDTH-2*viewX;
    CGFloat viewH=40;
    thirdView.frame=CGRectMake(viewX, viewY, viewW, viewH);
    [self.view addSubview:thirdView];
    self.thirdView=thirdView;
    [self addControlsWithView2:thirdView];
    
    
    
    
    UIImageView *personImage=[[UIImageView alloc] init];
    CGFloat personImageX=0;
    CGFloat personImageY=7;
    CGFloat personImageW=25;
    CGFloat personImageH=25;
    personImage.frame=CGRectMake(personImageX, personImageY, personImageW, personImageH);
    personImage.alpha=0.0;
    personImage.image=[UIImage imageNamed:@"4"];
    [thirdView addSubview:personImage];
    
    
    UITextField *VerificationTextField=[[UITextField alloc] init];
    VerificationTextField.frame=CGRectMake(SCREEN_WIDTH, 0, 110, 40);
    VerificationTextField.placeholder=@"请输入验证码";
    [thirdView addSubview:VerificationTextField];
    VerificationTextField.delegate=self;
    VerificationTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.VerificationTextField=VerificationTextField;

    [VerificationTextField addTarget:self action:@selector(verificationTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        CGFloat viewX=42;
        CGFloat viewY=view.frame.size.height+view.frame.origin.y+15;
        CGFloat viewW=self.view1.frame.size.width;
        CGFloat viewH=self.view1.frame.size.height;
        thirdView.frame=CGRectMake(viewX, viewY, viewW, viewH);
        
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            personImage.alpha=1.0;
        } completion:^(BOOL finished) {
        
        
        
        
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            VerificationTextField.frame=CGRectMake(37, 0, 110, 40);
            
        } completion:^(BOOL finished) {
            
            //添加验证码按钮
            [self VerificationCodeButton:thirdView];
            
        }];
        }];
        
        
    }];
    

}


//添加验证码按钮
-(void)VerificationCodeButton:(UIView *)view
{
    //获取验证码
    UIButton *getButton=[[UIButton alloc] init];
    [getButton setBackgroundImage:[UIImage imageNamed:@"denglu_yanzhen"] forState:UIControlStateNormal];
    CGFloat  getButtonW=SCREEN_WIDTH*0.28;
    CGFloat  getButtonX=view.frame.size.width-getButtonW-10;
    CGFloat  getButtonH=25*(getButtonW/90);
    CGFloat  getButtonY=view.frame.size.height-(getButtonH/2);
    getButton.frame=CGRectMake(getButtonX, getButtonY, getButtonW, getButtonH);
    [getButton setTitle:@"重新发送" forState:UIControlStateNormal];
    [getButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [getButton addTarget:self action:@selector(clickgetButton) forControlEvents:UIControlEventTouchUpInside];
    //第一次默认倒计时
    [self startTheCountdown];
    getButton.titleLabel.font=[UIFont systemFontOfSize:14];
    getButton.alpha=0.0;
    [view addSubview:getButton];
    self.getButton=getButton;

    
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        getButton.alpha=1.0;
    } completion:^(BOOL finished) {
       
        //登陆按钮
        [self heLandingButton];
    }];
    
    
}







//登陆按钮
-(void)heLandingButton
{
    UIButton *landingButton=[[UIButton alloc] init];
    landingButton.frame=CGRectMake((SCREEN_WIDTH-105)/2, self.thirdView.frame.size.height+self.thirdView.frame.origin.y+30, 110, 32);
    [landingButton setTitle:@"登录" forState:UIControlStateNormal];
//    [landingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    landingButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"denglu_icon"]];
   
    [self.view addSubview:landingButton];
    self.landingButton=landingButton;
    
    [landingButton addTarget:self action:@selector(clickTheLandingButton) forControlEvents:UIControlEventTouchUpInside];
    landingButton.alpha=0;
    
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        landingButton.alpha=1.0;
        
    } completion:^(BOOL finished) {
        //[self.VerificationTextField becomeFirstResponder];
    }];

}




//点击登陆
-(void)clickTheLandingButton
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"phone"]=self.PhoneTextField.text;
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
        
        
        //上传用户推送ID
        [ZCTool uploadThePushID];
        
    } failure:^(NSError *error) {
        
        ZCLog(@"%@",error);
        
    }];
  
}







//点击重新发送
-(void)clickgetButton
{
    [self startTheCountdown];
}

//View上的线
-(void)addControlsWithView:(UIView *)view
{
    UIView *xianView=[[UIView alloc] init];
    xianView.frame=CGRectMake(0, view.frame.size.height-1, view.frame.size.width, 0.5);
    xianView.backgroundColor=ZCColor(215, 215, 215);
    [view addSubview:xianView];

}

//View上的线
-(void)addControlsWithView2:(UIView *)view
{
    UIView *xianView=[[UIView alloc] init];
    xianView.frame=CGRectMake(0, view.frame.size.height-1, view.frame.size.width-SCREEN_WIDTH*0.28-10, 0.5);
    xianView.backgroundColor=ZCColor(215, 215, 215);
    [view addSubview:xianView];
    
}


//开始倒计时
-(void)startTheCountdown
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    self.time=_timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_getButton setTitle:@"重新发送" forState:UIControlStateNormal];
                _getButton.userInteractionEnabled = YES;
                //_getButton.backgroundColor = kNaviBgColor;
                
            });
        }else{
            //            int minutes = timeout / 60;
            //            int seconds = timeout % 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [_getButton setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                _getButton.userInteractionEnabled = NO;
                //l_timeButton.backgroundColor = kSourceColor;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
    
    
    
}

//判断验证码输入
-(void)verificationTextFieldDidChange:(UITextField *)textField
{
    if (textField.text.length==4) {
        [self.view endEditing:YES];
    }else if (textField.text.length>4)
    {
        self.VerificationTextField.text = [self.VerificationTextField.text substringToIndex:4];
        
    }

}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //textField.superview
    
    
    CGRect frame = textField.superview.frame;
    int offset = frame.origin.y + 32+32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField.superview resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


//- (void)keyboardDidChangeFrame:(NSNotification *)noti
//{
//    ZCLog(@"ddasdasdasdasd");
//    // self.view.transform = CGAffineTransformMakeTranslation(0,-140 );
//    if (self.bKeyBoardHide==NO) {
//        self.view.transform = CGAffineTransformMakeTranslation(0,-40 );
//        //        [UIView animateWithDuration:keyDuration animations:^{
//        //            self.view.transform = CGAffineTransformMakeTranslation(0, -40 );
//        //        }];
//        self.bKeyBoardHide = YES;
//        
//    }else
//    {
//        self.bKeyBoardHide = NO;
//        self.view.transform = CGAffineTransformMakeTranslation(0,0 );
//        
//    }
//    
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

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
