//
//  PlainExample.m
//  PrettyExample
//
//  Created by Víctor on 22/03/12.
//  Copyright (c) 2012 Victor Pena Placer. All rights reserved.
//

#import "PlainExample.h"
#import "PrettyKit.h"


#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]

@implementation PlainExample

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) setUpShadows {
    [PrettyShadowPlainTableview setUpTableView:self.tableView];
}

- (void) customizeNavBar {
    PrettyNavigationBar *navBar = (PrettyNavigationBar *)self.navigationController.navigationBar;
    
    navBar.topLineColor = [UIColor colorWithHex:0xFF1000];
    navBar.gradientStartColor = [UIColor colorWithHex:0xDD0000];
    navBar.gradientEndColor = [UIColor colorWithHex:0xAA0000];    
    navBar.bottomLineColor = [UIColor colorWithHex:0x990000];   
    navBar.tintColor = navBar.gradientEndColor;
    navBar.roundedCornerRadius = 8;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"PrettyKit";
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:nil action:nil] autorelease];

    [self setUpShadows];
    [self customizeNavBar];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    float height = tableView.rowHeight;
    
    if (indexPath.row > 1 && indexPath.row < 6)
    {
        float imageWidth = 0;
        if (indexPath.row == 2)
        {
            imageWidth = 48;
        }
        height = [PrettyDrawnCell neededHeightForWidth:self.tableView.frame.size.width 
                                            imageWidth:imageWidth
                                                  text:@"This is a long text, maybe too long to fit on a single line" 
                                              textFont:[UIFont boldSystemFontOfSize:[UIFont labelFontSize]]
                                            detailText:@"And this is a long detail text, maybe too long to fit on a single line too" 
                                        detailTextFont:[UIFont systemFontOfSize:15]];
    }
    
    return height + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
}

- (PrettyDrawnCell *) drawnCellForTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DrawnCell";
    
    PrettyDrawnCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PrettyDrawnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.tableViewBackgroundColor = tableView.backgroundColor;        
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color;  
    }
    [cell prepareForTableView:tableView indexPath:indexPath];
    
    cell.prettyTextLabel.text = @"This is a long text, maybe too long to fit on a single line";
    cell.prettyDetailTextLabel.text = @"And this is a long detail text, maybe too long to fit on a single line too";

    return cell;
}

- (PrettyTableViewCell *) cellForTableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PrettyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PrettyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.tableViewBackgroundColor = tableView.backgroundColor;        
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color;  
    }
    [cell prepareForTableView:tableView indexPath:indexPath];

    cell.textLabel.text = @"Text";
    cell.textLabel.backgroundColor = [UIColor clearColor];

    
    return cell;
}

- (PrettyGridTableViewCell *) gridCellForTableView:(UITableView *)tableView forRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *GridCellIdentifier = @"GridCell";

    PrettyGridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GridCellIdentifier];
    if (cell == nil) {
        cell = [[[PrettyGridTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:GridCellIdentifier] autorelease];
        cell.tableViewBackgroundColor = tableView.backgroundColor;
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color;  
    }
    [cell prepareForTableView:tableView indexPath:indexPath];
    
    cell.numberOfElements = 2;
    [cell setActionBlock:^(NSIndexPath *indexPath, int selectedIndex) {
        [cell deselectAnimated:YES];
    }];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    [cell setText:@"Text 1" atIndex:0];
    [cell setText:@"Text 2" atIndex:1];
    [cell setDetailText:@"Subtitle" atIndex:0];
    [cell setDetailText:@"Subtitle" atIndex:1];

    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 1) 
    {
        cell = [self gridCellForTableView:tableView forRowAtIndexPath:indexPath];
    }
    
    else if (indexPath.row > 1 && indexPath.row < 6)
    {
        PrettyDrawnCell *drawn = [self drawnCellForTableView:tableView forIndexPath:indexPath];
        if (indexPath.row == 2) 
        {
            drawn.prettyImage = [UIImage imageNamed:@"background"];
            drawn.imageRadius = 8;
            drawn.imageShadow = YES;
        }
        else
        {
            drawn.prettyImage = nil;
        }
        return drawn;
    }
    
    else
    {
        cell = [self cellForTableView:tableView forRowAtIndexPath:indexPath];        
    }

    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
