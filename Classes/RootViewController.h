//
//  RootViewController.h
//  TableViewNav
//
//  Created by Chakra on 24/03/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UITableViewController {

	NSMutableArray *listDay;
	NSMutableData *responseData;
	NSMutableArray *appTable;
	NSMutableArray *storepoints;
	
}

@property (nonatomic, retain) NSMutableArray *appTable;
@property (nonatomic, retain) NSMutableArray *storepoints;

- (NSString *)flattenHTML:(NSString *)html;
-(void)CallJSON;
-(void)CallViewShow;		//Split out the call to load the second screen...and call it from the DataDidLoad...

@end
