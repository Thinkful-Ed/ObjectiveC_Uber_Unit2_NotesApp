//
//  Notes.h
//  Notes
//
//  Created by Craig on 9/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class Note;
#import "Note.h"

@protocol NotesDelegate
-(void)updated;
@end

@interface Notes : NSObject<NoteDelegate>
@property (strong, nonatomic) NSMutableArray *notes;
@property (weak, nonatomic) id<NotesDelegate> delegate;

-(id)initWithNotes:(NSArray *)notes;
-(NSInteger)count;
-(Note *)getNoteAtIndex:(NSInteger)index;
-(void)addNote:(Note *)note;
-(void)deleteNoteAtIndex:(NSInteger)index;
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
