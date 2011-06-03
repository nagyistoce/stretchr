//
//  RequestViewController.h
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StretchrSDK.h"
#import "ResponseViewController.h"

@interface RequestViewController : UIViewController <UITextFieldDelegate> {
  UITextField *activeField;
  ResponseViewController *responseViewController_;
  BOOL responseViewControllerNotHomeGrown;
}

@property (nonatomic, retain) IBOutlet UIView *settingsView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *accountNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *keyTextField;
@property (nonatomic, retain) IBOutlet UITextField *secretTextField;
@property (nonatomic, retain) IBOutlet UITextField *pathTextField;
@property (nonatomic, retain) IBOutlet UITextField *IDTextField;
@property (nonatomic, retain) IBOutlet UISegmentedControl *methodSegmentedControl;

@property (nonatomic, retain) ResponseViewController *responseViewController;

@property (nonatomic, retain) UIAlertView *busyAlertView;

#pragma mark - Validation

- (BOOL)validate;
- (BOOL)validateNotEmpty:(UITextField*)textField name:(NSString*)name;

#pragma mark - User interaction

- (void)showErrorMessage:(NSString*)message;
- (IBAction)makeRequestButtonTapped:(id)sender;

#pragma mark - Work

- (void)makeRequest;
- (void)writeConnectionDetailsToResponseViewController:(SRConnection*)connection;
- (void)showBusy;
- (void)hideBusy;
- (void)stretchrResponseReceived:(SRResponse*)response;

@end
