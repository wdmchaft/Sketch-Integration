//
//  RootViewController.h
//  Button Fun
//
//  Created by 付 乙荷 on 12-4-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWDrawViewController;
@class SWNavigationViewController;
@class SWPasterWonderlandViewController;
@class SWHelpViewController;
@class SWDrawAlbumViewController;

#import "SWPasterWonderlandViewController.h"
#import "SWNavigationViewController.h"
#import "SWDrawViewController.h"
#import "SWDrawAlbumViewController.h"
#import "SWHelpViewController.h"

@interface RootViewController : UIViewController {
    NSMutableArray *viewControllersStack;
    SWNavigationViewController *navigationViewController;
    SWPasterWonderlandViewController *pasterWonderlandViewController;
    SWDrawViewController *drawViewController;
    SWDrawAlbumViewController *drawAlbumViewController;
    SWHelpViewController *helpViewController;
    
    //记录当前的和后一个的视图控制器
    UIViewController *currentViewController;
    UIViewController *nextViewController;
}

//Singleton method
+(RootViewController *)sharedRootViewController;

@property (retain, nonatomic) NSMutableArray *viewControllersStack;
@property (retain, nonatomic) SWNavigationViewController *navigationViewController;
@property (retain, nonatomic) SWPasterWonderlandViewController *pasterWonderlandViewController;
@property (retain, nonatomic) SWDrawViewController *drawViewController;
@property (retain, nonatomic) SWDrawAlbumViewController *drawAlbumViewController;
@property (retain, nonatomic) SWHelpViewController *helpViewController;
@property (retain, nonatomic) UIViewController *currentViewController;
@property (retain, nonatomic) UIViewController *nextViewController;

-(void)display;
-(void)runWithViewController:(UIViewController*) viewController;
-(void)pushViewController:(UIViewController*) viewController;


@end
