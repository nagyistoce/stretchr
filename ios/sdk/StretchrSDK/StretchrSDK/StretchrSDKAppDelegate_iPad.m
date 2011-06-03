//
//  StretchrSDKAppDelegate_iPad.m
//  StretchrSDK
//
//  Created by Mat Ryer on 3/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrSDKAppDelegate_iPad.h"
#import "RequestViewController.h"
#import "ResponseViewController.h"

@implementation StretchrSDKAppDelegate_iPad

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  RequestViewController *requestViewController = [[RequestViewController alloc] initWithNibName:@"RequestViewController" bundle:nil];
  ResponseViewController *responseViewController = [[ResponseViewController alloc] initWithNibName:@"ResponseViewController" bundle:nil];
  
  // give the request view controller a ref to the response one (since they both exist on iPad)
  [requestViewController setResponseViewController:responseViewController];
    
  UISplitViewController *splitViewController = [[UISplitViewController alloc] initWithNibName:nil bundle:nil];
  [splitViewController setViewControllers:[NSArray arrayWithObjects:requestViewController, responseViewController, nil]];
  
  [self.window setRootViewController:splitViewController];
  
  [splitViewController release];
  [requestViewController release];
  [responseViewController release];
  
  [self.window makeKeyAndVisible];
  return YES;
}

@end
