//
//  KLMenuViewController.m
//  PopMenuItem
//
//  Created by 康梁 on 15/12/14.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLMenuViewController.h"
#import "JKPopMenuView.h"

@interface KLMenuViewController () <JKPopMenuViewSelectDelegate>



@end

@implementation KLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] init];
    [self showMenu:button];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMenu:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // 签到
    JKPopMenuItem *itemSign = [JKPopMenuItem itemWithTitle:@"签到" image:[UIImage imageNamed:@"icon1"]];
    [array addObject:itemSign];
    [itemSign addTarget:self action:@selector(slectSignView) forControlEvents:UIControlEventTouchUpInside];
    
    // 缺席
    JKPopMenuItem *itemAbsent = [JKPopMenuItem itemWithTitle:@"缺席" image:[UIImage imageNamed:@"icon2"]];
    [array addObject:itemAbsent];
    [itemAbsent addTarget:self action:@selector(selectAbsentView) forControlEvents:UIControlEventTouchUpInside];
    
    // 笔记
    JKPopMenuItem *itemNote = [JKPopMenuItem itemWithTitle:@"笔记" image:[UIImage imageNamed:@"icon3"]];
    [array addObject:itemNote];
    [itemNote addTarget:self action:@selector(selectNoteView) forControlEvents:UIControlEventTouchUpInside];
    
    // 复习
    JKPopMenuItem *itemRevise = [JKPopMenuItem itemWithTitle:@"复习" image:[UIImage imageNamed:@"icon4"]];
    [array addObject:itemRevise];
    [itemRevise addTarget:self action:@selector(selectReviseView) forControlEvents:UIControlEventTouchUpInside];
    
    JKPopMenuView *popView = [JKPopMenuView menuViewWithItems:array];
    popView.delegate = self;
    // [self.view addSubview:popView];
    [popView show];
}

- (void)popMenuViewSelectIndex:(NSInteger)index {
    NSLog(@"%s", __func__);
    NSLog(@"%ld", index);
}

// 签到
- (void)slectSignView {
    NSLog(@"select sign view");
}

// 缺席
- (void)selectAbsentView {
    NSLog(@"select absent view");
}

// 笔记
- (void)selectNoteView {
    NSLog(@"select note view");
}

// 复习
- (void)selectReviseView {
    NSLog(@"select Recise view");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
