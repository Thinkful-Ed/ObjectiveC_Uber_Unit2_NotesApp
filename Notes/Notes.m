//
//  Notes.m
//  Notes
//
//  Created by Craig on 9/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "Notes.h"

@implementation Notes

-(id)initWithNotes:(NSArray *)notes {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.notes = [notes mutableCopy];
    for (Note *note in notes) {
        note.delegate = self;
    }
    return self;
}
-(NSInteger)count {
    return self.notes.count;
}
-(void)addNote:(Note *)note {
    [self.notes addObject:note];
    [self.delegate updated];
}
-(Note *)getNoteAtIndex:(NSInteger)index {
    return self.notes[index];
}

-(void)deleteNoteAtIndex:(NSInteger)index {
    [self deleteNoteAtIndexNoUpdate:index];
    [self.delegate updated];
}
//add new method to handle not updating (when called from 'moveFromIndex'
-(Note *)deleteNoteAtIndexNoUpdate:(NSInteger)index {
    Note *noteToDelete = self.notes[index];
    [self.notes removeObjectAtIndex: index];
    return (noteToDelete);
}
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    Note *noteToMove = [self deleteNoteAtIndexNoUpdate:fromIndex];
    [self.notes insertObject:noteToMove atIndex:toIndex];
    [self.delegate updated];
}

#pragma mark - NoteDelegate
-(void)updated {
    [self.delegate updated];
}
@end
