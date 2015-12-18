//
//  XZWeekBar.h
//  dateDemo
//
//  Created by zxz on 15/12/9.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZWeekBar : UIScrollView

//weekItem存放了本周的星期,从星期一开始
@property (nonatomic,strong)NSArray *weekItem;
//weekArray存放了本周每天对应的日期
@property (nonatomic,strong,readonly)NSArray *weekArray;


@end
