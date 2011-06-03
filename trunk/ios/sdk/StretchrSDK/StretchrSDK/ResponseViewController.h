//
//  ResponseViewController.h
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResponseViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UILabel *portraitHelpText;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;


- (void)addOutput:(NSString*)text;

- (void)setDoneButtonHidden:(BOOL)hidden;

- (IBAction)doneButtonPressed:(id)sender;

@end
