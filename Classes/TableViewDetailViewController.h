//
//  TableViewDetailViewController.h
//  TableViewNav
//
//  Created by Chakra on 24/03/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableViewDetailViewController : UIViewController {
	
	IBOutlet UILabel *displayText;
	NSString *selectDay;
	
}

@property (nonatomic, retain) NSString *selectDay;

@end
