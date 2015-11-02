//
//  ZCTimeView.m
//  Ganton
//
//  Created by hh on 15/10/27.
//  Copyright © 2015年 zhongchuang. All rights reserved.
//

#import "ZCTimeView.h"
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
        
        
        
        //[self pickerView:self didSelectRow:10 inComponent:0];
        [self.pickView selectRow:10 inComponent:0 animated:YES];
        
    }
    return self;

}

//添加控件

-(void)addControls
{
    UIView *bjView=[[UIView alloc] init];
    bjView.backgroundColor=[UIColor whiteColor];
    bjView.alpha=1.0;
    bjView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200);
    [self addSubview:bjView];
    self.bjView=bjView;
    
    
    
    
    UIPickerView *pickView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    pickView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    pickView.delegate=self;
    pickView.dataSource = self;
    //pickView.tintColor=[UIColor whiteColor];
    CGFloat pickViewW=SCREEN_WIDTH;
    CGFloat pickViewH=200;
    CGFloat pickViewX=0;
    CGFloat pickViewY=0;
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
        _pickArray=@[@"8:30",@"8:45",@"9:00",@"9:15",@"9:30",@"9:45",@"10:00",@"10:15",@"10:30",@"10:45",@"11:00",@"11:15",@"11:30",@"11:45",@"12:00",@"12:15",@"12:30",@"12:45",@"13:15",@"13:30",@"13:45",@"14:00",@"14:15",@"14:30",@"14:45",@"15:00",@"14:45"];
        
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
    
    if ([self.delegate respondsToSelector:@selector(timeViewChooseTime:)]) {
        [self.delegate timeViewChooseTime:self.chooseTime];
    }
    
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
