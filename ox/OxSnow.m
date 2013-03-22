//
//  OxSnow.m
//  ox
//
//  Created by Gareth Stokes on 25/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "OxSnow.h"

@implementation OxSnow
@synthesize intensity = _intensity;

- (id) init
{
    if(!(self = [super init]))
	{
		NSLog(@"OXSNOW: Failed to load");
		return self;
	}
    
    _emitter = [CCParticleSnow node];
    [self addChild: _emitter];
    
    CGPoint p = _emitter.position;
    _emitter.position = ccp( p.x, p.y);
    _emitter.life = 3;
    _emitter.lifeVar = 1;
    
    // gravity
    _emitter.gravity = ccp(0,-10);
    
    // speed of particles
    _emitter.speed = 130;
    _emitter.speedVar = 30;
    
    ccColor4F startColor = _emitter.startColor;
    startColor.r = 0.9f;
    startColor.g = 0.9f;
    startColor.b = 0.9f;
    _emitter.startColor = startColor;
    
    ccColor4F startColorVar = _emitter.startColorVar;
    startColorVar.b = 0.1f;
    _emitter.startColorVar = startColorVar;
    
    _emitter.emissionRate = 10; //_emitter.totalParticles/_emitter.life;
    _emitter.texture = [[CCTextureCache sharedTextureCache] addImage: @"snow.png"];
    return self;
}

- (void) setIntensity:(float)i
{
    if (i > 100)
        i = 50;
    
    NSLog(@"setting intensity: %f", i);
    
    _intensity = i;
    _emitter.emissionRate = i;
    if (fmod(i, 100) == 0) _emitter.startSize += 5;
}

- (void) dealloc
{
    NSLog(@"Dealloc OxSnow");
    [_emitter release];
    _emitter = nil;
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
