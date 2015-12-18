//
//  XZTimetableDB.h
//  TimetableDB
//
//  Created by zxz on 15/12/11.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
@interface XZTimetableDB : NSObject
+(instancetype)sharedDB;

//插入timetable数据
-(void)insertTimetable:(NSDictionary *)timetable;
//插入note数据
-(void)insertNote:(NSDictionary *)note;
//插入attendance数据
-(void)insertAttendance:(NSDictionary *)attendance;

//获取timetable全部数据
-(NSArray *)timetables;
//获取所有note
-(NSArray *)notes;
//获取所有attendance数据
-(NSArray *)attendances;

//根据timetableID删除timetable
-(void)deleteTimetable:(NSNumber *)timetableID;
//根据noteID删除note
-(void)deleteNote:(NSNumber *)noteID;
//根据attendanceID删除attendance
-(void)deleteAttendance:(NSNumber *)attendanceID;
@end
