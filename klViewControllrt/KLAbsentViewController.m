//
//  KLAbsentViewController.m
//  FunctionPage.1
//
//  Created by 康梁 on 15/12/8.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLAbsentViewController.h"
#import "EAColourfulProgressView.h"


@interface KLAbsentViewController ()

@property (nonatomic, strong) UIAlertAction *secureTextAlertAction;

@property (weak, nonatomic) IBOutlet UILabel *classTabel;
@property (weak, nonatomic) IBOutlet UIButton *addNumButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *buildButton;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;

@property (strong, nonatomic) EAColourfulProgressView *progressView;
@property (strong, nonatomic) FMDatabase *db;


@end

@implementation KLAbsentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化absentNum
    if (self.absentNum) {
        NSLog(@"num = %lu",(unsigned long)self.absentNum);
    } else {
        self.absentNum = 0;
        self.addNumButton.enabled = NO;
    }
    
    if (self.absentNum < 1) {
        self.resetButton.enabled = NO;
    }
    
    // 获得课程名称
    self.classTabel.text = @"线性代数";
    
    // ProgressView
    self.progressView = [[EAColourfulProgressView alloc] initWithFrame:CGRectMake(26, 191, 235, 25)];
    self.progressView.initialFillColor = [UIColor redColor];
    self.progressView.oneThirdFillColor = [UIColor yellowColor];
    self.progressView.twoThirdsFillColor = [UIColor greenColor];
    self.progressView.finalFillColor = [UIColor greenColor];
    self.progressView.containerColor = [UIColor colorWithRed:0.1 green:0.14 blue:0.24 alpha:0.3];
    self.progressView.borderLineWidth = 3;
    self.progressView.cornerRadius = 9;
    self.progressView.showLabels = NO;
    self.progressView.labelTextColor = [UIColor blackColor];
    
    [self.progressView setupView];
    
    [self.view addSubview:self.progressView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
#pragma mark -FMDB库
    if ([self isTableOK:@"AbsentList"]) {
        FMResultSet *rs = [self.db executeQuery:@"SELECT ClassName, AbsentMax, AbsentNum, isAbsent, FROM AbsentList"];
        while ([rs next]) {
            self.absentMax = [rs intForColumn:@"AbsentMax"];
            self.absentNum = [rs intForColumn:@"AbsentNum"];
        }
        [rs close];
//        self.absentMax = [self.db intForQuery:@"SELECT AbsentMax FROM AbsentList WHERE ClassName = ?", @"线性代数"];
//        self.absentNum = [self.db intForQuery:@"SELECT AbsentNum FROM AbsentList WHERE ClassName = ?", @"线性代数"];
        NSLog(@"absentMax is %lu", (unsigned long)self.absentMax);
    } else {
        // 1.获取数据库文件路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"absent.sqlite"];
        
        // 2. 获取数据库
        FMDatabase *db = [FMDatabase databaseWithPath:fileName];
        
        // 3.打开数据库
        if ([db open]) {
            // 4.创建
            BOOL result = [db executeUpdate:@"CREATE TABLE AbsentList (ClassName text, AbsentMax integer, AbsentNum integer, isAbsent text, AbsentTime text)"];
            if (result) {
                NSLog(@"创建成功");
            } else {
                NSLog(@"创建失败");
            }
        }
        self.db = db;
        
        [self.db executeUpdate:@"INSERT INTO AbsentList (ClassName, AbsentMax, AbsentNum, isAbsent, AbsentTime) VALUES (?,?,?,?,?)", @"线性代数", [NSNumber numberWithUnsignedInteger:self.absentMax], [NSNumber numberWithUnsignedInteger:self.absentNum], self.isAbsent, self.absentTime];
        
        [self alertAndAbsentMax];
    }
    
    //    if (self.absentMax) {
    //
    //    } else {
    //
    //    }
    

}

- (void)showMax:(NSUInteger)max {
    NSString *text = [NSString stringWithFormat:@"%lu", max];
    self.maxLabel.text = text;
}

- (void)showNum:(NSUInteger)num {
    num = self.absentMax - num;
    NSString *text = [NSString stringWithFormat:@"%lu",num];
    self.numLabel.text = text;
}


#pragma mark -----使用alert提示输入absentMax
- (void)alertAndAbsentMax {
    // 初始化两个按钮两段文字
    NSString *titel = NSLocalizedString(@"缺席次数", nil);
    NSString *message = NSLocalizedString(@"一门课可以被允许缺席几次呢？", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titel message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // cancel action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"The \"Cancel\" alert's cancel action occured.");
                                       [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                                       
                                   }];
    
    // other(queding) action
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action)
                                  {
                                      NSLog(@"The \"Okay\" alert's other action occured.");
                                      [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                                      // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defineAbsentMax:) name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                                      
                                      // 把值赋给absentMax
                                      NSUInteger intString = [alertController.textFields.firstObject.text intValue];
                                      self.absentMax = intString;
                                      if ( self.absentMax > 0) {
                                          NSLog(@"max = %lu", self.absentMax);
                                          self.addNumButton.enabled = self.resetButton.enabled = YES;
                                          self.progressView.maximumValue = self.absentMax;
                                          [self.db executeUpdate:@"UPDATE AbsentList SET AbsentMax = ?;", [NSNumber numberWithUnsignedInteger:self.absentMax]];
                                          [self showMax:self.absentMax];
                                          [self showNum:self.absentNum];
                                          self.resetButton.enabled = NO;
                                      }
                                      
                                      
                                      
                                  }];
    
    // alertControllerAddAction
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    // 初始化时禁止使用『确定』键，直到监听到输入
    otherAction.enabled = NO;
    
    self.secureTextAlertAction = otherAction;
    
    // 增加文本框并且定制
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
     {
         // 监听
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
         
         // 定制键盘和输入框背景文字及clearButton
         textField.placeholder = @"请输入次数";
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.keyboardType = UIKeyboardTypeNumberPad;
     }];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark -监听方法
- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification
{
    UITextField *textField = notification.object;
    NSLog(@"Max = %lu", (unsigned long)self.absentMax);
    
    // 令『确定』键可用
    self.secureTextAlertAction.enabled = textField.text.length > 0;
    
}

#pragma mark ------覆写方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *Light = [UIImage imageNamed:@"Light.png"];
        self.tabBarItem.image = Light;
        
    }
    return self;
}


#pragma mark ------各个控件方法实现

- (IBAction)addAbsentNum:(id)sender {
    self.absentNum += 1;
    [self.db executeUpdate:@"UPDATE AbsentList SET AbsentNum = ?;", [NSNumber numberWithUnsignedInteger:self.absentNum]];
    NSLog(@"缺勤次数%lu",(unsigned long)self.absentNum);
    [self showNum:self.absentNum];
    
    if (self.absentMax && self.absentNum <= self.absentMax) {
        // 控制进度条的进度并重绘进度条
        self.progressView.currentValue = self.absentNum;
        [self.progressView updateToCurrentValue:self.absentNum + 1 animated:YES];
        
    }
    
    // 如果超出了max值
    if (self.absentNum >= self.absentMax) {
        UIAlertController *warning = [UIAlertController alertControllerWithTitle:@"警告" message:@"前方高能:缺勤次数已经超过老师的容忍度！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [warning addAction:cancel];
        
        [self presentViewController:warning animated:YES completion:nil];
        
        // 增加缺勤数按钮不可用
        self.addNumButton.enabled = NO;
    }
    
    if (self.absentNum >= 1) {
        self.resetButton.enabled = YES;
    }
}



// 清零缺勤计数且清零进度条
- (IBAction)reset:(id)sender {

    if (self.absentNum >= 1 && self.absentNum <= self.absentMax) {
        self.resetButton.enabled = YES;
        self.absentNum -= 1;
        [self.db executeUpdate:@"UPDATE AbsentList SET AbsentNum= ?;", [NSNumber numberWithUnsignedInteger:self.absentNum]];
        [self.progressView updateToCurrentValue:self.absentNum + 1 animated:YES];
        [self showNum:self.absentNum];
        NSLog(@"num = %lu", self.absentNum);
    } else {
        self.resetButton.enabled = NO;
    }
    
    if (self.absentNum < 1 || self.absentNum == self.absentMax) {
        self.resetButton.enabled = NO;
    }
    
    
    if (self.absentMax > 0) {
        self.addNumButton.enabled = YES;
    }
    
}


- (IBAction)building:(id)sender {
    [self alertAndAbsentMax];
}

#pragma mark -扩展（kl）
- (BOOL)isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [self.db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@"isTableOK %ld", (long)count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
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
