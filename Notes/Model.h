//
//  Model.h
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Notes;

@interface Model: NSObject
+ (Model *)sharedModel;
//-(void)saveNote:(Note *)note;
//-(Note *)loadNote;
@property (copy, nonatomic) Notes *notes;
-(void)saveNotes;
@end