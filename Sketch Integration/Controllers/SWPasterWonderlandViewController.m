//
//  SWPasterWonderlandViewController.m
//  SketchWonderLand
//
//  Created by  on 12-3-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SWPasterWonderlandViewController.h"
#define degreesToRadians(x) (M_PI*(x)/180.0)

@implementation SWPasterWonderlandViewController
@synthesize backgroundImageView;
@synthesize pasterTemplate0;
@synthesize pasterTemplate1;
@synthesize pasterTemplate2;
@synthesize pasterTemplate3;
@synthesize pasterTemplate4;
@synthesize pasterTemplate5;
@synthesize pasterTemplate6;
@synthesize pasterTemplate7;
@synthesize pasterTemplate8;
@synthesize pasterTemplate9;
@synthesize pasterTemplate10;
@synthesize pasterTemplate11;
@synthesize returnButton;

@synthesize pasterViews;

@synthesize pasterTemplateLibrary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    NSLog(@"%@", self.view.superview);
    [super didReceiveMemoryWarning];
    NSLog(@"%@", self.view.superview);
//    [self.view removeFromSuperview];
    NSLog(@"ss");
    // Release any cached data, images, etc that aren't in use.
}


-(void)returnBack:(id)sender {
    RootViewController *rootViewController = [RootViewController sharedRootViewController];
    [rootViewController popViewController];
}

-(void)tapPasterImageView:(UIGestureRecognizer *) gestureRecognizer {
    RootViewController *rootViewController = [RootViewController sharedRootViewController];
    UIImageView *imageView = (UIImageView*)gestureRecognizer.view;
    NSUInteger index = 0;
    for (UIImageView *pasterView in pasterViews) {
        if ([imageView isEqual:pasterView]) {
            break;
        }
        index++;
    }
    PKPasterTemplate *pasterTemplate = [pasterTemplateLibrary.pasterTemplates objectAtIndex:index];
    PKPasterWork *pasterWork = [pasterTemplateLibrary.pasterWorks objectAtIndex:index];
    [rootViewController.drawViewController setPasterTemplate:pasterTemplate PasterWork:pasterWork];
    [rootViewController pushViewController:rootViewController.drawViewController];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化视图对象
    pasterViews =  [[NSMutableArray alloc] init];
    [pasterViews addObject:pasterTemplate0];
    [pasterViews addObject:pasterTemplate1];
    [pasterViews addObject:pasterTemplate2];
    [pasterViews addObject:pasterTemplate3];
    [pasterViews addObject:pasterTemplate4];
    [pasterViews addObject:pasterTemplate5];
    [pasterViews addObject:pasterTemplate6];
    [pasterViews addObject:pasterTemplate7];
    [pasterViews addObject:pasterTemplate8];
    [pasterViews addObject:pasterTemplate9];
    [pasterViews addObject:pasterTemplate10];
    [pasterViews addObject:pasterTemplate11];
    
    pasterTemplateLibrary = [[PKPasterTemplateLibrary alloc] initWithDataOfPlist];
    
    UIImageView *imageView;
    NSUInteger index = 0;
    for (PKPasterTemplate *pasterTemplate in pasterTemplateLibrary.pasterTemplates) {
        if (pasterTemplate.isModified) {
            PKPasterWork *pasterWork = [pasterTemplateLibrary.pasterWorks objectAtIndex:index];
            [[pasterViews objectAtIndex:index] addSubview:pasterWork.pasterView];
        } else {
            [[pasterViews objectAtIndex:index] addSubview:pasterTemplate.pasterView];
        }
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPasterImageView:)];
        imageView = [pasterViews objectAtIndex:index];
        [imageView setUserInteractionEnabled:YES];
        [imageView addGestureRecognizer:singleTap];
        index++;
        [singleTap release];
    }
    

//    for (int i = 0; i < 12; i++) {
//        UIImageView *imageView = [pasterTemplates objectAtIndex:i];
//        NSString *fileName = [[NSString alloc] initWithFormat:@"pasterTemplate%d.png", i];
//        [imageView setImage:[UIImage imageNamed:fileName]];
//        [fileName release];
//    }
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {

        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    } else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {

        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    }
}

@end