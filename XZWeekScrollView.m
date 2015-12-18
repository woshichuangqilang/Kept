//
//  XZWeekScrollView.m
//  pickerView
//
//  Created by zxz on 15/12/16.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZWeekScrollView.h"

@implementation XZWeekScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        int a = 1;
        for (NSInteger i=0; i<4; i++) {
            for (NSInteger j=0; j<8; j++) {
                CGFloat width = frame.size.width/8;
                XZRoundRect *view = [[XZRoundRect alloc]initWithFrame:CGRectMake(width*j, width*i, width, width)];
                view.backgroundColor = [UIColor grayColor];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
                [view addGestureRecognizer:tap];
                
                NSString *str = [NSString stringWithFormat:@"%i",a++];
                view.textLable.text = str;
                view.textLable.textAlignment = NSTextAlignmentCenter;

                [self addSubview:view];
            }
        }
        self.contentSize = CGSizeMake(frame.size.width, frame.size.width/8.0*4);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;

    }
    return self;
}

-(void)tapView:(UIGestureRecognizer *)tap{
    
    XZRoundRect *tapView = (XZRoundRect *)tap.view;
    NSLog(@"%@",tapView.textLable.text);
    if (!tapView.beSelected) {
        tapView.backgroundColor = [UIColor blueColor];
        tapView.beSelected = YES;
    }else{
        tapView.backgroundColor = [UIColor grayColor];
        tapView.beSelected = NO;
    }
    
    
    

    
}
- (void)drawRect:(CGRect)rect {
    
//    CGContextRef aRef = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(aRef);
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
//    [bezierPath setLineWidth:5.0f];
//    [[UIColor blackColor] setStroke];
//
//    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1]; // color equivalent is #87ceeb
//    [fillColor setFill];
//    
//    [bezierPath stroke];
//    [bezierPath fill];
//    CGContextRestoreGState(aRef);
}

@end
