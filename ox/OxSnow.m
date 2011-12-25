//
//  OxSnow.m
//  ox
//
//  Created by Gareth Stokes on 25/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "OxSnow.h"

@implementation OxSnow

- (id) init
{
    if(!(self = [super init]))
	{
		NSLog(@"OXSNOW: Failed to load");
		return self;
	}
    
    CCParticleSnow *emitter = [CCParticleSnow node];
    [self addChild: emitter];
    
    CGPoint p = emitter.position;
    emitter.position = ccp( p.x, p.y);
    emitter.life = 3;
    emitter.lifeVar = 1;
    
    // gravity
    emitter.gravity = ccp(0,-10);
    
    // speed of particles
    emitter.speed = 130;
    emitter.speedVar = 30;
    
    
    ccColor4F startColor = emitter.startColor;
    startColor.r = 0.9f;
    startColor.g = 0.9f;
    startColor.b = 0.9f;
    emitter.startColor = startColor;
    
    ccColor4F startColorVar = emitter.startColorVar;
    startColorVar.b = 0.1f;
    emitter.startColorVar = startColorVar;
    
    emitter.emissionRate = emitter.totalParticles/emitter.life;
    emitter.texture = [[CCTextureCache sharedTextureCache] addImage: @"snow.png"];
    return self;
}

@end
