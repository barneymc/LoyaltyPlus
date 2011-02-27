//
//  loyalty.h
//  TableViewNav
//
//  Created by Joe Bloggs on 26/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface loyalty : UITableViewController {
	NSMutableArray *listDay;
	NSArray *imagesArray;
	NSMutableArray *tablePointsArray;
	NSMutableArray *storePointsArray;
	
}

@property (nonatomic, retain) NSArray *imagesArray;
@property (nonatomic, retain) NSMutableArray *tablePointsArray;
@property (nonatomic, retain) NSMutableArray *storePointsArray;

@end
