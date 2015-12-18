//
//  XZTimetableView.m
//  dateDemo
//
//  Created by zxz on 15/12/8.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import "XZTimetableView.h"
@interface XZTimetableView()
@property (nonatomic)NSInteger numberOfRows;
@property (nonatomic)NSInteger numberOfColumns;
@property (nonatomic,strong)XZCell* selectedCell;
@property (nonatomic) CGFloat mainScrollViewHeight;
@property (nonatomic) CGFloat topScrollViewHeight;
@property (nonatomic,strong)NSArray *cellsArray;


@end

@implementation XZTimetableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _mainScrollView = [[UIScrollView alloc]init];
    }
    return self;
}

#pragma mark - delegate处理cell
-(void)tapCell:(UIGestureRecognizer *)tap{
    XZCell *cell = (XZCell *)tap.view;
    UIColor *originColor = cell.backgroundColor;
    XZPosition position;
    position.column = cell.column;
    position.row = cell.row;
    if (_selectedCell==nil) {
        _selectedCell = cell;
        _selectedCell.backgroundColor = [UIColor redColor];
    }else if (_selectedCell!=nil&&_selectedCell!=cell){
        _selectedCell.backgroundColor = originColor;
        _selectedCell = cell;
        _selectedCell.backgroundColor = [UIColor redColor];
    }else if (_selectedCell !=nil&&_selectedCell==cell){
        cell.backgroundColor = [UIColor clearColor];
        _selectedCell = nil;
    }
    [_delegate timetableView:self didSelectCellInPosition:position];
    
}
#pragma mark - datasourse获取数据
-(void)setContentSize:(CGRect)rect
{
    _mainScrollViewHeight = rect.size.height;
    _mainScrollView.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    
}
-(void)setDataSourse:(id<XZTimetableViewDataSourse>)dataSourse
{
    if (_dataSourse !=dataSourse) {
        _dataSourse = dataSourse;
    }
    _numberOfRows = [_dataSourse numberOfRowsInTimetableView:self];
    _numberOfColumns = [_dataSourse numberOfColumnsInTimetableView:self];
    [self setContentSize:self.frame];
    [self loadViews];
}

-(void)loadViews{
    [self drawCellsInScrollView:_mainScrollView withNumberOfRows:_numberOfRows andNumberOfColumns:_numberOfColumns];
    _mainScrollView.directionalLockEnabled = YES;
    _mainScrollView.bounces = NO;
    _mainScrollView.alwaysBounceVertical = YES;
    _mainScrollView.decelerationRate = 0;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_mainScrollView];
    [self drawBorderInView:_mainScrollView withBorderWidth:.5];
}


//为scrollView绘制cell
-(void)drawCellsInScrollView:(UIScrollView *)scrollView withNumberOfRows:(NSInteger)numberOfRows andNumberOfColumns:(NSInteger)numberOfColumns
{   CGFloat cellWidth = scrollView.frame.size.width/(numberOfColumns-2);
    CGFloat cellHeight = scrollView.frame.size.height/(numberOfRows);
    if (numberOfRows >=10) {
        cellHeight = scrollView.frame.size.height/(numberOfRows-4);
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSInteger i=0; i < numberOfColumns; i++) {
        for (NSInteger j=0; j < numberOfRows; j++) {
            XZPosition position;
            position.row = j;
            position.column = i;
            if ([_dataSourse timetableView:self cellInPositon:position]!=nil) {
                XZCell *cell = [_dataSourse timetableView:self
                                            cellInPositon:position];
                cell.row = j;
                cell.column = i;
//                cell.textLable.frame = CGRectMake(0, 0, cellWidth, cellHeight);
//                cell.textLable.backgroundColor = [UIColor clearColor];
                cell.backgroundColor = [UIColor clearColor];

                cell.frame = CGRectMake(cellWidth*i, cellHeight*j, cellWidth, cellHeight);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCell:)];
                [cell addGestureRecognizer:tap];
            
                [arr addObject:cell];
                [scrollView addSubview:cell];
            }
        }
    }
    self.cellsArray = [arr copy];
    scrollView.contentSize = CGSizeMake(cellWidth*numberOfColumns, cellHeight*numberOfRows);
}
//scoll为cell加边框
-(void)drawBorderInView:(UIScrollView *)sc withBorderWidth:(CGFloat)borderWidth{
    for (int i = 0; i <= 12; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, i*sc.frame.size.height/8.0, sc.frame.size.width/5.0*7.0,borderWidth )];
        view.backgroundColor = [UIColor whiteColor];
        [sc addSubview:view];
    }
    for (int j = 0; j <= 7; j++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(j*sc.frame.size.width/5.0, 0, borderWidth,sc.frame.size.height/8.0*12)];
        view.backgroundColor = [UIColor whiteColor];
        [sc addSubview:view];
    }
}






//处理datasourse传来的cell的text,未完成
-(XZCell *)cellInPosition:(XZPosition)position
{
    for (XZCell *obj in _cellsArray) {
        if (obj.row ==position.row && obj.column == position.column) {
            NSLog(@"cell in position (%i,%i)",(int)obj.row,(int)obj.column);
            return (XZCell *)obj;
        }
    }
    return nil;
}



@end
