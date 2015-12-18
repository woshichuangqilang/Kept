
//  KLClassPageViewController.m
//  KLClassMessagePage
//
//  Created by 康梁 on 15/12/15.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLClassPageViewController.h"
#import "ZHPickView.h"

#define kDuration 0.65

@interface KLClassPageViewController () <ZHPickViewDelegate>

@property (strong, nonatomic) UIScrollView *scorollView;
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@property (weak, nonatomic) IBOutlet UIButton *endButton;
@property (weak, nonatomic) IBOutlet UIButton *modelButton;
@property (weak, nonatomic) IBOutlet UIButton *weekButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) ZHPickView *pikerView;
@end

@implementation KLClassPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    
    addButton.frame = CGRectMake(screenFrame.size.width - 80, 125, 35, 35);
    
    
    [self.view addSubview: addButton];
    
    [addButton addTarget:self action:@selector(addSchoolHoursView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通过xib创建选课信息表以及删除功能

- (void)addSchoolHoursView {
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    UIView *last = [self.view.subviews lastObject];
    CGFloat rowY = last.frame.origin.y + last.frame.size.height;
    
    NSArray *rowView = [[NSBundle mainBundle] loadNibNamed:@"TimeView" owner:self options:nil];
    UIView *otherSchoolHours = rowView[0];
    [self.view addSubview:otherSchoolHours];
    
    
    // 动画
    otherSchoolHours.frame = CGRectMake(screenFrame.size.width, rowY,screenFrame.size.width, 110);
    otherSchoolHours.alpha = 1;
    
    [UIView animateWithDuration:kDuration animations:^{
        otherSchoolHours.frame = CGRectMake(0, rowY,screenFrame.size.width, 110);
        otherSchoolHours.alpha = 1;
    }];
    
    
}

- (IBAction)deleteOneView:(UIButton *)btn {
    
    [UIView animateWithDuration:kDuration animations:^{
        CGRect tempF = btn.superview.frame;
        tempF.origin.x = [UIScreen mainScreen].bounds.size.width;
        btn.superview.frame = tempF;
        
        btn.superview.alpha = 0;
    } completion:^(BOOL finished) {
        
        // 1. 获得即将删除的这行在数组中的位置
        long int startIndex = [self.view.subviews indexOfObject:btn.superview];
        
        // 2. 删除当前行
        [btn.superview removeFromSuperview];
        
        // 3. 遍历后面的子控件
        [UIView animateWithDuration:kDuration animations:^{
            for (long int i = startIndex; i < self.view.subviews.count; i++) {
                UIView *child = self.view.subviews[i];
                CGRect tempF = child.frame;
                tempF.origin.y -= btn.superview.frame.size.height;
                child.frame = tempF;
            }
        }];

    }];
    


}


#pragma mark - 创建pikerView方法

- (void)createDatePikerView {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    [self.pikerView remove];
    
    self.pikerView = [[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeTime isHaveNavControler:NO];
    
    self.pikerView.delegate = self;
    [self.pikerView show];
}

- (void)createArrayPikerView:(NSArray *)array {
    [self.pikerView remove];
    self.pikerView = [[ZHPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    
    self.pikerView.delegate = self;
    [self.pikerView show];
}


#pragma mark - 控件方法
- (IBAction)beginTime:(id)sender {
    [self createDatePikerView];
    
}

- (IBAction)endTime:(id)sender {
    [self createDatePikerView];
    
}
- (IBAction)model:(id)sender {
    NSArray *array = @[@"每周", @"单周", @"双周"];
    [self createArrayPikerView:array];
}

- (IBAction)selectWeek:(id)sender {
    NSArray *arry = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    [self createArrayPikerView:arry];
    
}

- (IBAction)checkOn:(id)sender {
    NSArray *array = @[@"考试", @"考核"];
    [self createArrayPikerView:array];
}


#pragma mark - 协议方法,处理选择结果
- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    
//    [self.beginButton setTitle:resultString forState:UIControlStateNormal];
//    [self.endButton setTitle:resultString forState:UIControlStateNormal];
//    [self.modelButton setTitle:resultString forState:UIControlStateNormal];
//    [self.weekButton setTitle:resultString forState:UIControlStateNormal];
}


@end
