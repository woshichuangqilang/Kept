//
//  XZNoteModel.h
//  TimetableDB
//
//  Created by zxz on 15/12/13.
//  Copyright © 2015年 zxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZNoteModel : NSObject
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSString *courseNameID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *priority;
@property (nonatomic,copy) NSString *recordingTime;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *imageID;
@property (nonatomic,copy) NSString *soundRecording;
@property (nonatomic,copy) NSString *searchKeyword;

@end
