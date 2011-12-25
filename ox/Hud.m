//
//  Hud.m
//  ox
//
//  Created by Gareth Stokes on 25/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "Hud.h"
#import "SpriteHelperLoader.h"
#import "HomeScene.h"

@implementation Hud

- (id) init
{
    if(!(self = [super init]))
	{
		NSLog(@"HUD: Failed to load");
		return self;
	}
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    [self setPosition:ccp(0, size.height - 25)];
    [self setContentSize:CGSizeMake(size.width, 25)];
    
    SpriteHelperLoader* loader = [[[SpriteHelperLoader alloc] initWithContentOfFile:@"hud"] autorelease];
    CCMenuItemImage *settings = [CCMenuItemImage 
                                 itemFromNormalSprite:[loader spriteWithUniqueName:@"pause_btn" 
                                                                        atPosition:ccp(0,0) 
                                                                           inLayer:nil] 
                                 selectedSprite:[loader spriteWithUniqueName:@"pause_press_btn" 
                                                                  atPosition:ccp(0,0) 
                                                                     inLayer:nil]
                                 target:self 
                                 selector:@selector(settings)];
    
    CCMenu *menu = [CCMenu menuWithItems: settings, nil];
    [menu setPosition:CGPointMake(30, 0)];
    [self addChild:menu];
    
    return self;
}

- (void) settings
{
    [[CCDirector sharedDirector] replaceScene:[HomeScene scene]];
}

- (CGRect) boundingBox
{
	CGRect ret = [self boundingBoxInPixels];
	return CC_RECT_PIXELS_TO_POINTS( ret );
}

- (CGRect) boundingBoxInPixels
{
    int width = contentSizeInPixels_.width;
    int height = contentSizeInPixels_.height;
	CGRect rect = CGRectMake((width /2) * -1, (height /2) * -1, width, height);
	return CGRectApplyAffineTransform(rect, [self nodeToParentTransform]);
}

- (void) draw
{
    CGRect rect = [self boundingBox];
    CGPoint vertices[4]={
        ccp(rect.origin.x,rect.origin.y),
        ccp(rect.origin.x+rect.size.width,rect.origin.y),
        ccp(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height),
        ccp(rect.origin.x,rect.origin.y+rect.size.height),
    };
    ccDrawPoly(vertices, 4, YES);
}

@end
