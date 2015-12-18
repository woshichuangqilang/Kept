//
//  XZPickerView.m
//  pickerView
//
//  Created by zxz on 15/12/17.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZPickerView.h"

@implementation XZPickerView

- (void)drawRect:(CGRect)rect {
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    [bezierPath setLineWidth:5.0f];
    [[UIColor whiteColor] setStroke];
    
    UIColor *fillColor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1]; // color equivalent is #87ceeb
    
    [fillColor setFill];
    
    [bezierPath stroke];
    //    [bezierPath fill];
    CGContextRestoreGState(aRef);
}
@end
