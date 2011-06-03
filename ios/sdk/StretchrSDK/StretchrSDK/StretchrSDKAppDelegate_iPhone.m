//
//  StretchrSDKAppDelegate_iPhone.m
//  StretchrSDK
//
//  Created by Mat Ryer on 3/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrSDKAppDelegate_iPhone.h"
#import "RequestViewController.h"

@implementation StretchrSDKAppDelegate_iPhone

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  // iPhone
  RequestViewController *vc = [[RequestViewController alloc] initWithNibName:@"RequestViewController" bundle:nil];
  [self.window setRootViewController:vc];
  [vc release];
  
  [self.window makeKeyAndVisible];
  return YES;
}

@end
