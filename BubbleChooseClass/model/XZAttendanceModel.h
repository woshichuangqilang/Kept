//
//  XZAttendanceModel.h
//  TimetableDB
//
//  Created by zxz on 15/12/12.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZAttendanceModel : NSObject
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSString *courseNameID;
@property (nonatomic,copy) NSString *isOnTime;
@property (nonatomic,copy) NSString *isBeenChecked;
@property (nonatomic,copy) NSString *attendanceTime;


@end
