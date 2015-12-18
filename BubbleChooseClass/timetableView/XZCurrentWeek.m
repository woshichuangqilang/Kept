//
//  XZCurrentWeek.m
//  dateDemo
//
//  Created by zxz on 15/12/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZCurrentWeek.h"

@implementation XZCurrentWeek
-(NSArray *)currentWeek:(NSDate *)date{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSUInteger i = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSLog(@"%i",(int)i);

    NSDate *Sun = [NSDate dateWithTimeInterval:-60.0*60.0*24.0*((double)i-1.0) sinceDate:date];
    for (int i =1; i<=6; i++) {
         NSDate *tem = [NSDate dateWithTimeInterval:60.0*60.0*24.0*(double)i sinceDate:Sun];
        [arr addObject:tem];
    }
    [arr addObject:Sun];
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
    dateFromatter.dateFormat = @"yyyy/MM/dd' 'HH:mm' 'cccc";

    return [arr copy];
}

@end
