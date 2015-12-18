//
//  XZCell.h
//  dateDemo
//
//  Created by zxz on 15/12/8.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCell : UIView
@property (nonatomic)NSUInteger row;
@property (nonatomic)NSUInteger column;
@property (nonatomic)BOOL isSelected;
@property (nonatomic,strong)UILabel *textLable;

@end
