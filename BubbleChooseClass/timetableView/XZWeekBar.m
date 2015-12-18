//
//  XZWeekBar.m
//  dateDemo
//
//  Created by zxz on 15/12/9.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZWeekBar.h"
#import "XZCurrentWeek.h"
#import "XZWeekBarItem.h"
@interface XZWeekBar()
{
    NSMutableArray *tem;
}
@end
@implementation XZWeekBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        tem = [[NSMutableArray alloc]init];
        _weekItem = [[NSArray alloc]init];
        self.contentSize = CGSizeMake(self.frame.size.width/5*7, self.frame.size.height);
        [self drawDaysView];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

//绘制星期栏
-(void)drawDaysView{
    //获取当前周
    NSArray *arr = [self getWeekArray];
    for (NSInteger i=1; i<=7; i++) {
        XZWeekBarItem *btn = [[XZWeekBarItem alloc]initWithFrame:CGRectMake(self.frame.size.width/5*(i-1), 0, self.frame.size.width/5, self.frame.size.height)];
        
        NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
//        dateFromatter.dateFormat = @"yyyy/MM/dd' 'HH:mm' 'cccc";
        dateFromatter.dateFormat = @"yyyy/MM/dd";
        
        NSDateFormatter *weekFomatter = [[NSDateFormatter alloc]init];
        weekFomatter.dateFormat = @"cccc";
        btn.dateLabel.text = [dateFromatter stringFromDate:[arr objectAtIndex:i-1]];
        btn.weekLabel.text = [weekFomatter stringFromDate:[arr objectAtIndex:i-1]];
        
        btn.dateLabel.adjustsFontSizeToFitWidth = YES;
        btn.weekLabel.adjustsFontSizeToFitWidth = YES;
        btn.dateLabel.backgroundColor = [UIColor colorWithRed:199.0/255.0 green:237.0/255.0 blue:233.0/255.0 alpha:1.0];
        btn.weekLabel.backgroundColor = [UIColor colorWithRed:92.0/255.0 green:167.0/255.0 blue:186.0/255.0 alpha:1.0];
        
        btn.dateLabel.font = [UIFont systemFontOfSize:8];
        btn.dateLabel.textAlignment = NSTextAlignmentCenter;
        
        btn.weekLabel.textAlignment  = NSTextAlignmentCenter;
        btn.tag = i;
        [self addSubview:btn];
        [tem addObject:btn];
    }
    _weekItem = [NSArray arrayWithArray:tem];
}

//获得当前周
-(NSArray *)getWeekArray{
    XZCurrentWeek *currentWeek = [[XZCurrentWeek alloc]init];
    _weekArray = [currentWeek currentWeek:[NSDate date]];
    return _weekArray;
}
@end
