//
//  TableViewNavAppDelegate.h
//  TableViewNav
//
//  Created by Chakra on 24/03/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

//*******************
//BMCA Version 1.0
//*******************


#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface TableViewNavAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
	RootViewController *myRootViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) RootViewController *myRootViewController;

@end

