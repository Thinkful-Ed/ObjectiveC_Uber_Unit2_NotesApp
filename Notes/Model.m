//
//  Model.m
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "Model.h"
#import "Note.h"
#import "Notes.h"

@implementation Model
+ (Model *)sharedModel
{
    static Model* modelSingleton = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        modelSingleton = [[Model alloc] init];
    });
    return modelSingleton;
}
-(Notes *)notes {
    if (!_notes) {
        _notes = [[Notes alloc] initWithNotes:[self loadNotes]];
        _notes.delegate = [Model sharedModel];
    }
    return _notes;
}
//Archive notes
-(void)saveNotes {
    NSLog(@"Saving");
    [NSKeyedArchiver archiveRootObject:self.notes.notes toFile:[self filePath]];
}
//Unarchive notes
-(NSArray *)loadNotes {
    NSArray *notesArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePath]];
    if (!notesArray) {
        notesArray = @[];
    }
    return(notesArray);
}
-(NSString *)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return ([documentsDirectoryPath stringByAppendingPathComponent:@"noteData2"]);
}
#pragma mark - NotesDelegate
-(void)updated {
    [self saveNotes];
}
@end
