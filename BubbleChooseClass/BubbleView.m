//
//  BubbleView.m
//  NewProject
//
//  Created by Andy Deng on 15/12/10.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import "BubbleView.h"
@interface BubbleView ()
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) CGFloat bubbleRadius;
@property (nonatomic) CGPoint location;
@property (nonatomic) BOOL isChosen;

@end

@implementation BubbleView

- (id)initWithFrame:(CGRect)frame bubbleColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _color = color;
        _bubbleRadius = frame.size.height / 2;
        _location = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        _isChosen = NO;
    }
    return self;
}

-(UIDynamicItemCollisionBoundsType) collisionBoundsType
{
    return UIDynamicItemCollisionBoundsTypeEllipse;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ was touched.",self);
//    
//    float red = (arc4random() % 100) / 100.0;
//    float green = (arc4random() % 100) / 100.0;
//    float blue = (arc4random() % 100) / 100.0;
//    
//    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    _color = randomColor;
    _isChosen = !_isChosen;
    if (_isChosen) {
        self.backgroundColor = _color;
        [self setNeedsDisplay];
    }else{
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self setNeedsDisplay];

    }

}

//- (void)setColor:(UIColor *)color {
//    _color = color;
//    [self setNeedsDisplay];
//}
- (void)drawRect:(CGRect)rect{
////    CGRect bounds = self.bounds;
////    CGPoint center = CGPointMake((int)arc4random()%(int)bounds.size.width, (int)arc4random()%(int)bounds.size.height);
//    
////    UIView *bubbleView = [[UIView alloc] initWithFrame:bounds];
//    UIBezierPath *circle = [UIBezierPath new];
//    [circle moveToPoint: CGPointMake(_location.x * 2, _location.y)];
//    [circle addArcWithCenter:_location radius:_bubbleRadius startAngle:M_PI * -0.5 endAngle:M_PI * 1.5 clockwise:YES];
//    [circle addClip];
////    [_color setFill];
////    UIRectFill(self.bounds);
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = circle.CGPath;
//    self. = maskLayer;
    self.layer.cornerRadius = _bubbleRadius;
    self.layer.masksToBounds = YES;
    UIImage *bubbleImage = [UIImage imageNamed:@"bubbleImage.png"];
    [bubbleImage drawInRect: rect];
}


- (void)setup {
//    self.backgroundColor = nil;
//    self.opaque = NO;
//    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [self setup];
}
- (UIColor *)bubbleColor {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return randomColor;
}




@end
