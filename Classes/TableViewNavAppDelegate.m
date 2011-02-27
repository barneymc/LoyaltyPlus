//
//  TableViewNavAppDelegate.m
//  TableViewNav
//
//  Created by Chakra on 24/03/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

#import "TableViewNavAppDelegate.h"
#import "RootViewController.h"

@implementation TableViewNavAppDelegate

@synthesize window , navigationController,myRootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
   
	
	//RootViewController *locRootView=[[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
	//self.myRootViewController=locRootView;
	//[locRootView release];
	
	//UINavigationController *myNavCont=[[UINavigationController alloc] initWithRootViewController:self.myRootViewController];
	//navigationController.view.frame=CGRectMake(0, 0, 320, 431);
	
	//self.navigationController=myNavCont;
	//[myNavCont release];
	
	//[window setRootViewController:self.myRootViewController];
//[window addSubview:self.myRootViewController.view];
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
	
}

- (void)dealloc {
    [window release];
	[navigationController release];
    [super dealloc];
}


@end
