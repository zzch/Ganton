//
//  ZCAccountViewController.m
//  Ganton
//
//  Created by hh on 15/10/10.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCAccountViewController.h"

@interface ZCAccountViewController ()

@end

@implementation ZCAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addControls];
}


-(void)addControls
{

    UITextField *phoneTextField=[[UITextField alloc] init];
    phoneTextField.frame=CGRectMake(20, 100, SCREEN_WIDTH-40, 40);
    phoneTextField.backgroundColor=[UIColor redColor];
    [self.view addSubview:phoneTextField];
    
    [phoneTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}


-(void)phoneTextFieldDidChange:(UITextField *)textField
{
    if (textField.text.length==11) {
        [self networkRequest];
    }

}


//网络请求
-(void)networkRequest
{
   //成功
    [self theRequestIsSuccessful];
}


//成功
-(void)theRequestIsSuccessful
{
    UILabel *welcomeLabel=[[UILabel alloc] init];
    welcomeLabel.text=@"欢迎来到高尔夫球场";
    welcomeLabel.alpha=0.1;
    welcomeLabel.textAlignment=NSTextAlignmentCenter;
    welcomeLabel.frame=CGRectMake(0, 200, SCREEN_WIDTH, 30);
    [self.view addSubview:welcomeLabel];
    
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        welcomeLabel.transform = CGAffineTransformMakeScale(1.3, 1.3);
        welcomeLabel.alpha=1.0;
        
    } completion:^(BOOL finished) {
       
     
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        UITextField *VerificationTextField=[[UITextField alloc] init];
        VerificationTextField.frame=CGRectMake(120, 250, SCREEN_WIDTH-240, 40);
        VerificationTextField.backgroundColor=[UIColor redColor];
        [self.view addSubview:VerificationTextField];
        
    } completion:^(BOOL finished) {
        
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        UIButton *landingButton=[[UIButton alloc] init];
        landingButton.frame=CGRectMake(100, 320, SCREEN_WIDTH-200, 30);
        [landingButton setTitle:@"登陆" forState:UIControlStateNormal];
        [landingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        landingButton.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:landingButton];
        
    } completion:^(BOOL finished) {
        
    }];
        
    }];
     

        
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
