//
//  RequestViewController.h
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RequestViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UIView *settingsView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) IBOutlet UITextField *accountNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *keyTextField;
@property (nonatomic, retain) IBOutlet UITextField *secretTextField;
@property (nonatomic, retain) IBOutlet UITextField *pathTextField;

#pragma mark - Validation

- (BOOL)validate;
- (BOOL)validateNotEmpty:(UITextField*)textField name:(NSString*)name;

#pragma mark - User interaction

- (void)showErrorMessage:(NSString*)message;
- (IBAction)makeRequestButtonTapped:(id)sender;

@end
