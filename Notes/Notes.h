//
//  Notes.h
//  Notes
//
//  Created by Craig on 9/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;

@interface Notes : NSObject
@property (strong, nonatomic) NSMutableArray *notes;

-(id)initWithNotes:(NSArray *)notes;
-(NSInteger)count;
-(Note *)getNoteAtIndex:(NSInteger)index;
-(void)addNote:(Note *)note;
-(Note *)deleteNoteAtIndex:(NSInteger)index;
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
