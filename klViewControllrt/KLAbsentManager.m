//
//  KLAbsentManager.m
//  FunctionPage.1
//
//  Created by 康梁 on 15/12/15.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLAbsentManager.h"
#import "FMDatabase.h"



@interface KLAbsentManager ()

@property (strong, nonatomic) NSMutableArray *privateArray;
@property (strong, nonatomic) FMDatabase *db;

@end

@implementation KLAbsentManager

+ (id)sharedStore {
    static KLAbsentManager *absentStore = nil;
    if (!absentStore) {
        absentStore = [[self alloc] initPrivate];
    }
    return absentStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"USE +[KLAbsentManager sharedStore]"
                                 userInfo:nil];
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        self.privateArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)databasePath {
    // 1.获取数据库文件路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"absent.sqlite"];
    return fileName;
}


- (void)createTable {
    // 2. 获取数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
    
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
    
    [db close];
    
    self.db = db;
   
}


- (FMDatabase *)allItems {
    return [self.privateArray copy];
}

- (FMResultSet *)resultSet:(NSString *)classID
{
    FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
    self.db = db;
    if (![self.db open]) {
        [self createTable];
    }
    FMResultSet *rs = [self.db executeQuery:@"SELECT * FROM AbsentList where ClassName = ?", classID];
    while ([rs next]) {
        self.absentMax = [rs intForColumn:@"AbsentMax"];
        self.absentNum = [rs intForColumn:@"AbsentNum"];
        self.classID = [rs stringForColumn:@"ClassName"];
        self.isAbsent = [rs stringForColumn:@"isAbsent"];
    }
    [rs close];
    [self.db close];
    
//    [self.privateArray addObject:[NSNumber numberWithUnsignedInteger:self.absentMax]];
//    [self.privateArray addObject:[NSNumber numberWithUnsignedInteger:self.absentNum]];
//    [self.privateArray addObject:self.classID];
    // [self.privateArray addObject:self.isAbsent];
    
    return rs;
}

#pragma mark - 插入、更新方法

- (void)insertClassID:(NSString *)classID AbsentMax:(NSUInteger)absentMax AbsentNum:(NSUInteger)absentNum isAbsent:(NSString *)isAbsent AbsentTime:(NSString *)absentTime
{
    FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
    self.db = db;
    if ([self.db open]) {
        [self.db executeUpdate:@"INSERT INTO AbsentList (ClassName, AbsentMax, AbsentNum, isAbsent, AbsentTime) VALUES (?,?,?,?,?)", classID, [NSNumber numberWithUnsignedInteger:absentMax], [NSNumber numberWithUnsignedInteger:absentNum], isAbsent, absentTime];
    } else {
        return;
    }
}

- (void)updateAbsentMax:(NSUInteger)absentMax className:(NSString *)className {
    FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
    self.db = db;
    if ([self.db open]) {
        [self.db executeUpdate:@"UPDATE AbsentList SET AbsentMax = ? WHERE ClassName = ?;", [NSNumber numberWithUnsignedInteger:absentMax], className];
    } else {
        return;
    }
    [self.db close];
    
}

- (void)updateAbsentNum:(NSUInteger)absentNum className:(NSString *)className {
    FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
    self.db = db;
    if ([self.db open]) {
        [self.db executeUpdate:@"UPDATE AbsentList SET AbsentNum = ?;", [NSNumber numberWithUnsignedInteger:absentNum], className];
    } else {
        return;
    }
    [self.db close];
    
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

@end
