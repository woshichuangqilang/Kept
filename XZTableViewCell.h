//
//  XZTableViewCell.h
//  BubbleChooseClass
//
//  Created by zxz on 15/12/18.
//  Copyright © 2015年 ryeeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet UILabel *classRoom;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *teachingOurs;
@end
