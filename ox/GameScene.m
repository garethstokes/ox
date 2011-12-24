//
//  GameScene.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "GameScene.h"
#import "BackgroundLayer.h"

@implementation GameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	//HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	//[scene addChild: layer];
	
    CCLayer *background = [[BackgroundLayer alloc] init];
    [scene addChild:background];
    
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
