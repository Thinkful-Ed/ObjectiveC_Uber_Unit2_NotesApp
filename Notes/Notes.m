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
    return self;
}

@end
