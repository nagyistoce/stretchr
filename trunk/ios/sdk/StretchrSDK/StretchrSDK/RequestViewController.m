//
//  RequestViewController.m
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "RequestViewController.h"


@implementation RequestViewController
@synthesize settingsView;
@synthesize scrollView;
@synthesize accountNameTextField, keyTextField, secretTextField, pathTextField;
@synthesize responseViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
  
  self.settingsView = nil;
  self.scrollView = nil;
  
  self.accountNameTextField = nil;
  self.keyTextField = nil;
  self.secretTextField = nil;
  self.pathTextField = nil;
  
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // set the background style
  [self.settingsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sky-stripe"]]];
  
  // put the settings view inside the scroll view
  [self.settingsView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.settingsView.frame))];
  [self.scrollView addSubview:self.settingsView];
  [self.scrollView setContentSize:self.settingsView.frame.size];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return YES;
}

#pragma mark - Validation

- (BOOL)validate {
  
  BOOL valid = YES;
  
  if (valid) valid = [self validateNotEmpty:self.accountNameTextField name:@"Account name"];
  if (valid) valid = [self validateNotEmpty:self.keyTextField name:@"Key"];
  if (valid) valid = [self validateNotEmpty:self.secretTextField name:@"Secret"];
  if (valid) valid = [self validateNotEmpty:self.pathTextField name:@"Path"];
  
  return valid;
  
}
- (BOOL)validateNotEmpty:(UITextField*)textField name:(NSString*)name {
  if ([textField.text isEqualToString:@""]) {
    [self showErrorMessage:[NSString stringWithFormat:@"%@ cannot be empty", name]];
    [textField becomeFirstResponder];
    return NO;
  }
  return YES;
}

#pragma mark - User interaction

- (void)showErrorMessage:(NSString*)message {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops, something's wrong" 
                                                  message:message 
                                                 delegate:nil 
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles:nil];
  [alert show];
  [alert release];
}

- (IBAction)makeRequestButtonTapped:(id)sender {
  
  if ([self validate]) {
    
    // do it...
    
  }
  
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  // move to the next text field
  
  
  return NO;
}

@end
