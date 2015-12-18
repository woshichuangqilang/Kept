//
//  XZWeekBarItem.m
//  dateDemo
//
//  Created by zxz on 15/12/10.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZWeekBarItem.h"

@implementation XZWeekBarItem
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(1, 0, self.frame.size.width-1, self.frame.size.height/4.0)];
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(1, self.frame.size.height/4.0, self.frame.size.width-1, self.frame.size.height/4.0*3.0)];
        [self addSubview:_dateLabel];
        [self addSubview:_weekLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
