//
//  KLAbsentManager.h
//  FunctionPage.1
//
//  Created by 康梁 on 15/12/15.
//  Copyright © 2015年 kl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@class FMResultSet;

@interface KLAbsentManager : NSObject

@property (nonatomic, assign) NSUInteger absentMax;

@property (nonatomic, assign) NSUInteger absentNum;

@property (nonatomic, assign) NSString *classID;
@property (nonatomic, assign) NSString *isAbsent;
@property (nonatomic, assign) NSString *absentTime;

+ (id)sharedStore;
- (FMDatabase *)allItems;
- (FMResultSet *)resultSet:(NSString *)classID;


- (void)insertClassID:(NSString *)classID AbsentMax:(NSUInteger)absentMax AbsentNum:(NSUInteger)absentNum isAbsent:(NSString *)isAbsent AbsentTime:(NSString *)absentTime;
- (void)updateAbsentMax:(NSUInteger)absentMax className:(NSString *)className;
- (void)updateAbsentNum:(NSUInteger)absentNum className:(NSString *)className;
@end
