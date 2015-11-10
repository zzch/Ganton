//
//  ZCTimeView.m
//  Ganton
//
//  Created by hh on 15/10/27.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCTimeView.h"
#import "ZCPickerView.h"
@interface ZCTimeView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,weak)UIPickerView *pickView;
@property(nonatomic,strong)NSArray *pickArray;
@property(nonatomic,copy)NSString *chooseTime;
@end
@implementation ZCTimeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.1];
        
        [self addControls];
        
        
        
    }
    return self;

}



//设置默认值
-(void)setTimeStr:(NSString *)timeStr
{
    _timeStr=timeStr;
    
    int j=0;
    for (int i=0; i<self.pickArray.count; i++) {
        if ([self.timeStr isEqual:self.pickArray[i]]) {
            j=i;
            break;
        }
        
    }
    
    
    [self pickerView:self.pickView didSelectRow:j inComponent:0];
    [self.pickView selectRow:j inComponent:0 animated:YES];


}




//添加控件

-(void)addControls
{
    
    UIView *bjView=[[UIView alloc] init];
    bjView.backgroundColor=[UIColor whiteColor];
    bjView.alpha=1.0;
    bjView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
    [self addSubview:bjView];
    self.bjView=bjView;
    
    UIButton *cancelButton=[[UIButton alloc] init];
    cancelButton.frame=CGRectMake(10, 10, 80, 30);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    //[cancelButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    //[cancelButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateNormal];
    cancelButton.backgroundColor=ZCColor(136, 136, 136);
    cancelButton.layer.cornerRadius=3;//设置圆角的半径为10
    
    cancelButton.layer.masksToBounds=YES;
    [bjView addSubview:cancelButton];
    [cancelButton addTarget:self action:@selector(clickTheCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *determineButton=[[UIButton alloc] init];
    determineButton.frame=CGRectMake(bjView.frame.size.width-90, 10, 80, 30);
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton setBackgroundImage:[ZCTool imagePullLitre:@"dqyy_xuanzhong"] forState:UIControlStateNormal];
    //[determineButton setTitleColor:ZCColor(85, 85, 85) forState:UIControlStateNormal];
    [bjView addSubview:determineButton];
    [determineButton addTarget:self action:@selector(clickTheDetermineButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIPickerView *pickView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    pickView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickView.delegate=self;
    pickView.dataSource = self;
    //pickView.tintColor=[UIColor whiteColor];
    CGFloat pickViewW=SCREEN_WIDTH;
    CGFloat pickViewH=200;
    CGFloat pickViewX=0;
    CGFloat pickViewY=35;
    pickView.frame = CGRectMake(pickViewX, pickViewY, pickViewW, pickViewH);
    pickView.showsSelectionIndicator = YES;
    self.pickView=pickView;
    
    [bjView addSubview:pickView];
    
    
    
    
   [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        bjView.frame=CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, 200);
       self.alpha=1;
       bjView.alpha=1.0;
   } completion:^(BOOL finished) {
       
   }];
    
    
    

}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
    
}


//点击确定
-(void)clickTheDetermineButton
{
    if ([self.delegate respondsToSelector:@selector(timeViewChooseTime:)]) {
        [self.delegate timeViewChooseTime:self.chooseTime];
        
        [self clickTheCancelButton];
    }


}


//点击取消
-(void)clickTheCancelButton
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bjView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
        self.alpha=0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];


}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bjView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
        self.alpha=0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    

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
        _pickArray=@[@"9:00",@"9:15",@"9:30",@"9:45",@"10:00",@"10:15",@"10:30",@"10:45",@"11:00",@"11:15",@"11:30",@"11:45",@"12:00",@"12:15",@"12:30",@"12:45",@"13:15",@"13:30",@"13:45",@"14:00",@"14:15",@"14:30",@"14:45",@"15:00",@"14:45",@"15:00", @"15:15", @"15:30", @"15:45", @"16:00", @"16:15", @"16:30", @"16:45", @"17:00", @"17:15", @"17:30", @"17:45", @"18:00", @"18:15", @"18:30", @"18:45", @"19:00", @"19:15", @"19:30", @"19:45", @"20:00", @"20:15", @"20:30", @"20:45", @"21:00"];
        
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
    
    return 220;
}



//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    
//    
//    
//    
//    
//
//}

@end
