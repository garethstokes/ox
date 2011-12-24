//
//  BackgroundLayer.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "BackgroundLayer.h"
#import "SpriteHelperLoader.h"

@implementation BackgroundLayer

- (id) init
{
    if(!(self = [super init]))
	{
		NSLog(@"BACKGROUND: Failed to load");
		return self;
	}
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    SpriteHelperLoader* loader = [[SpriteHelperLoader alloc] initWithContentOfFile:@"bg"];
    [loader spriteWithUniqueName:@"snowy_tundra" 
                      atPosition:ccp(screenSize.width /2, screenSize.height /2) 
                         inLayer:self];
    
    return self;
}

@end
