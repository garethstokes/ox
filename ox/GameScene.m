//
//  GameScene.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "GameScene.h"
#import "BackgroundLayer.h"
#import "GameLayer.h"

@implementation GameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    CCLayer *game = [[GameLayer alloc] init];
    [scene addChild:game z:50];
	
    CCLayer *background = [[BackgroundLayer alloc] init];
    [scene addChild:background z:1];
    
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
