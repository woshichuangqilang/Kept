//
//  XZMainViewController.m
//  dateDemo
//
//  Created by zxz on 15/12/9.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZMainViewController.h"
#import "XZTimetableView.h"
#import "XZWeekBar.h"
#import "XZCurrentWeek.h"
#import "KLMenuViewController.h"
#import "KLAbsentViewController.h"

@interface XZMainViewController ()<XZTimetableViewDataSourse,UIScrollViewDelegate,XZTimetableViewDelegate>
{
    NSArray *arr;
}
@property (nonatomic,strong)XZTimetableView *timetable;
@property (nonatomic,strong)XZWeekBar *weekBar;

@end

@implementation XZMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:181.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:0.5];
    //weekBar设置
    _weekBar = [[XZWeekBar alloc]initWithFrame:CGRectMake(0, 20, MAINWITH, MAINHEIGHT/12)];
    _weekBar.scrollEnabled = NO;
    [self.view addSubview:_weekBar];
    NSLog(@"----------%@",self.weekBar.weekArray);
    
    XZCurrentWeek *week = [[XZCurrentWeek alloc]init];
    arr= [[NSArray alloc]init];
    arr = [week currentWeek:[NSDate date]];
    //timetable设置
    _timetable= [[XZTimetableView alloc]initWithFrame:CGRectMake(0, MAINHEIGHT/12+20, MAINWITH, MAINHEIGHT-MAINHEIGHT/12-20)];
    _timetable.backgroundColor = [UIColor whiteColor];
    _timetable.mainScrollView.backgroundColor = [UIColor colorWithRed:147.0/255.0 green:224.0/255.0 blue:255.0/255.0 alpha:1.0];;
    _timetable.mainScrollView.delegate = self;
    _timetable.dataSourse = self;
    _timetable.delegate = self;
    [self.view addSubview:_timetable];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, _timetable.mainScrollView.frame.size.width/5.0, 200)];
    view.backgroundColor = [UIColor grayColor];
    [_timetable.mainScrollView addSubview:view];




}
//-(void)addClassView:(XZClass *)class{
//    UIView *classView = [[UIView alloc]init];
//    CGFloat width = _timetable.mainScrollView.frame.size.width/5.0;
//    CGFloat height;//需要知道课程开始和结束时间
//    CGFloat x ;
//    CGFloat y;
//}


//timetable的datasourse
-(NSInteger)numberOfRowsInTimetableView:(XZTimetableView *)timetableView{
    return 12;
}
-(NSInteger)numberOfColumnsInTimetableView:(XZTimetableView *)timetableView{
    return 7;
}
-(XZCell *)timetableView:(XZTimetableView *)timetableView cellInPositon:(XZPosition)position{
    XZCell *cell = [[XZCell alloc]init];
    //此处只能改变cell其他的不能变
    return cell;
}
- (void)timetableView:(XZTimetableView *)timetableView didSelectCellInPosition:(XZPosition)position{
    KLMenuViewController *menu = [[KLMenuViewController alloc]init];

    [self presentViewController:menu animated:YES completion:nil];
}
//mainScrollView的delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _weekBar.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //    NSLog(@"x=%f,y=%f",(*targetContentOffset).x,(*targetContentOffset).y);
    _weekBar.contentOffset = CGPointMake((*targetContentOffset).x, 0);
    
}



@end
