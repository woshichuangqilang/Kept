//
//  KLReviseStore.h
//  KLRevise
//
//  Created by 康梁 on 15/12/17.
//  Copyright © 2015年 kl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KLReviseStore : NSObject



+ (instancetype)sharedStore;
- (instancetype)initPrivate;
- (NSMutableArray *)allItems;

- (void)addNote:(UIViewController *)viewController forNoteID:(NSString *)noteID;
- (void)deleteNoteForNoteID:(NSString *)noteID;


@end
