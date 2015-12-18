//
//  KLReviseStore.m
//  KLRevise
//
//  Created by 康梁 on 15/12/17.
//  Copyright © 2015年 kl. All rights reserved.
//

#import "KLReviseStore.h"

@interface KLReviseStore ()

@property (strong, nonatomic) NSMutableArray *privateItem;
@property (strong, nonatomic) NSMutableDictionary *dictionary;


@end

@implementation KLReviseStore

+ (instancetype)sharedStore {
    static KLReviseStore *revise = nil;
    if (!revise) {
        revise = [[self alloc] initPrivate];
    }
    return revise;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[KLReviseStore sharedStore]"
                                 userInfo:nil];
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.privateItem = [[NSMutableArray alloc] init];
        
        if (![self allItems]) {
            [self savaChanges];
        }
    }
    return self;
}


- (void)addNote:(UIViewController *)viewController forNoteID:(NSString *)noteID
{
    self.dictionary[noteID] = viewController;
    
    [self.privateItem addObject:self.dictionary[noteID]];
    
    [self.privateItem writeToFile:[self itemArchivePath] atomically:NO];
    
}

- (void)deleteNoteForNoteID:(NSString *)noteID
{
    [self allItems];
    [self.privateItem removeObject:self.dictionary[noteID]];
    [self.privateItem writeToFile:[self itemArchivePath] atomically:NO];
}


- (NSMutableArray *)allItems {
    self.privateItem = [[NSMutableArray alloc] initWithContentsOfFile:[self itemArchivePath]];
    return [self.privateItem copy];
}

#pragma mark 固化-----------------------------------------------------

- (NSString *)itemArchivePath {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [array firstObject];
    NSLog(@"%@", documentDirectory);
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)savaChanges {
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:self.privateItem
                                       toFile:path];
}








@end
