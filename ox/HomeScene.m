//
//  HomeScene.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "HomeScene.h"
#import "GameScene.h"

@interface HomeScreenLayer : CCLayer {
@private
    SpriteHelperLoader *_loader;
}

- (void) play;

@end

@implementation HomeScreenLayer

- (id) init
{
    // always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// enable touches
		self.isTouchEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		_loader = [[[SpriteHelperLoader alloc] initWithContentOfFile:@"home"] retain];
        [_loader spriteWithUniqueName:@"home_screen_bg" 
                          atPosition:ccp(screenSize.width /2, screenSize.height /2) 
                             inLayer:self];
        
        CCMenuItemImage *settings = [CCMenuItemImage 
                                  itemFromNormalSprite:[_loader spriteWithUniqueName:@"btn_options" 
                                                                          atPosition:ccp(-90,0) 
                                                                             inLayer:nil] 
                                  selectedSprite:[_loader spriteWithUniqueName:@"btn_options_down" 
                                                                    atPosition:ccp(-90,0) 
                                                                       inLayer:nil]
                                  target:self 
                                  selector:@selector(settings)];
        
        CCMenuItemImage *play = [CCMenuItemImage 
                                  itemFromNormalSprite:[_loader spriteWithUniqueName:@"btn_play" 
                                                                         atPosition:ccp(20,0) 
                                                                            inLayer:nil] 
                                  selectedSprite:[_loader spriteWithUniqueName:@"btn_play_down" 
                                                                   atPosition:ccp(20,0) 
                                                                      inLayer:nil]
                                  target:self 
                                  selector:@selector(play)];
        
        CCMenu *menu = [CCMenu menuWithItems: play, settings, nil];
        [menu setPosition:CGPointMake(270, 40)];
        [self addChild:menu];
         
	}
	return self;
}

- (void) settings
{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}

- (void) play
{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
}

- (void) dealloc
{
    NSLog(@"Dealloc GameScene");
    [_loader dealloc];
    _loader = nil;
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end

@implementation HomeScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    HomeScreenLayer *layer = [[HomeScreenLayer alloc] init];
    [scene addChild:layer];
    
	// return the scene
	return scene;
}

- (void) dealloc
{
    NSLog(@"Dealloc GameScene");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end


