//
//  BubbleChooseClassViewController.m
//  NewProject
//
//  Created by Andy Deng on 15/12/8.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import "BubbleChooseClassViewController.h"
#import "BubbleView.h"

@interface BubbleChooseClassViewController ()
@property (nonatomic) CGPoint centerOfBubble;
@property (nonatomic, strong) UIView *bubble;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) UISnapBehavior *snap;


@end

@implementation BubbleChooseClassViewController

static const CGFloat BUBBLE_AVG_RADIUS = 40;

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (UICollisionBehavior *)collision {
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:_collision];
    }
    return _collision;
}

- (void)viewDidLoad
{

    CGRect frame = [UIScreen mainScreen].bounds;
    NSArray *classes = @[@"英语",@"体育",@"毛概",@"思道修",@"马哲",@"马原",@"邓三",@"文献检索",@"高数",@"大物",@"机械制图",@"形政"];

    for (int i=0; i<[classes count] ; i++) {
        for (BOOL isFind = NO; isFind == NO; ) {
            CGPoint centerOfBubble = CGPointMake(arc4random()%(int)frame.size.width, arc4random()%(int)frame.size.height);
            if (BUBBLE_AVG_RADIUS*2 < centerOfBubble.x &&
                centerOfBubble.x < (frame.size.width - BUBBLE_AVG_RADIUS*2) &&
                BUBBLE_AVG_RADIUS*2 < centerOfBubble.y &&
                centerOfBubble.y < (frame.size.height - BUBBLE_AVG_RADIUS*2)) {

                isFind = YES;
                _centerOfBubble = centerOfBubble;
                continue;
            }else{
                isFind = NO;
            }
        }//_center 泡泡是在屏幕上的中心

        float bubbleZoomRatio = arc4random()%100;
        CGRect bubbleFrame = CGRectMake(_centerOfBubble.x - BUBBLE_AVG_RADIUS, _centerOfBubble.y - BUBBLE_AVG_RADIUS, BUBBLE_AVG_RADIUS*(2+bubbleZoomRatio/100), BUBBLE_AVG_RADIUS*(2+bubbleZoomRatio/100));

        BubbleView *bubble = [[BubbleView alloc] initWithFrame:bubbleFrame bubbleColor:[UIColor colorWithRed:0.6 green:0.5 blue:0.5 alpha:1]];
        bubble.tag = i;

        UILabel *classInBubbleLabel = [[UILabel alloc] init];
        classInBubbleLabel.backgroundColor = nil;
        classInBubbleLabel.textColor = [UIColor darkGrayColor];
        classInBubbleLabel.text = classes[i];
        classInBubbleLabel.textAlignment = NSTextAlignmentCenter;
        classInBubbleLabel.tag = i;
        classInBubbleLabel.font=[UIFont systemFontOfSize:10*(2+bubbleZoomRatio/130)];
        [classInBubbleLabel sizeToFit];

        CGRect labelFrame = classInBubbleLabel.frame;
        labelFrame.origin = CGPointMake(bubbleFrame.size.width/2 - classInBubbleLabel.frame.size.width/2, bubbleFrame.size.height/2 - classInBubbleLabel.frame.size.height/2);
        classInBubbleLabel.frame = labelFrame;
        
        [bubble addSubview:classInBubbleLabel];
        [self.view addSubview:bubble];
        self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];

        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:bubble snapToPoint:CGPointMake(frame.size.width/2, frame.size.height/2)];
        snap.damping = 12;
        [self.animator addBehavior:snap];
        [self.collision addItem:bubble];
        
    }
    UIDynamicItemBehavior *bubbleBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.view.subviews];
    bubbleBehavior.density = 10000;
//    bubbleBehavior.elasticity = 0.0;
//    bubbleBehavior.resistance = 100;
    bubbleBehavior.friction = 0.1;
    bubbleBehavior.allowsRotation = NO;
    [self.animator addBehavior: bubbleBehavior];

////    BubbleView *bubble = [[BubbleView alloc] initWithFrame:CGRectMake(0, 200, 320, 320)];
////    [self.view addSubview:bubble];
//
//}
//
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
}
//*/
//-(UIDynamicItemCollisionBoundsType) collisionBoundsType
//{
//    return UIDynamicItemCollisionBoundsTypeEllipse;
//}
//
@end
