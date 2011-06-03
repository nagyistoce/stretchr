//
//  ResponseViewController.m
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "ResponseViewController.h"


@implementation ResponseViewController
@synthesize portraitHelpText;
@synthesize textView;
@synthesize toolbar;

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
  
  self.portraitHelpText = nil;
  self.textView = nil;
  self.toolbar = nil;
  
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
    // Do any additional setup after loading the view from its nib.
  
  [self didRotateFromInterfaceOrientation:UIInterfaceOrientationPortrait];
  
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
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:2];
  if (UIInterfaceOrientationIsLandscape([self interfaceOrientation])) {
    [self.portraitHelpText setAlpha:0];
  } else {
    [self.portraitHelpText setAlpha:1];
  }
  
  [UIView commitAnimations];
  
}

- (void)addOutput:(NSString*)text {
  
	NSDate *now = [NSDate date];
	NSDateFormatter *formatter = nil;
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"h:mm:ss"];

  text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
  
  [self addRawOutput:[NSString stringWithFormat:@"\n%@\t%@", [formatter stringFromDate:now], text]];
  
  [formatter release];

}

- (void)addRawOutput:(NSString*)text {
  
  [self.textView setText:[NSString stringWithFormat:@"%@%@", self.textView.text, text]];
    
  // make sure the textView is visible
  if (self.textView.hidden) {
    
    [self.textView setAlpha:0];
    [self.textView setHidden:NO];
    [self.toolbar setAlpha:0];
    [self.toolbar setHidden:NO];
    
    [UIView beginAnimations:nil context:nil];
    [self.textView setAlpha:1];
    [self.toolbar setAlpha:1];
    [UIView commitAnimations];
    
  }
  
}

- (void)setDoneButtonHidden:(BOOL)hidden {
  if (hidden) {
    // remove the done button
    
    NSMutableArray *items = [NSMutableArray arrayWithArray:self.toolbar.items];
    [items removeObjectAtIndex:0];
    
    [self.toolbar setItems:items];
    
  }
}

- (IBAction)doneButtonPressed:(id)sender {
  [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)clearButtonPressed:(id)sender {
  [self.textView setText:@""];
}

@end
