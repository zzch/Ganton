//
//  ZCPersonalViewController.m
//  Ganton
//
//  Created by hh on 15/10/14.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCPersonalViewController.h"
#import "ZCInformationViewController.h"
#import "ZCRedEnvelopeViewController.h"
#import "ZCRecordsOfConsumptionViewController.h"
#import "ZCMakeAnAppointmentViewController.h"
#import "ZCAccountViewController.h"
@interface ZCPersonalViewController ()
@property(nonatomic,strong)NSDictionary *personDict;
@property(nonatomic,weak)UIImageView *photoView;
@property(nonatomic,weak)UILabel *photoLabel;
@end

@implementation ZCPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"个人中心";
    
    self.view.backgroundColor=ZCColor(239, 239, 244);
    
    
    
    [self addControls];
}


-(void)viewWillAppear:(BOOL)animated
{
  [self addData];
}

// 网络加载
-(void)addData
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    params[@"token"]=token;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/users/detail",API];
    
    [ZCTool getWithUrl:URL params:params success:^(id responseObject) {
        ZCLog(@"%@",responseObject);
        
        self.personDict=responseObject;
        
        [self reolData];
    } failure:^(NSError *error) {
        ZCLog(@"%@",error);
    }];
    
}





//添加控件
-(void)addControls
{
    
    UIButton *photoViewBtn=[[UIButton alloc] init];
    photoViewBtn.backgroundColor=[UIColor whiteColor];
    CGFloat photoViewBtnX=0;
    CGFloat photoViewBtnY=0;
    CGFloat photoViewBtnW=SCREEN_WIDTH-(2*photoViewBtnX);
    CGFloat photoViewBtnH=80;
    photoViewBtn.frame=CGRectMake(photoViewBtnX, photoViewBtnY, photoViewBtnW, photoViewBtnH);
    //UIImage *image=[UIImage imageNamed:@"hang_bj_03" ];
    // 指定为拉伸模式，伸缩后重新赋值
   // image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
    
    //[photoViewBtn setBackgroundColor:[UIColor whiteColor]];
    //[photoViewBtn setBackgroundImage:image forState:UIControlStateNormal];
    [photoViewBtn addTarget:self action:@selector(clickphotoViewBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:photoViewBtn];
    
    [self changePhotoView:photoViewBtn];

  
//    UIButton *button1=[[UIButton alloc] init];
//    CGFloat button1X=0;
//    CGFloat button1Y=photoViewBtnY+photoViewBtnH+15;
//    CGFloat button1W=SCREEN_WIDTH;
//    CGFloat button1H=50;
//    button1.frame=CGRectMake(button1X, button1Y, button1W, button1H);
//    button1.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:button1];
//    [button1 addTarget:self action:@selector(clickTheButton1) forControlEvents:UIControlEventTouchUpInside];
//    [self addChildControls:button1 andImageStr:@"geren_hongbao_icon" andText:@"我的红包"];
//    
//    UIView *bjView=[[UIView alloc] init];
//    bjView.frame=CGRectMake(0, button1Y+button1H, 20, 1);
//    bjView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bjView];
//    
//    UIButton *button2=[[UIButton alloc] init];
//    CGFloat button2X=0;
//    CGFloat button2Y=button1Y+button1H+1;
//    CGFloat button2W=SCREEN_WIDTH;
//    CGFloat button2H=50;
//    button2.frame=CGRectMake(button2X, button2Y, button2W, button2H);
//    button2.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:button2];
//    [button2 addTarget:self action:@selector(clickTheButton2) forControlEvents:UIControlEventTouchUpInside];
//    [self addChildControls:button2 andImageStr:@"geren_xiaof_icon" andText:@"我的消费"];
//    
//    UIView *bjView2=[[UIView alloc] init];
//    bjView2.frame=CGRectMake(0, button2Y+button2H, 20, 1);
//    bjView2.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:bjView2];
    
    
    UIButton *button3=[[UIButton alloc] init];
//    CGFloat button3X=0;
//    CGFloat button3Y=button2Y+button2H+15;
//    CGFloat button3W=SCREEN_WIDTH;
//    CGFloat button3H=50;
//    button3.frame=CGRectMake(button3X, button3Y, button3W, button3H);
        CGFloat button3X=0;
        CGFloat button3Y=photoViewBtnY+photoViewBtnH+15;
        CGFloat button3W=SCREEN_WIDTH;
        CGFloat button3H=50;
        button3.frame=CGRectMake(button3X, button3Y, button3W, button3H);

    button3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(clickTheButton3) forControlEvents:UIControlEventTouchUpInside];
    [self addChildControls:button3 andImageStr:@"geren_dawei_icon" andText:@"打位预约"];
    
    
    
    
    UIButton *exitButton=[[UIButton alloc] init];
    exitButton.backgroundColor=[UIColor whiteColor];
    CGFloat exitButtonX=0;
    CGFloat exitButtonY=button3Y+button3H+15;
    CGFloat exitButtonW=SCREEN_WIDTH-2*exitButtonX;
    CGFloat exitButtonH=50;
    exitButton.frame=CGRectMake(exitButtonX, exitButtonY, exitButtonW, exitButtonH);
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.view addSubview:exitButton];
    [exitButton setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(askPrompt) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)askPrompt
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"确定要退出登录吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        ZCLog(@"取消");
        //[self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self clickTheExitButton];
    }

    // 按钮的索引肯定不是0

}


//点击登出
-(void)clickTheExitButton
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    params[@"token"]=token;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/sign_out",API];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    [manger DELETE:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        [defaults removeObjectForKey:@"token"];
        [defaults removeObjectForKey:@"uuid"];
        [defaults removeObjectForKey:@"birthday"];
        [defaults removeObjectForKey:@"portrait"];
        [defaults removeObjectForKey:@"gender"];
        [defaults removeObjectForKey:@"name"];
        
        
        ZCAccountViewController *vc=[[ZCAccountViewController alloc] init];
        
        UIWindow *wd = [[UIApplication sharedApplication].delegate window];
       
       // UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
        wd.rootViewController=vc;
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    


}







-(void)clickTheButton1
{
    ZCRedEnvelopeViewController *vc=[[ZCRedEnvelopeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

//消费记录
-(void)clickTheButton2
{
    ZCRecordsOfConsumptionViewController *vc=[[ZCRecordsOfConsumptionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)clickTheButton3
{
    ZCMakeAnAppointmentViewController *vc=[[ZCMakeAnAppointmentViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

//跟换头像
-(void)changePhotoView:(UIButton *)photoViewBtn
{
//    UIButton *photoViewBtn=[[UIButton alloc] init];
//    CGFloat photoViewBtnX=0;
//    CGFloat photoViewBtnY=20;
//    CGFloat photoViewBtnW=SCREEN_WIDTH-(2*photoViewBtnX);
//    CGFloat photoViewBtnH=82;
//    photoViewBtn.frame=CGRectMake(photoViewBtnX, photoViewBtnY, photoViewBtnW, photoViewBtnH);
//    
//    
//    //    CGFloat top = 25; // 顶端盖高度
//    //    CGFloat bottom = 25 ; // 底端盖高度
//    //    CGFloat left = 10; // 左端盖宽度
//    //    CGFloat right = 10; // 右端盖宽度
//    //    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    //    UIImage *image=[UIImage imageNamed:@"grxx_ghtx_bj" ];
//    //    // 指定为拉伸模式，伸缩后重新赋值
//    //    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    //    [photoViewBtn setBackgroundImage:image forState:UIControlStateNormal];
//    //
//    
//    UIImage *image=[UIImage imageNamed:@"hang_bj_03" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
//    
//    //[photoViewBtn setBackgroundColor:[UIColor whiteColor]];
//    [photoViewBtn setBackgroundImage:image forState:UIControlStateNormal];
//    [photoViewBtn addTarget:self action:@selector(clickphotoViewBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:photoViewBtn];
//    //self.photoViewBtn=photoViewBtn;
    
    
    //头像
    UIImageView *photoView=[[UIImageView alloc] init];
    CGFloat photoViewX=13;
    CGFloat photoViewW=60;
    CGFloat photoViewH=60;
    CGFloat photoViewY=(photoViewBtn.frame.size.height-photoViewH)*0.5;
    photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    photoView.layer.masksToBounds = YES;
    photoView.layer.cornerRadius = 5;
    //photoView.image=[UIImage imageNamed:@"morengtouxiang"];
    [photoViewBtn addSubview:photoView];
    self.photoView=photoView;
    
    
    //跟换头像提示
    UILabel *photoLabel=[[UILabel alloc] init];
    CGFloat photoLabelX=photoViewX+photoViewW+17;
    CGFloat photoLabelW=70;
    CGFloat photoLabelH=30;
    CGFloat photoLabelY=(photoViewBtn.frame.size.height-photoLabelH)*0.5;
    photoLabel.frame=CGRectMake(photoLabelX, photoLabelY, photoLabelW, photoLabelH);
    
    photoLabel.font=[UIFont systemFontOfSize:18];
    photoLabel.textColor=ZCColor(85, 85, 85);
    [photoViewBtn addSubview:photoLabel];
    self.photoLabel=photoLabel;
    
    
    
    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=6;
    CGFloat rightImageViewH=11;
    CGFloat rightImageViewY=(photoViewBtn.frame.size.height-rightImageViewH)*0.5;
    CGFloat rightImageViewX=photoViewBtn.frame.size.width-rightImageViewW-18;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"shouye_arrow_icon"];
    
    [photoViewBtn addSubview:rightImageView];
}


//跟新数据
-(void)reolData
{
    if ([ZCTool _valueOrNil:self.personDict[@"portrait"]]==nil) {
        
        if ([self.personDict[@"gender"] isEqual:@"male"]) {
            self.photoView.image=[UIImage imageNamed:@"nan"];
        }else{
            self.photoView.image=[UIImage imageNamed:@"nv"];
        }
       // self.photoView.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    }else{
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:self.personDict[@"portrait"]] placeholderImage:nil];
    }


    self.photoLabel.text=self.personDict[@"name"];
}




-(void)addChildControls:(UIButton *)Button andImageStr:(NSString *)imageStr andText:(NSString *)text
{
    
    UIImageView *iocnImage=[[UIImageView alloc] init];
    CGFloat iocnImageW=16;
    CGFloat iocnImageH=21;
    CGFloat iocnImageX=20;
    CGFloat iocnImageY=(Button.frame.size.height-iocnImageH)/2;
    iocnImage.frame=CGRectMake(iocnImageX, iocnImageY, iocnImageW, iocnImageH);
    iocnImage.image=[UIImage imageNamed:imageStr];
    [Button addSubview:iocnImage];

    
    
    //设置
    UILabel *settingsLabel=[[UILabel alloc] init];
    CGFloat settingsLabelX=iocnImageX+iocnImageW+15;
    CGFloat settingsLabelW=SCREEN_WIDTH*0.5;
    CGFloat settingsLabelH=30;
    CGFloat settingsLabelY=(Button.frame.size.height-settingsLabelH)*0.5;
    settingsLabel.frame=CGRectMake(settingsLabelX, settingsLabelY, settingsLabelW, settingsLabelH);
    settingsLabel.text=text;
    settingsLabel.textColor=ZCColor(85, 85, 85);
    //settingsLabel.textAlignment=NSTextAlignmentCenter;
    [Button addSubview:settingsLabel];
    
    
    //向右箭头
    UIImageView *rightImageView=[[UIImageView alloc] init];
    
    CGFloat rightImageViewW=6;
    CGFloat rightImageViewH=11;
    CGFloat rightImageViewY=(Button.frame.size.height-rightImageViewH)*0.5;
    CGFloat rightImageViewX=SCREEN_WIDTH-rightImageViewW-18;
    rightImageView.frame=CGRectMake(rightImageViewX, rightImageViewY, rightImageViewW, rightImageViewH);
    rightImageView.image=[UIImage imageNamed:@"shouye_arrow_icon"];
    
    [Button addSubview:rightImageView];
    
    
    
}



//点击头像
-(void)clickphotoViewBtn
{
    ZCInformationViewController *vc=[[ZCInformationViewController alloc] init];
    //vc.delegate=self;
    vc.dict=self.personDict;
    [self.navigationController pushViewController:vc animated:YES];

}

//代理方法
-(void)informationViewControllerWithImage:(UIImage *)image
{

    self.photoView.image=image;

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
