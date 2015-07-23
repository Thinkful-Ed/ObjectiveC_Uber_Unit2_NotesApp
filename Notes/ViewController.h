//
//  ViewController.h
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class Note;

@interface ViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>

-(id)initWithNote:(Note *)note;

@end

