//
//  XZTimetableDB.m
//  TimetableDB
//
//  Created by zxz on 15/12/11.
//  Copyright © 2015年 zxz. All rights reserved.
//
#import "XZTimetableDB.h"
#import "XZTimetableModel.h"
#import "XZNoteModel.h"
#import "XZAttendanceModel.h"
static XZTimetableDB *_timetableDB = nil;

@interface XZTimetableDB()
{
    FMDatabase *_fmDB;
}
@end
@implementation XZTimetableDB

+(instancetype)sharedDB{
    if (!_timetableDB) {
        _timetableDB = [[self alloc]initPrivate];
        [_timetableDB initDataBase];
        
    }
    return _timetableDB;
}
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [XZTimetableDB sharedDB]" userInfo:nil];
    return nil;
}
-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//创建path
-(NSString* )databasePath
{
    NSString* path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",path);
    NSString* dbPath=[path stringByAppendingPathComponent:@"timetalbe.db"];
    return dbPath;
}

#pragma mark -create table
-(void)initDataBase{
    _fmDB=[FMDatabase databaseWithPath:[self databasePath]];
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    if (![_fmDB tableExists:@"timetable"]) {
        [_fmDB executeUpdate:@"create table timetable (id integer primary key autoincrement not null,courseName text,teacherName text,classroom text,schooltime text,weeks text,startingTime text,endingTime text,examination text,checkingStandard text,maxAbsenceNumber text,homework text)"];
    }
    if (![_fmDB tableExists:@"note"]){
        [_fmDB executeUpdate:@"create table note (id integer primary key autoincrement not null,courseNameID text,content text,title text,priority text,recordingTime text,image text,imageID text,soundRecording text,searchKeyword text)"];
    }
    if(![_fmDB tableExists:@"attendance"]){
        [_fmDB executeUpdate:@"create table attendance (id integer primary key autoincrement not null,courseNameID text,isOnTime text,isBeenChecked text,attendanceTime text)"];
    }
    [_fmDB close];
}

#pragma mark -Insert
-(NSString *)makeInsertingSQLString:(NSDictionary *)obj forDataBaseTable:(NSString *)tablename{
    NSArray *keys = [obj allKeys];
    
    NSString *str1 = @"";
    NSString *str2 = @"";
    NSString *tem = @"";
    for (int i=0; i<[keys count]; i++) {
        if ([[keys objectAtIndex:i] isEqualToString:@"ID"]) {
            tem = @"";
        }else{
            tem = [NSString stringWithFormat:@"%@,",[keys objectAtIndex:i]];
            str1 = [str1 stringByAppendingString:tem];
            str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@":%@",tem]];
        }
    }
    NSMutableString *s1 = [NSMutableString stringWithString:str1];
    NSMutableString *s2 = [NSMutableString stringWithString:str2];
    NSRange range;
    range.length = 1;
    range.location = [s1 length]-1;
    [s1 replaceCharactersInRange:range withString:@""];
    NSRange range2;
    range2.length = 1;
    range2.location = [s2 length]-1;
    [s2 replaceCharactersInRange:range2 withString:@""];
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)",tablename,s1,s2];
    NSLog(@"%@",sql);
    
    return sql;
    
}
//插入timetable数据
-(void)insertTimetable:(NSDictionary *)timetable{
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    NSString *insertSQL = [self makeInsertingSQLString:timetable forDataBaseTable:@"timetable"];
    BOOL insert = [_fmDB executeUpdate:insertSQL withParameterDictionary:timetable];
    if (!insert) {
        NSLog(@"增加timetable数据失败");
    }
    [_fmDB close];
}
//插入note数据
-(void)insertNote:(NSDictionary *)note{
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    NSString *insertSQL = [self makeInsertingSQLString:note forDataBaseTable:@"note"];
    BOOL insert = [_fmDB executeUpdate:insertSQL withParameterDictionary:note];
    if (!insert) {
        NSLog(@"增加note数据失败");
    }
    [_fmDB close];
}
//插入attendance数据
-(void)insertAttendance:(NSDictionary *)attendance{
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    NSString *insertSQL = [self makeInsertingSQLString:attendance forDataBaseTable:@"attendance"];
    BOOL insert = [_fmDB executeUpdate:insertSQL withParameterDictionary:attendance];
    if (!insert) {
        NSLog(@"增加attendance数据失败");
    }
    [_fmDB close];
}

#warning update
////跟新数据
//-(void)updateTimetable:(XZTimetableModel *)timetable orNote:(XZNoteModel *)note orAttendanceRecord:(XZAttendanceModel *)attendance{
//    if (![_fmDB open]) {
//        NSLog(@"Open database failed");
//        return;
//    }
//}
//

#pragma mark -getdata
//获取timetable全部数据
-(NSArray *)timetables{
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    FMResultSet* timetableRes=[_fmDB executeQuery:@"select* from timetable"];
    while ([timetableRes next]) {
        NSLog(@"获取timetable的数据");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        for (int i=0; i<timetableRes.columnCount; i++) {
            if ([[timetableRes columnNameForIndex:i] isEqualToString:@"id"]) {
                NSNumber *idNum = [NSNumber numberWithInt:[timetableRes intForColumnIndex:i]];
                [dic setObject:idNum forKey:@"ID"];
            }else if([timetableRes stringForColumnIndex:i]!=nil){
            [dic setObject:[timetableRes stringForColumnIndex:i] forKey:[timetableRes columnNameForIndex:i]];
            }
        }
        [arr addObject:dic];
    }
    [_fmDB close];

    return arr;

}
//获取所有note
-(NSArray *)notes{
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    FMResultSet* notesRes=[_fmDB executeQuery:@"select* from note"];
    while ([notesRes next]) {
        NSLog(@"获取note的数据");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        for (int i=0; i<notesRes.columnCount; i++) {
            if ([[notesRes columnNameForIndex:i] isEqualToString:@"id"]) {
                NSNumber *idNum = [NSNumber numberWithInt:[notesRes intForColumnIndex:i]];
                [dic setObject:idNum forKey:@"ID"];
            }else if([notesRes stringForColumnIndex:i]!=nil){
                [dic setObject:[notesRes stringForColumnIndex:i] forKey:[notesRes columnNameForIndex:i]];
            }
        }
        [arr addObject:dic];
    }
    [_fmDB close];

    return arr;
}
//获取所有attendance数据
-(NSArray *)attendances{
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    FMResultSet* attendancesRes=[_fmDB executeQuery:@"select* from attendance"];
    while ([attendancesRes next]) {
        NSLog(@"获取attendance的数据");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        for (int i=0; i<attendancesRes.columnCount; i++) {
            if ([[attendancesRes columnNameForIndex:i] isEqualToString:@"id"]) {
                NSNumber *idNum = [NSNumber numberWithInt:[attendancesRes intForColumnIndex:i]];
                [dic setObject:idNum forKey:@"ID"];
            }else{
                [dic setObject:[attendancesRes stringForColumnIndex:i] forKey:[attendancesRes columnNameForIndex:i]];
            }
        }
        [arr addObject:dic];
    }
    [_fmDB close];
    return arr;
}

#pragma mark -delete
-(void)deleteTimetable:(NSNumber *)timetableID{
    int ID = [timetableID intValue];
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    BOOL delete=[_fmDB executeUpdate:@"delete from timetable where id = ?",[NSString stringWithFormat:@"%i",ID]];
    if (!delete) {
        NSLog(@"删除timetable失败,ID:%i",ID);
    }
    [_fmDB close];

}
-(void)deleteNote:(NSNumber *)noteID{
    int ID = [noteID intValue];
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    BOOL delete=[_fmDB executeUpdate:@"delete from note where id = ?",[NSString stringWithFormat:@"%i",ID]];
    if (!delete) {
        NSLog(@"删除timetable失败,ID:%i",ID);
    }
    [_fmDB close];

}
-(void)deleteAttendance:(NSNumber *)attendanceID{
    int ID = [attendanceID intValue];
    if (![_fmDB open]) {
        NSLog(@"Open database failed");
        return;
    }
    BOOL delete=[_fmDB executeUpdate:@"delete from attendance where id = ?",[NSString stringWithFormat:@"%i",ID]];
    if (!delete) {
        NSLog(@"删除timetable失败,ID:%i",ID);
    }
    [_fmDB close];

}


@end
