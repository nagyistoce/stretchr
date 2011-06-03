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
@synthesize accountNameTextField, keyTextField, secretTextField, pathTextField, IDTextField;
@synthesize methodSegmentedControl;
@synthesize responseViewController = responseViewController_;
@synthesize busyAlertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  
  if (activeField) {
    [activeField resignFirstResponder];
    activeField = nil;
  }
  
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
  
  if (activeField) {
    [activeField resignFirstResponder];
    activeField = nil;
  }
  
  if ([self validate]) {
    [self makeRequest];
  }
  
}

- (void)makeRequest {
  
  [self showBusy];
  
  // hide the done button if we're on iPad
  if (responseViewControllerNotHomeGrown) {
    [self.responseViewController setDoneButtonHidden:YES];
  }
  
  // setup the context
  [[SRContext sharedInstance] setAccountName:self.accountNameTextField.text 
                                         key:self.keyTextField.text 
                                      secret:self.secretTextField.text];
  
  // create the resource
  SRResource *resource = [[SRResource alloc] initWithPath:self.pathTextField.text];
  
  if (![self.IDTextField.text isEqualToString:@""]) {
    [resource setResourceId:self.IDTextField.text];
  }
  
  switch (self.methodSegmentedControl.selectedSegmentIndex) {
    case 0: // Create
      
      break;
    case 1: // Read
      
      [self writeConnectionDetailsToResponseViewController:[resource readThenCallTarget:self selector:@selector(stretchrResponseReceived:) startImmediately:YES]];
      
      break;
    case 2: // Update
      
      break;
    case 3: // Delete
      
      break;
  }
  
}

- (void)writeConnectionDetailsToResponseViewController:(SRConnection*)connection {
  
  NSURLRequest *underlyingRequest = [connection request];
  NSString *requestDescription = [NSString stringWithFormat:@"%@ %@", underlyingRequest.HTTPMethod, [underlyingRequest.URL absoluteString]];
  
  [self.responseViewController addOutput:requestDescription];
  
}

- (void)showBusy {
  
  if (!self.busyAlertView) {
  
    // show the busy indicator
    UIAlertView *aBusyAlertView = [[UIAlertView alloc] initWithTitle:@"Making request" message:@"\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    
    UIActivityIndicatorView *aBusyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [aBusyView setHidesWhenStopped:YES];
    [aBusyView setCenter:CGPointMake(145,80)];
    
    [aBusyAlertView addSubview:aBusyView];
    [aBusyView startAnimating];
    [aBusyView release];
    
    self.busyAlertView = aBusyAlertView;
    [aBusyAlertView release];
    
  }
    
  [self.busyAlertView show];
  
}

- (void)hideBusy {
  
  [self.busyAlertView dismissWithClickedButtonIndex:0 animated:YES];
  
}

- (void)stretchrResponseReceived:(SRResponse*)response {
  
  NSLog(@"Response received");
  
  [self hideBusy];
  
}

- (ResponseViewController*)responseViewController {
  
  if (!responseViewController_) {
    
    ResponseViewController *aResponseViewController = [[ResponseViewController alloc] initWithNibName:@"ResponseViewController" bundle:nil];
    self.responseViewController = aResponseViewController;
    [aResponseViewController release];
    
    [self presentModalViewController:self.responseViewController animated:YES];
    
  }
  
  return responseViewController_;
  
}
- (void)setResponseViewController:(ResponseViewController *)responseViewController {
  
  [responseViewController_ release];
  responseViewController_ = responseViewController;
  [responseViewController_ retain];
  
  responseViewControllerNotHomeGrown = YES;
  
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  // move to the next text field
  UIView *nextField = [self.view viewWithTag:textField.tag + 1];
  
  if (!nextField) {
    [textField resignFirstResponder];
  } else {
    [nextField becomeFirstResponder];
  }
  
  return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  activeField = nil;
}

#pragma mark - Keyboard management

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWasShown:)
                                               name:UIKeyboardDidShowNotification object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification object:nil];
  
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  UIEdgeInsets contentInsets;
  
  if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
    contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.width, 0.0);
  } else {
    contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
  }
  
  [UIView beginAnimations:nil context:nil];
  scrollView.contentInset = contentInsets;
  scrollView.scrollIndicatorInsets = contentInsets;
  [UIView commitAnimations];
  
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  
  [UIView beginAnimations:nil context:nil];
  scrollView.contentInset = contentInsets;
  scrollView.scrollIndicatorInsets = contentInsets;
  [UIView commitAnimations];
  
}

@end
