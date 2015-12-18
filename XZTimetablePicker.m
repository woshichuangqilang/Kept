//
//  XZTimetablePicker.m
//  pickerView
//
//  Created by zxz on 15/12/15.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZTimetablePicker.h"
#import "XZWeekScrollView.h"
#import "XZPickerView.h"
#import "XZRoundRect.h"

@interface XZTimetablePicker ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    UIView *pick;
}
@property (nonatomic,strong)XZPickerView *classPicker;
@property (nonatomic,strong)NSArray  *slectClassNumber;
@property (nonatomic,strong)NSArray  *week;
@property (nonatomic,strong)NSMutableArray *numberOfClasser;
@property (nonatomic,strong)NSArray  *arr;
@property (weak, nonatomic) IBOutlet UITableView *weekList;

@end

@implementation XZTimetablePicker
static UIWindow *pickW = nil;
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _slectClassNumber = [NSArray arrayWithObjects:@"第一节开始",@"第二节开始",@"第三节开始",@"第四节开始",@"第五节开始",@"第六节开始",@"第七节开始",@"第八节开始",@"第九节开始",@"第十节开始",@"第十一节开始",@"第十二节开始", nil];
        _week = [NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
        _numberOfClasser =[NSMutableArray arrayWithObjects:@"共一节",@"共两节",@"共三节",@"共四节",@"共五节",@"共六节",@"共七节",@"共八节",@"共九节",@"共十节",@"共十一节",@"共十二节", nil];
        _arr  = [NSArray arrayWithObjects:_week,_slectClassNumber,_numberOfClasser, nil];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    pick = [[UIView alloc]init];
    pick.frame = CGRectMake(0, height-width/8.0*6.0, width, width/8.0*6.0);
//    pick.frame = CGRectMake(0, 0, width, width/8.0*6.0);
    pick.backgroundColor = [UIColor colorWithRed:92.0/255.0 green:167.0/255.0 blue:186.0/255.0 alpha:1.0];
    CGRect main = pick.frame;
    
    //上课选择器工具栏
    XZRoundRect *pickTool = [[XZRoundRect alloc]initWithFrame:CGRectMake(0, 0, width, width/8.0)];
    pickTool.backgroundColor = [UIColor grayColor];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0, 0, width/8.0*2.0, width/8.0);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [pickTool addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(width-width/8.0*2.0, 0, width/8.0*2.0, width/8.0);
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [pickTool addSubview:confirmBtn];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(width/8.0*2.0, 0, width-width/8.0*4.0, width/8.0)];
    message.textAlignment = NSTextAlignmentCenter;
    message.text = @"请输入上课时间和上课周";
    [pickTool addSubview:message];
    
    [pick addSubview:pickTool];

    XZRoundRect *cancelBtnBackView = [[XZRoundRect alloc]initWithFrame:CGRectMake(0, 0, width/8.0*2.0, width/8.0)];
    
    
    //选择上课时间
    _classPicker = [[XZPickerView alloc]initWithFrame:CGRectMake(0, main.size.height-main.size.width/8.0*5.0, main.size.width, main.size.width/8.0*3.0)];
    _classPicker.backgroundColor = [UIColor grayColor];
    _classPicker.dataSource = self;
    _classPicker.delegate = self;
    [pick addSubview:_classPicker];
    
    //选择上课周
    XZWeekScrollView *pickingWeek = [[XZWeekScrollView alloc]initWithFrame:CGRectMake(0, main.size.height-main.size.width/4.0, main.size.width,main.size.width/8.0*2.0)];
    pickingWeek.backgroundColor = [UIColor whiteColor];
    [pick addSubview:pickingWeek];
    UIWindow *pickWindow = [UIApplication sharedApplication].keyWindow;
    [pickWindow addSubview:pick];
//    UIWindow *pickWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, height-width/8.0*6.0, width, width/8.0*6.0)];
//    UIViewController *pickC = [[UIViewController alloc]init];
//    pickC.view.frame = CGRectMake(0, 0, width, width/8.0*6.0);
//    pickWindow.rootViewController = pickC;
//    [pickC.view addSubview:pick];
//    pickWindow.windowLevel = UIWindowLevelNormal;
//    pickWindow.hidden = NO;
    
    
}

-(void)confirm:(id)sender{
    [pick removeFromSuperview];
}
#pragma mark - pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [_arr count];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[_arr objectAtIndex:component] count];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return pickerView.frame.size.height/3.0;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 1) {
        return [[_arr objectAtIndex:1] objectAtIndex:row];
    }
    if (component == 0) {
        return [[_arr objectAtIndex:0] objectAtIndex:row];
    }else{
        return [_numberOfClasser objectAtIndex:row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"共一节",@"共两节",@"共三节",@"共四节",@"共五节",@"共六节",@"共七节",@"共八节",@"共九节",@"共十节",@"共十一节",@"共十二节", nil];
    if (component == 1) {
        [_numberOfClasser removeAllObjects];
        for (NSInteger i=0; i<(12-row); i++) {
            [_numberOfClasser addObject:[array objectAtIndex:i]];
        }
    }
    [pickerView reloadAllComponents];
}

@end
