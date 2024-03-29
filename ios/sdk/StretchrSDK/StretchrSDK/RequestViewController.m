//
//  RequestViewController.m
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "RequestViewController.h"
#import "StretchrSDK.h"

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
    if ([self.responseViewController.toolbar.items count] > 1)
      [self.responseViewController setDoneButtonHidden:YES];
  }
  
  // setup the context
  [[SRContext sharedInstance] setAccountName:self.accountNameTextField.text 
                                         key:self.keyTextField.text 
                                      secret:self.secretTextField.text];
  
  // create the resource
  SRResource *resource = [[SRResource alloc] initWithPath:self.pathTextField.text];
  
  // timestamp
  requestStarted = [[NSDate alloc] init];
  
  if (![self.IDTextField.text isEqualToString:@""]) {
    [resource setResourceId:self.IDTextField.text];
  }
  
  // set the parameters
  for (NSInteger tag = 6; tag < 25; tag += 2) {
    
    UITextField *field = (UITextField*)[self.view viewWithTag:tag];
    
    if (![field.text isEqualToString:@""]) {
      NSString *value = ((UITextField*)[self.view viewWithTag:tag+1]).text;
      [resource addParameterValue:value forKey:field.text];
    }
    
  }
  
  switch (self.methodSegmentedControl.selectedSegmentIndex) {
    case 0: // Create
      
      currentConnection = [resource createThenCallTarget:self selector:@selector(stretchrResponseReceived:) startImmediately:YES];
      
      break;
    case 1: // Read
      
      currentConnection = [resource readThenCallTarget:self selector:@selector(stretchrResponseReceived:) startImmediately:YES];
      
      break;
    case 2: // Update
      
      currentConnection = [resource updateThenCallTarget:self selector:@selector(stretchrResponseReceived:) startImmediately:YES];
      
      break;
    case 3: // Delete
      
      currentConnection = [resource deleteThenCallTarget:self selector:@selector(stretchrResponseReceived:) startImmediately:YES];
      
      break;
  }
  
  // write the details out
  [self writeConnectionDetailsToResponseViewController:currentConnection];
  
}

- (void)writeConnectionDetailsToResponseViewController:(SRConnection*)connection {
  
  NSURLRequest *underlyingRequest = [connection request];
  
  NSString *paramString = @"";
  
  // TODO: write parameters
  for (SRParameter *param in connection.originalRequest.parameters.parameters) {
    paramString = [NSString stringWithFormat:@"%@\n  %@: \"%@\"", paramString, param.key, param.value];
  }
  
  // security details
  NSString *contextDetails = [NSString stringWithFormat:@"Account name: %@\nKey: %@\nSecret: %@\n\nParameters:%@\n", [[SRContext sharedInstance] accountName], [[SRContext sharedInstance] credentials].key, [[SRContext sharedInstance] credentials].secret, paramString];
  [self.responseViewController addOutput:contextDetails];
  
  // write the signature base string (for debugging purposes)
  SRRequestSigner *signer = [[SRRequestSigner alloc] init];
  [self.responseViewController addOutput:[NSString stringWithFormat:@"Pre-signed: %@", [signer unencodedSignatureStringForRequest:connection.originalRequest]]];
  [signer release];
  
  // request details
  NSString *requestDescription = [NSString stringWithFormat:@"%@ %@", underlyingRequest.HTTPMethod, [underlyingRequest.URL absoluteString]];
  [self.responseViewController addOutput:requestDescription];
  
}

- (void)writeResponseDetailsToResponseViewController:(SRResponse*)response {

  NSTimeInterval timeTaken = [requestStarted timeIntervalSinceNow];
  
  [requestStarted release];
  requestStarted = nil;
  
  [self.responseViewController addOutput:@""];
  [self.responseViewController addOutput:[NSString stringWithFormat:@"Response: %d", [response.urlResponse statusCode]]];
  [self.responseViewController addOutput:[NSString stringWithFormat:@"Request took: %f seconds.", 0 - timeTaken]];
  
  // write headers
  [self.responseViewController addRawOutput:@"\nHeaders: "];
  [self.responseViewController addRawOutput:[response.urlResponse.allHeaderFields description]];
  
  // write the raw output
  [self.responseViewController addOutput:@"-- Body --"];
  
  NSLog(@"%@", response.data);
  
  NSString *responseText = [[NSString alloc] initWithBytes:[response.data bytes] length:[response.data length] encoding:NSUTF8StringEncoding];
  [self.responseViewController addRawOutput:[NSString stringWithFormat:@"\n%@", responseText]];
  
  [self.responseViewController addOutput:@"-- End of Body --"];
  
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
  
  // finished
  currentConnection = nil;
  
  [self hideBusy];
  
  [self writeResponseDetailsToResponseViewController:response];
  
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

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  
  // cancel request
  if (currentConnection) {
    [currentConnection cancel];
  }
  
}

@end
