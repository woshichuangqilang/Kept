//
//  XZTimetableView.h
//  dateDemo
//
//  Created by zxz on 15/12/8.
//  Copyright © 2015年 zxz. All rights reserved.
//
#define MAINWITH [UIScreen mainScreen].bounds.size.width
#define MAINHEIGHT [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>
#import "XZCell.h"
@class XZTimetableView;
typedef struct  _XZPosition {
    NSUInteger row;
    NSUInteger column;
}XZPosition;
#pragma mark -datasouse
@protocol XZTimetableViewDataSourse <NSObject>
-(NSInteger)numberOfRowsInTimetableView:(XZTimetableView *)timetableView;
-(NSInteger)numberOfColumnsInTimetableView:(XZTimetableView *)timetableView;
-(XZCell *)timetableView:(XZTimetableView *)timetableView cellInPositon:(XZPosition)position;
@end

#pragma mark -delegate
@protocol XZTimetableViewDelegate <NSObject>
@optional
- (void)timetableView:(XZTimetableView *)timetableView didSelectCellInPosition:(XZPosition)position;
@end

#pragma mark -XZTimetableView
@interface XZTimetableView : UIView
@property (nonatomic ,weak) id <XZTimetableViewDataSourse> dataSourse;
@property (nonatomic ,weak) id <XZTimetableViewDelegate> delegate;
@property (strong, nonatomic) UIScrollView *topScrollView;
@property (strong, nonatomic) UIScrollView *mainScrollView;


-(void)loadViews;
@end


