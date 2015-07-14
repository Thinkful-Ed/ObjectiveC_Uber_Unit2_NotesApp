//
//  Note.h
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NoteDelegate
-(void)updated;
@end

@interface Note : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (weak, nonatomic) id<NoteDelegate> delegate;

-(id)initWithTitle:(NSString *)title detail:(NSString *)detail;
-(void)setTitle:(NSString *)title detail:(NSString *)detail;
-(BOOL)isBlank;
@end
