//
//  SWDrawViewController.m
//  Sketch Integration
//
//  Created by 付 乙荷 on 12-4-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "SWDrawViewController.h"
#import "UIImageView+DeepCopy.h"

#define degreesToRadians(x) (M_PI*(x)/180.0)

@implementation SWDrawViewController

@synthesize pasterView;
@synthesize geoPasterBox;
@synthesize createPasterButton;
@synthesize geoPasters;
@synthesize pasterTemplate;
@synthesize pasterWork;
@synthesize drawBoard;
@synthesize geoPasterLibrary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        pasterView = [[UIImageView alloc] init];
        geoPasterLibrary = [[PKGeometryPasterLibrary alloc] initWithDataOfPlist];
        geoPasters = [[NSMutableArray alloc] initWithCapacity:geoPasterLibrary.geometryPasterTemplates.count];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)setPasterTemplate:(PKPasterTemplate *)tmpPasterTemplate PasterWork:(PKPasterWork *)tmpPasterWork Frame:(CGRect)frame
{
    self.pasterTemplate = tmpPasterTemplate;
    self.pasterWork = tmpPasterWork;
//    pasterView = [[UIImageView alloc]initWithFrame:frame];
    pasterView = [pasterWork.pasterView deepCopy];
    pasterView.frame = frame;
    
//    UIImageView* subView = [pasterWork.pasterView deepCopy];
//    subView.bounds = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height);
//    [pasterView addSubview:subView];

    [self.view addSubview:pasterView];
}

-(void)returnBack:(id)sender {
    RootViewController *rootViewController = [RootViewController sharedRootViewController];
    [rootViewController popViewController];
    UIImageView* skipImageView = [pasterView deepCopy];
    [rootViewController skipWithImageView:skipImageView Destination:rootViewController.pasterWonderlandViewController.selectedPosition Animation:EaseOut];
    [self cleanPasterView];
}

-(void)pressDrawAlbumButton:(id)sender {
    RootViewController *rootViewController = [RootViewController sharedRootViewController];
    [rootViewController pushViewController:[rootViewController drawAlbumViewController]];
    [self cleanPasterView];
}
//点击清空按钮
-(IBAction)pressCleanButton:(id)sender{
    promptDialogView.hidden = NO;
}
-(IBAction)pressComfirmButton:(id)sender{
    promptDialogView.hidden = YES;
//    drawBoard.drawCanvasView.view = nil;
    self.drawBoard.drawCanvas.drawCanvasView.image = nil;
}
-(IBAction)pressCancelButton:(id)sender{
    promptDialogView.hidden = YES;
}
//点击保存按钮
-(IBAction)pressSaveButton:(id)sender{
    //实现画作缩小移动，需修改UIImage为当前画作
    UIImageView *savedWork = [[UIImageView alloc] initWithFrame:CGRectMake(180.0f, 100.0f, 512.0f, 512.0f)];
//    [savedWork setImage:[UIImage imageNamed:@"backgroundImageViewDAV.png"]];
    savedWork.image = pasterView.image;
//    [savedWork setImage:];
    
    [UIImageView beginAnimations:nil context:NULL];
    [UIImageView setAnimationDuration:3];
    [UIImageView setAnimationBeginsFromCurrentState:YES];
    savedWork.frame = CGRectMake(0.0, 504.0, 0.0, 0.0);
    [UIImageView commitAnimations];
    [self.view addSubview:savedWork];
}

-(void)cleanPasterView 
{
    for (UIView *view in pasterView.subviews) 
    {
        [view removeFromSuperview];
    }
    [pasterView removeFromSuperview];
}
//涂色
//-(IBAction)buttonPressed:(id)sender{
//    UIImage *image=pasterView.image;
//    fillImage *fill=[[fillImage alloc]initWithImage:image];
//    struct ColorRGBAStruct tc={255,0,0,255};
//    struct ColorRGBAStruct bc={254,254,255,255};
//    int x=(int)xy.x;
//    int y=(int)xy.y;
//    if(x>=0&&y>=0&&x<image.size.width&&y<image.size.height){
//        [fill ScanLineSeedFill:x andY:y withTC:tc andBC:bc];
//        image=[fill getImage];
//        pasterView.image=image;
//        [fill release];
//    }
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UITouch* touch = [touches anyObject];
    //UIImageView* subImageView = [pasterView.subviews lastObject];
    xy = [touch locationInView:self.pasterView];
    printf("the click location is %f,%f",xy.x,xy.y);
    UIImage *image= pasterView.image;
    fillImage *fill=[[fillImage alloc]initWithImage:image];
    struct ColorRGBAStruct tc={255,0,0,255};
    struct ColorRGBAStruct bc={255,255,255,255};
    int x=(int)xy.x*image.size.width/pasterView.frame.size.width;
    int y=(int)xy.y*image.size.height/pasterView.frame.size.height;
    printf("the x is %d,the y is %d,the width is %f,the height is %f",x,y,image.size.width,image.size.height);
    if(x>=0&&y>=0&&x<image.size.width&&y<image.size.height){
        [fill ScanLineSeedFill:x andY:y withTC:tc andBC:bc];
        image=[fill getImage];
        pasterView.image=image;
        [fill release];
    }
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
//    drawBoard = [[DKDrawBoard alloc]init];
//    [self.view addSubview:drawBoard.drawCanvas.drawCanvasView];
//    
    [super viewDidLoad];
    
    NSUInteger index = 0;
    
    for (PKGeometryPaster *geoPaster in geoPasterLibrary.geometryPasters) {
//        [self.geoPasterBox addSubview:geoPaster.geoPasterImageView];
        UIImageView *imageView = [geoPaster.geoPasterImageView deepCopy];
        [geoPasters insertObject:imageView atIndex:index];
        [imageView release];
        [geoPasterBox addSubview:[geoPasters objectAtIndex:index]];
        index++;
    }
    
    //刚开始提示框不可见
    promptDialogView.hidden = YES;
    
//    [drawBoard.waterColorPen addObserver:self forKeyPath:@"state" options:NO|YES context:nil];
//    
//    //当isLikely的时候
//    if (drawBoard.isLikely) {
//        [self penStateChange];
//    }
}

//-(void)penStateChange{
//    [drawBoard.waterColorPen setValue:NO forKey:@"state"];
//}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
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

-(void)dealloc {
//    [super dealloc];
    //移除观察者
//    [drawBoard.waterColorPen removeObserver:self forKeyPath:@"state"];
    [pasterView release];
    [geoPasterLibrary release];
    [geoPasters release];
    [super dealloc];
}

@end
