//
//  Note.m
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "Note.h"

@implementation Note

//init Note - coordinate defaults to 0,0 initially
-(id)initWithTitle:(NSString *)title detail:(NSString *)detail {
    self = [super init];
    if (!self) {
        return nil; //something went wrong!
    }
    self.title = title;
    self.detail = detail;
    self.coordinate = CLLocationCoordinate2DMake(0, 0);
    return self;
}
//returns if note is blank
-(BOOL)isBlank {
    return !(self.title && self.title.length>0 && self.detail && self.detail.length>0);
}
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.detail    forKey:@"detail"];
    [coder encodeDouble:self.coordinate.latitude    forKey:@"latitude"];
    [coder encodeDouble:self.coordinate.longitude    forKey:@"longitude"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    self.title = [coder decodeObjectForKey:@"title"];
    self.detail    = [coder decodeObjectForKey:@"detail"];
    self.coordinate = CLLocationCoordinate2DMake([coder decodeDoubleForKey:@"latitude"], [coder decodeDoubleForKey:@"longitude"]);
    return self;
}

//
-(void)setTitle:(NSString *)title detail:(NSString *)detail {
    _title = title;
    _detail = detail;
    [self.delegate updated];
}
@end
