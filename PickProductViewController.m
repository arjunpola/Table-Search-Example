//
//  PickProductViewController.m
//  TableSearch
//
//  Created by jmatchett on 05/19/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PickProductViewController.h"
#import "Product.h"

@implementation PickProductViewController

@synthesize productPickerButton, pickedProductLabel, controllerChoice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [productPickerButton release];
    [pickedProductLabel release];
    [controllerChoice release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pickedProductLabel.text = @"no product picked";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.productPickerButton = nil;
    self.pickedProductLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)showProductPicker:(id)sender {
	NSArray *listContent = [NSArray arrayWithObjects:
						 [Product productWithType:@"Device" name:@"iPhone"],
						 [Product productWithType:@"Device" name:@"iPod"],
						 [Product productWithType:@"Device" name:@"iPod touch"],
						 [Product productWithType:@"Desktop" name:@"iMac"],
						 [Product productWithType:@"Desktop" name:@"Mac Pro"],
						 [Product productWithType:@"Portable" name:@"iBook"],
						 [Product productWithType:@"Portable" name:@"MacBook"],
						 [Product productWithType:@"Portable" name:@"MacBook Pro"],
						 [Product productWithType:@"Portable" name:@"PowerBook"], nil];

    // use view controller with interface builder defined seach display controller
    if (controllerChoice.selectedSegmentIndex == 0) {
        MainViewController *mvc = [[MainViewController alloc] initWithNibName: @"MainView" bundle: nil];
        mvc.listContent = listContent;
        mvc.delegate = self;
        NSLog(@"MainViewController desc: %@", [mvc description]);
        [self presentModalViewController: mvc animated: YES];
        [mvc release];
    }
    // use view controller with programmatically defined search display controller
    else {
        MainViewController2 *mvc = [[MainViewController2 alloc] initWithNibName: @"MainViewController2" bundle: nil];
        mvc.listContent = listContent;
        mvc.delegate = self;
        NSLog(@"MainViewController2 desc: %@", [mvc description]);
        [self presentModalViewController: mvc animated: YES];
        [mvc release];
    }
}

#pragma mark - ProductPickerDelegate method
-(void)productWasPicked:(Product*)product {
    if (product)
        self.pickedProductLabel.text = [NSString stringWithFormat: @"%@ - %@", product.type, product.name];
    [self dismissModalViewControllerAnimated: YES];
}

@end
