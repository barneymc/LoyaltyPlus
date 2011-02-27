//
//  RootViewController.m
//  TableViewNav
//
//  Created by Chakra on 24/03/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import "RootViewController.h"
#import "TableViewNavAppDelegate.h"
#import "TableViewDetailViewController.h"
#import "loyalty.h"
#import "JSON.h"


@implementation RootViewController
@synthesize appTable;
@synthesize storepoints;

//BMCA returns the array from the XML messed up JSON
- (NSString *)flattenHTML:(NSString *)html {
	
    NSScanner *theScanner;
    NSString *text = nil;
	NSString *start=@"org/""";
	NSString *end=@"</s";
	NSRange matchend;
	NSRange matchstart;
	
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
		
        // find start of tag
        [theScanner scanUpToString:start intoString:NULL] ; 
		// find end of tag
        [theScanner scanUpToString:end intoString:&text] ;
		
		matchstart=[html rangeOfString:start];
		matchend=[html rangeOfString:end];
        html = [html stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@>", text] withString:@" "];
		
    } // while //
	
	//6 characters to account for -org/"- and the first integer of the result
	text=[text substringWithRange:NSMakeRange(6, (matchend.location-(matchstart.location+6)))];
	
    return text;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {		
	[connection release];
	
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	[responseData release];
	
	responseString=[self flattenHTML:responseString];
	
	NSError *error;
	SBJSON *json = [[SBJSON new] autorelease];
	NSArray *luckyNumbers = [json objectWithString:responseString error:&error];
	
	NSMutableArray *_appTable=[[NSMutableArray alloc] initWithObjects:nil];
	NSMutableArray *_storepoints=[[NSMutableArray alloc] initWithObjects:nil];
	NSString *tmpString=nil;
	NSNumber *tmpPoints=nil;
	NSNumber *tmpConv;
	
	if (luckyNumbers == nil)
		error=nil;
	else {		
		//Fill the Array of Store Names.....
		for (NSString *element in luckyNumbers) {
			tmpString=[[NSString alloc] initWithString:[element objectForKey:@"StoreName"]];
			[_appTable addObject:tmpString];
			
			//[_storepoints addObject:tmpConv]; BMCA - simplify this
			[_storepoints addObject:[element objectForKey:@"Points"]];
		}		
	}
	
	self.storepoints=_storepoints;
	self.appTable =_appTable;
	
	//[tmpString release];
	[_appTable release];
	[_storepoints release];
	
	//BMCA Dont release.....
	//[responseString release];	//Dont release ResponseString....crashes....
	//Cos the table stuff is done first, after we load the data, we reload the table....
	//[[self table] reloadData];
	[self CallViewShow];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
}


-(void)CallJSON{
	
	responseData = [[NSMutableData data] retain];		
	//NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.unpossible.com/misc/lucky_numbers.json"]];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.handygrub.com/Service1.asmx/CustomersPointsDetail?customerID=1"]];
	
	[[NSURLConnection alloc] initWithRequest:request delegate:self];			
	
}

-(void)CallViewShow{
	
	//Only when the data response is loaded do we call the next viewcontroller
	loyalty *loyaltyViewController=[[loyalty alloc] initWithNibName:@"loyalty" bundle:nil];
	loyaltyViewController.tablePointsArray=self.appTable;
	loyaltyViewController.storePointsArray=self.storepoints;
	
	//loyaltyViewController.somearrayproperty
	[self.navigationController pushViewController:loyaltyViewController animated:YES];
	[loyaltyViewController release];
	loyaltyViewController=nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Initialize the array.
	listDay = [[NSMutableArray alloc] init];
	
	NSArray *lisyofday = [NSArray arrayWithObjects:@"Shops", @"Bars", @"Restaurants", @"Travel", @"Special", @"Food", @"Clothing",  nil];
	NSDictionary *lisyofdayDict = [NSDictionary dictionaryWithObject:lisyofday forKey:@"Days"];
	
	
	[listDay addObject:lisyofdayDict];
		
	//Set the title
	self.navigationItem.title = @"Loyalty+";
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
    return [listDay count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
	NSDictionary *dictionary = [listDay objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Days"];
	return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSDictionary *dictionary = [listDay objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"Days"];
	NSString *cellValue = [array objectAtIndex:indexPath.row];
	cell.text = cellValue;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	[self CallJSON];
	
	//NSDictionary *dictionary = [listDay objectAtIndex:indexPath.section];
	//NSArray *array = [dictionary objectForKey:@"Days"];
	//NSString *selectDay = [array objectAtIndex:indexPath.row];
	
	
	
	// Navigation logic may go here. Create and push another view controller.
	
	//********
	// TableViewDetailViewController *tableViewDetailViewController = [[TableViewDetailViewController alloc] initWithNibName:@"TableViewDetailViewController" bundle:nil];
	// tableViewDetailViewController.selectDay = selectDay;
	// [self.navigationController pushViewController: tableViewDetailViewController animated:YES];
	// [tableViewDetailViewController release];
	//tableViewDetailViewController = nil;
	
	
	
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

