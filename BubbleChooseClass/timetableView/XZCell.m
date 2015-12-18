//
//  XZCell.m
//  dateDemo
//
//  Created by zxz on 15/12/8.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZCell.h"

@implementation XZCell
-(instancetype)init{
    self = [super init];
    if (self) {
        _textLable = [[UILabel alloc]init];
        [_textLable setNumberOfLines:0];
        _textLable.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_textLable];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLable = [[UILabel alloc]init];
        [_textLable setNumberOfLines:0];
        _textLable.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_textLable];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
}

@end
