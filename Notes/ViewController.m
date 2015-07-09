//
//  ViewController.m
//  Notes
//
//  Created by Craig on 4/07/2015.
//  Copyright (c) 2015 Thinkful. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Note.h"
#import "Model.h"

@interface ViewController ()
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *titleTextField;
@property (strong, nonatomic) UITextView *detailTextView;

@end

@implementation ViewController

CGFloat horizontalMargin = 20;
CGFloat verticalMargin = 20;
CGFloat horizontalSpace = 10;
CGFloat verticalSpace = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Instantiate objects
    self.saveButton = [UIButton new];
    self.titleLabel = [UILabel new];
    self.titleTextField = [UITextField new];
    self.detailTextView = [UITextView new];
    
    //Add to view
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleTextField];
    [self.view addSubview:self.detailTextView];
    
    //Customize saveButton
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton sizeToFit];
    [self.saveButton setTitleColor:[UIColor colorWithRed:1.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor colorWithRed:1.0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:0.5] forState:UIControlStateHighlighted];
    [self.saveButton addTarget:self action:@selector(tappedSave:) forControlEvents:UIControlEventTouchUpInside];
    
    //Customize titleTextField
    self.titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleTextField.delegate = self;
    
    //Customize titleLabel
    self.titleLabel.text = @"Title:";
    [self.titleLabel sizeToFit];
    
    //Customize detailTextView
    self.detailTextView.layer.borderWidth = 1.0;
    self.detailTextView.layer.borderColor = [[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    self.detailTextView.layer.cornerRadius = 5.0;
    
    //Set up Masonry constraints
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-horizontalMargin);
        make.top.equalTo(self.view.mas_top).offset(verticalMargin);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(horizontalMargin);
        make.baseline.equalTo(self.saveButton.mas_baseline);
    }];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).with.offset(horizontalSpace);
        make.right.equalTo(self.saveButton.mas_left).with.offset(-horizontalSpace);
        make.baseline.equalTo(self.saveButton.mas_baseline);
        make.width.greaterThanOrEqualTo(@10);
    }];
    [self.detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTextField.mas_bottom).with.offset(verticalSpace);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-verticalMargin);
        make.left.equalTo(self.view.mas_left).with.offset(horizontalMargin);
        make.right.equalTo(self.view.mas_right).with.offset(-horizontalMargin);
    }];
    
    //Load note
    Note *note = [[Model sharedModel] loadNote];
    self.titleTextField.text = note.title;
    self.detailTextView.text = note.detail;
}

#pragma mark: Saving
-(void) tappedSave:(UIButton*)sender {
    if (self.titleTextField.text.length > 0 && self.detailTextView.text.length > 0) {
        //We have data to save, let's save it!
        [self saveNote];
    } else {
        //No data to save!
        [self noDataToSave];
    }
}
-(void)saveNote {
    Note *note = [[Note alloc] initWithTitle:self.titleTextField.text detail:self.detailTextView.text];
    [[Model sharedModel] saveNote:note];
}
-(void)noDataToSave {
    NSString *wheresTheProblem;
    if (self.titleTextField.text.length == 0 && self.detailTextView.text.length == 0) {
        wheresTheProblem = @"title and note text fields";
    } else if (self.titleTextField.text.length == 0) {
        wheresTheProblem = @"title text field";
    } else {
        wheresTheProblem = @"note text field";
    }
    NSString *theProblem = [NSString stringWithFormat:@"A note can only be saved if there is text in the %@.",wheresTheProblem];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save problem"
                                                                   message:theProblem
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (self.titleTextField.text.length == 0) {
            [self.titleTextField becomeFirstResponder];
        } else {
            [self.detailTextView becomeFirstResponder];
        }
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark: NSNotifications
-(void)viewDidAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWasShown:(NSNotification*)notification {
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    [self.detailTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-keyboardHeight-verticalMargin);
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification {
    [self.detailTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-verticalMargin);
    }];
}

#pragma mark: UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.titleTextField) {
        [textField resignFirstResponder];
        [self.detailTextView becomeFirstResponder];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
