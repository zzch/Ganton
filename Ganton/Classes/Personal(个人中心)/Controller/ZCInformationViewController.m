//
//  ZCInformationViewController.m
//  Ganton
//
//  Created by hh on 15/10/14.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//个人信息

#import "ZCInformationViewController.h"
#import "ZCDatapickerView.h"
#import "ZCBirthdayViewController.h"
@interface ZCInformationViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZCDatapickerViewDelegate,ZCBirthdayViewControllerDelegate>
@property(nonatomic,weak)UIImageView *photoView;
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property(nonatomic,weak)ZCDatapickerView *datePicker;
@property(nonatomic,weak)UILabel *birtdayLabel;
//时间濯
@property(nonatomic,assign) long time;
@end

@implementation ZCInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZCColor(237, 237, 237);
    
    self.navigationItem.title=@"个人信息";
    
    
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(clickTherightButton)];
    
    [self addControls];
    
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
//    UIImage *image=[UIImage imageNamed:@"hang_bj_03" ];
//    // 指定为拉伸模式，伸缩后重新赋值
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25,25,10,10) resizingMode:UIImageResizingModeStretch];
//    
//    //[photoViewBtn setBackgroundColor:[UIColor whiteColor]];
//    [photoViewBtn setBackgroundImage:image forState:UIControlStateNormal];
    [photoViewBtn addTarget:self action:@selector(clickphotoViewBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoViewBtn];
    
    [self changePhotoView:photoViewBtn];
    
    
    UIButton *button1=[[UIButton alloc] init];
    CGFloat button1X=0;
    CGFloat button1Y=photoViewBtnY+photoViewBtnH+15;
    CGFloat button1W=SCREEN_WIDTH;
    CGFloat button1H=50;
    button1.frame=CGRectMake(button1X, button1Y, button1W, button1H);
    button1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:button1];
    [self addChildControls:button1 andNameStr:@"名字" andText:self.dict[@"name"]];
    
    
    
    UIButton *button2=[[UIButton alloc] init];
    CGFloat button2X=0;
    CGFloat button2Y=button1Y+button1H+15;
    CGFloat button2W=SCREEN_WIDTH;
    CGFloat button2H=50;
    button2.frame=CGRectMake(button2X, button2Y, button2W, button2H);
    button2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:button2];
    [self addChildControls:button2 andNameStr:@"性别" andText:self.dict[@"gender"]];
    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(0, button2Y+button2H, 20, 1);
    bjView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bjView];
    
    UIButton *button3=[[UIButton alloc] init];
    CGFloat button3X=0;
    CGFloat button3Y=button2Y+button2H+1;
    CGFloat button3W=SCREEN_WIDTH;
    CGFloat button3H=50;
    button3.frame=CGRectMake(button3X, button3Y, button3W, button3H);
    button3.tag=311;
    button3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:button3];
     if ([ZCTool _valueOrNil:self.dict[@"birthday"]]==nil) {
        [self addChildControls:button3 andNameStr:@"生日" andText:@"未设置"];
     }else{
         
         ZCLog(@"%@",self.dict[@"birthday"]);
         long data=[self.dict[@"birthday"] longValue];
         // 创建一个日期格式器
         NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
         // 为日期格式器设置格式字符串
         [nowDateFormatter setDateFormat:@"yyyy-MM-dd"];
         // 使用日期格式器格式化日期、时间
         NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:data];
         NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
     [self addChildControls:button3 andNameStr:@"生日" andText:nowDateString];
     }
    
    [button3 addTarget:self action:@selector(clickTheButton3) forControlEvents:UIControlEventTouchUpInside];
    

    
    

}


//跟换头像
-(void)changePhotoView:(UIButton *)photoViewBtn
{
    
    //跟换头像提示
    UILabel *photoLabel=[[UILabel alloc] init];
    CGFloat photoLabelX=20;
    CGFloat photoLabelW=70;
    CGFloat photoLabelH=30;
    CGFloat photoLabelY=(photoViewBtn.frame.size.height-photoLabelH)*0.5;
    photoLabel.frame=CGRectMake(photoLabelX, photoLabelY, photoLabelW, photoLabelH);
    photoLabel.text=@"头像";
    photoLabel.textColor=ZCColor(85, 85, 85);
    [photoViewBtn addSubview:photoLabel];
    
    
    //头像
    UIImageView *photoView=[[UIImageView alloc] init];
    CGFloat photoViewW=60;
    CGFloat photoViewX=SCREEN_WIDTH-36-photoViewW;
    CGFloat photoViewH=60;
    CGFloat photoViewY=(photoViewBtn.frame.size.height-photoViewH)*0.5;
    photoView.frame=CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
    photoView.layer.masksToBounds = YES;
    photoView.layer.cornerRadius = 5;
    if ([ZCTool _valueOrNil:self.dict[@"portrait"]]==nil) {
        photoView.image=[UIImage imageNamed:@"3088644_150703431167_2.jpg"];
    }else{
        [photoView sd_setImageWithURL:[NSURL URLWithString:self.dict[@"portrait"]] placeholderImage:[UIImage imageNamed:@"3088644_150703431167_2.jpg"]];
    }

    
    [photoViewBtn addSubview:photoView];
     self.photoView=photoView;
    
    
    
    
    
    
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



-(void)addChildControls:(UIButton *)Button andNameStr:(NSString *)nameStr andText:(NSString *)text
{
    
    UILabel *nameImage=[[UILabel alloc] init];
    CGFloat nameImageW=100;
    CGFloat nameImageH=Button.frame.size.height;
    CGFloat nameImageX=10;
    CGFloat nameImageY=0;
    nameImage.frame=CGRectMake(nameImageX, nameImageY, nameImageW, nameImageH);
    nameImage.text=nameStr;
    [Button addSubview:nameImage];
    
    
//    if (Button.tag==311) {
    
    //设置
    UILabel *settingsLabel=[[UILabel alloc] init];
    CGFloat settingsLabelX=SCREEN_WIDTH-236;
    CGFloat settingsLabelW=200;
    CGFloat settingsLabelH=30;
    CGFloat settingsLabelY=(Button.frame.size.height-settingsLabelH)*0.5;
    settingsLabel.frame=CGRectMake(settingsLabelX, settingsLabelY, settingsLabelW, settingsLabelH);
    settingsLabel.text=text;
    settingsLabel.textColor=ZCColor(85, 85, 85);
    settingsLabel.textAlignment=NSTextAlignmentRight;
    [Button addSubview:settingsLabel];
    self.birtdayLabel=settingsLabel;
  //  }
    if (Button.tag==311) {
        
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
    
}



-(void)clickphotoViewBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",nil];
    [sheet showInView:self.view];

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //拍照UIImagePickerControllerSourceTypeCamera
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            // 1. 实例化
            UIImagePickerController *pick = [[UIImagePickerController alloc] init];
            //类型
            pick.sourceType=UIImagePickerControllerSourceTypeCamera;
            // [pick setAllowsEditing:YES];
            pick.delegate=self;
            pick.allowsEditing = YES;
            // 3. 展现
            [self presentViewController:pick animated:YES completion:nil];
            
        }else{
            ZCLog(@"相ji不可用");
            
        }
        
        
        
        
        
    }else if(buttonIndex == 1){
        
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            // 1. 实例化
            UIImagePickerController *pick = [[UIImagePickerController alloc] init];
            pick.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            // 2. 设置代理
            pick.delegate = self;
            [pick setAllowsEditing:YES];
            // 3. 展现
            [self presentViewController:pick animated:YES completion:nil];
        }else{
            ZCLog(@"相ce不可用");
            
            // [FXJDyTool showAlertViewWithMessage:@"相册不可用" delegate:self];
        }
    }
}



#pragma mark - 照片选择器代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self.photoView.image setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    //整个图片
    //  self.photoView.image=info[UIImagePickerControllerOriginalImage];
    //裁剪后的图片
    self.photoView.image=info[UIImagePickerControllerEditedImage];
    
    //ZCLog(@"%@",[self.photoView.image class]);
    // 关闭视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // [self saveImage:info[UIImagePickerControllerOriginalImage] WithName:nil];
    [self pictureUpload];
    
    
    
}




-(void)clickTherightButton
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    params[@"token"]=token;
    params[@"birthday"]=@(self.time);
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/users/birthday",API];
    

    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    [manger PUT:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    
   
}


-(void)pictureUpload
{
    //    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *file = [doc stringByAppendingPathComponent:@"imageData.data"];
    //    UIImage *im=[NSKeyedUnarchiver unarchiveObjectWithFile:file];AfarHTTPSessionManager
    
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    
    params[@"token"]=token;
    
    NSString *URL=[NSString stringWithFormat:@"%@v1/users/portrait",API];

    
    
    //  NSString *file1 = [doc stringByAppendingPathComponent:@"imageData.data"];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
   
    
    NSData *imageData = UIImageJPEGRepresentation(self.photoView.image, 0.5);
   
    
    //NSMutableURLRequest *request = [mgr.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
    //  }];
    
    
    
    NSMutableURLRequest *request = [mgr.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:imageData name:@"portrait" fileName:@"asd" mimeType:@"image/jpeg"];
    } error:nil];
    
    
    
    
    //    NSMutableURLRequest *request = [mgr.requestSerializer
    //                                    multipartFormRequestWithMethod:@"PUT" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        [formData appendPartWithFileData:imageData name:@"portrait" fileName:file1 mimeType:@"image/jpeg"];
    //    }];
    //
    //    // 'PUT' and 'POST' convenience methods auto-run, but HTTPRequestOperationWithRequest just
    //    // sets up the request. you're responsible for firing it.
    AFHTTPRequestOperation *requestOperation = [mgr HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        
//        //保存照片到沙盒
//        NSString *path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"personImage.png"];
//        NSData *data=UIImagePNGRepresentation(self.photoView.image);
//        [data writeToFile:path atomically:YES];
        
        
//        if ([self.delegate respondsToSelector:@selector(informationViewControllerWithImage:)]) {
//            [self.delegate informationViewControllerWithImage:self.photoView.image];
//        }
        
        ZCLog(@"%@",responseObject);
        // success
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure
    }];
    
    // fire the request
    [requestOperation start];
    
    
    
    
    
    
    
    
    
    
    
}



//点击生日
-(void)clickTheButton3
{
    
    
    ZCBirthdayViewController *vc=[[ZCBirthdayViewController alloc] init];
    vc.delegate=self;
    vc.birthday= self.dict[@"birthday"];
    [self.navigationController pushViewController:vc animated:YES];
    
//    if (self.opened1==NO) {
//        //显示生日
//        ZCDatapickerView *datePicker=[[ZCDatapickerView alloc] init];
//        self.opened1=YES;
//        datePicker.delegate=self;
//        
//        
//        CGFloat datePickerY=SCREEN_HEIGHT-300;
//        CGFloat datePickerX=0;
//        
//        CGFloat datePickerW=SCREEN_WIDTH;
//        CGFloat datePickerH=300;
//        datePicker.frame=CGRectMake(datePickerX, datePickerY, datePickerW, datePickerH);
//        
//        [self.view addSubview:datePicker];
//        self.datePicker=datePicker;
//        
//        
//    }else
//    {
//        [self.datePicker removeFromSuperview];
//        self.opened1=NO;
//    }


}


-(void)birthdayViewControllerDelegate:(long)data
{
     self.time=data;

    // 创建一个日期格式器
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [nowDateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSDate *confromTimesp=[NSDate dateWithTimeIntervalSince1970:data];
    NSString *nowDateString = [nowDateFormatter stringFromDate:confromTimesp ];
    self.birtdayLabel.text=nowDateString;
    
    //执行网络上传
    [self clickTherightButton];
    
   

}




//时间代理
-(void)datapickerViewDelegate:(UIDatePicker *)datePicker
{
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [datePicker date];
    // 创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    self.birtdayLabel.text=destDateString;
    //[self.birtdayLabel setTitle:destDateString forState:UIControlStateNormal];
    
    //吧时间变成时间濯
    long time=(long)[selected timeIntervalSince1970];
    self.time=time;
    
    
    
    
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy"];
    // 使用日期格式器格式化日期、时间
    NSString *person = [dateFormatter stringFromDate:selected];
    
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
    
    
//    if (now-age>0 &&now-age<85) {
//        [self.ageNumLabel setTitle:[NSString stringWithFormat:@"%d",now-age] forState:UIControlStateNormal];
//    }else if (now-age>85)
//    {
//        [self.ageNumLabel setTitle:@"85" forState:UIControlStateNormal];
//    }
//    
//    else
//    {
//        [self.ageNumLabel setTitle:@"0" forState:UIControlStateNormal];
//    }
    
    
    
    //    [self.ageNumLabel setTitle:[NSString stringWithFormat:@"%d",now-age] forState:UIControlStateNormal];
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
