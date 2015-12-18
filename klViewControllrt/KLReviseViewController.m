//
//  KLReviseViewController.m
//  KLRevise
//
//  Created by 康梁 on 15/12/17.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLReviseViewController.h"
#import <UIKit/UIKit.h>
#import "SPNavigationController.h"
#import "KLReviseStore.h"

@interface KLReviseViewController ()

@property (strong, nonatomic) KLReviseStore *item;
@property (strong, nonatomic) NSArray *cards;

@end


@implementation KLReviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SPNavigationController *revise = [[SPNavigationController alloc] init];
    
//    self.item = [KLReviseStore sharedStore];
//    
//    self.cards = [self.item allItems];
    
    revise.viewControllers = self.cards;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
