//
//  ZCPrivateAppointmentView.m
//  Ganton
//
//  Created by hh on 16/1/12.
//  Copyright © 2016年 zhongchuang. All rights reserved.
//私人预约

#import "ZCPrivateAppointmentView.h"
#import "ZCScheduleModel.h"
@interface ZCPrivateAppointmentView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,weak)UIView *bjView;
@property(nonatomic,weak)UIPickerView *pickView;
@property(nonatomic,copy)NSString *chooseTime;

@end
@implementation ZCPrivateAppointmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        [self addControls];
    }
    return self;

}

//添加控件
-(void)addControls
{
    UIView *bjView=[[UIView alloc] init];
    bjView.backgroundColor=[UIColor whiteColor];
    bjView.alpha=1.0;
    bjView.frame=CGRectMake(0, (SCREEN_HEIGHT-250)/2, SCREEN_WIDTH, 250);
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
    CGFloat pickViewH=180;
    CGFloat pickViewX=0;
    CGFloat pickViewY=35;
    pickView.frame = CGRectMake(pickViewX, pickViewY, pickViewW, pickViewH);
    pickView.showsSelectionIndicator = YES;
    self.pickView=pickView;
    
    [bjView addSubview:pickView];
    

    

}

-(void)setArray:(NSArray *)array
{
    _array=array;
    
    [self pickerView:self.pickView didSelectRow:0 inComponent:0];

}

//点击确定
-(void)clickTheDetermineButton
{
    if (self.chooseTimeBlock) {
        self.chooseTimeBlock(self.chooseTime);
        [self clickTheCancelButton];
    }
    
    
//    if ([self.delegate respondsToSelector:@selector(timeViewChooseTime:)]) {
//        [self.delegate timeViewChooseTime:self.chooseTime];
//        
//        [self clickTheCancelButton];
//    }

    
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



#pragma mark - 数据源方法


/**
 *  一共有多少列
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   
    return 1;
    
    
    
}

/**
 *  第component列显示多少行
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.array.count;
}


/**
 *  第component列的第row行显示什么文字
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return nil;//self.pickArray[component][row];
}


/**
 *  选中了第component列的第row行
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    ZCLog(@"%ld",(long)row);
    
    //self.chooseTime=self.pickArray[row];
   // ZCScheduleModel *model=self.array[row];
   // NSInteger nowRow;
    for (NSInteger i=row; i<self.array.count; i++) {
        ZCScheduleModel *model=self.array[i];
        if ([model.state isEqual:@"available"]) {
            self.chooseTime=model.time;
            [self.pickView selectRow:i inComponent:0 animated:YES];
            break;
        }else{
        
            if (i==self.array.count-1) {
                for (NSInteger j=self.array.count-1; j>-1; j--) {
                    ZCScheduleModel *model=self.array[j];
                    if ([model.state isEqual:@"available"]) {
                        self.chooseTime=model.time;
                        [self.pickView selectRow:j inComponent:0 animated:YES];
                        break;
                    }
                }
            }
        }
        
        //ZCLog(@"%@",self.chooseTime);
    }
    
     ZCLog(@"%@",self.chooseTime);
    
//    if ([model.state isEqual:@"available"]) {
//        ZCLog(@"%ld",(long)row);
//        
//    }else{
//        ZCLog(@"%ld",(long)row);
//        
//        [self.pickView selectRow:row+1 inComponent:0 animated:YES];
//        //[self pickerView:self.pickView didSelectRow:row+1 inComponent:0];
//         ZCLog(@"%ld",(long)row);
//    }
}


//- (UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component{
////  return
//}

//改变pickview的字体颜色

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    ZCScheduleModel *model=self.array[row];
    NSString *title;
    title = [NSString stringWithFormat:@"%@",[self.array[row] time]];
    NSAttributedString *attString;
    if ([model.state isEqual:@"available"] ) {
        attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:ZCColor(252, 76, 27)}];
    }else{
    attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:ZCColor(213, 213, 213)}];
    }
    return attString;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return 220;
}



-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
    
}


@end
