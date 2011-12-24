//
//  AppDelegate.h
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright digital five 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
