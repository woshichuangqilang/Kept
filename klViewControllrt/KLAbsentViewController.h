//
//  KLAbsentViewController.h
//  FunctionPage.1
//
//  Created by 康梁 on 15/12/8.
//  Copyright © 2015年 kl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDB.h"

@interface KLAbsentViewController : UIViewController

// 变量absentMax记录被点到的极限值，所有课通用，如果有一门课不一样再做设置(一般为3-5）
@property (nonatomic, assign) NSUInteger absentMax;

@property (nonatomic, assign) NSUInteger absentNum;

@property (nonatomic, assign) NSString *classID;
@property (nonatomic, assign) NSString *isAbsent;
@property (nonatomic, assign) NSString *absentTime;


- (BOOL)isTableOK:(NSString *)tableName;
@end
