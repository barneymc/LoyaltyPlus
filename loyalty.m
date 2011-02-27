//
//  RootViewController.m
//  TableViewNav
//
//  Created by Chakra on 24/03/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import "loyalty.h"
//#import "TableViewNavAppDelegate.h"
#import "TableViewDetailViewController.h"

@implementation loyalty

@synthesize imagesArray;
@synthesize tablePointsArray;
@synthesize storePointsArray;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIImage *active = [UIImage imageNamed:@"active.png"];
	UIImage *ae = [UIImage imageNamed:@"ae.png"];
	UIImage *audio = [UIImage imageNamed:@"audio.png"];
	UIImage *mobile = [UIImage imageNamed:@"mobile.png"];
	UIImage *net = [UIImage imageNamed:@"net.png"];
	UIImage *photo = [UIImage imageNamed:@"photo.png"];
	UIImage *psd = [UIImage	imageNamed:@"psd.png"];
	UIImage *vector = [UIImage imageNamed:@"vector.png"];
	
	NSArray *images = [[NSArray alloc] initWithObjects: active, ae, audio, mobile, net, photo, psd, vector, nil];
	self.imagesArray = images;
	[images release];
	
	self.navigationItem.title=@"Loyalty+";
	
	
	//Initialize the array.
	listDay = [[NSMutableArray alloc] init];
	
	NSArray *lisyofday = [NSArray arrayWithObjects:@"Sunday", @"MonDay", @"TuesDay", @"WednesDay", @"ThusDay", @"FriDay", @"SaturDay",  nil];
	NSDictionary *lisyofdayDict = [NSDictionary dictionaryWithObject:lisyofday forKey:@"Days"];
	
	
	[listDay addObject:lisyofdayDict];
	
	//Set the title
	self.navigationItem.title = @"Bars";
}




- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [listDay count];
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	//NSDictionary *dictionary = [listDay objectAtIndex:section];
    //NSArray *array = [dictionary objectForKey:@"Days"];
	//return [array count];
	return 5;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	//NSDictionary *dictionary = [listDay objectAtIndex:indexPath.section];
	//NSArray *array = [dictionary objectForKey:@"Days"];
	//NSString *cellValue = [array objectAtIndex:indexPath.row];
	//cell.text = cellValue;
	
	//return cell;
	NSUInteger row = [indexPath row];
	
	// Sets the text for the cell
	cell.textLabel.text = [self.tablePointsArray objectAtIndex:row];
	
	// Sets the imageview for the cell
	cell.imageView.image = [imagesArray objectAtIndex:row];
	
	// Sets the accessory for the cell
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Points : %i", [[self.storePointsArray objectAtIndex:row] intValue] ];
	//cell.detailTextLabel.text = @"Points";
	
	return cell;
	
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	//NSDictionary *dictionary = [listDay objectAtIndex:indexPath.section];
	//NSArray *array = [dictionary objectForKey:@"Days"];
	NSString *selectDay = [tablePointsArray objectAtIndex:indexPath.row];	//Name of the store
	
	
	
	// Navigation logic may go here. Create and push another view controller.
	TableViewDetailViewController *tableViewDetailViewController = [[TableViewDetailViewController alloc] initWithNibName:@"TableViewDetailViewController" bundle:nil];
	tableViewDetailViewController.selectDay = selectDay;
	tableViewDetailViewController.navigationItem.title=selectDay;
	
	[self.navigationController pushViewController: tableViewDetailViewController animated:YES];
	[tableViewDetailViewController release];
	tableViewDetailViewController = nil;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	//return UITableViewCellAccessoryDetailDisclosureButton;
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	
	[self tableView:tableView didSelectRowAtIndexPath:indexPath];
}




/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


- (void)dealloc {
    [super dealloc];
}


@end

