//
//  OxPath.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "OxPath.h"
#import "cocos2d.h"

@implementation OxPath
@synthesize path = _path;

const float BEE_SPEED = 0.02;

- (id) initFor:(Ox*)ox
{
    if(!(self = [super init]))
	{
		NSLog(@"OXPATH: Failed to load");
		return self;
	}
    
    _ox = [ox retain];
    _path = [[NSMutableArray array] retain];
    return self;
}

- (CCSequence *)appendNewSequence:(CGPoint)currentPoint 
{
    CGPoint last = [(NSValue *)[_path lastObject] CGPointValue];
    float time = [OxPath getOxTimeBetween:last and:currentPoint]; 
    CCActionInterval *a = [CCMoveTo actionWithDuration:time position:currentPoint];
    CCActionInterval *movedDelegate = [CCCallFunc actionWithTarget:self 
                                                          selector:@selector(moved)];
    return [CCSequence actions:a, movedDelegate, nil];
}

- (void)moved {
    if ([_path count] == 0) return;
    [_path removeObjectAtIndex:0];
    NSLog(@"OXPATH: removing item from _path");
    
    //CGPoint lastPosition = [(NSValue *)[_path objectAtIndex:0] CGPointValue];
    //CGPoint currentPosition = [_ox position];
    
    //[_ox setFlipX:currentPosition.x > lastPosition.x];
}

- (void)beginPath:(CGPoint)startPoint 
{
    NSLog(@"starting new path");
    
    if (_sequence != nil) {
        [_sequence stop];
        [_sequence release];
        _sequence = nil;
    }
    
    [_path removeAllObjects];
    
    [_path addObject:[NSValue valueWithCGPoint:startPoint]];
    
    [_ox stopAllActions];
    
    // put stampy into idle
    //[_sprite runAction:[CCRepeatForever actionWithAction: action]];
    
    _action = [[self appendNewSequence:startPoint] retain];
}

- (void)addPathPoint:(CGPoint)nextPoint 
{
    CCSequence *nextSequence = [self appendNewSequence:nextPoint];
    
    // for tracing the path
    [_path addObject:[NSValue valueWithCGPoint:nextPoint]];
    
    CCSequence *prevAction;
    
    if (_sequence == nil) {
        prevAction = _action;
    } else {
        prevAction = _sequence;
    }
    
    _sequence = [[CCSequence actionOne:prevAction two: nextSequence] retain];
}

- (void) makeItSo 
{
    if (_sequence != nil) 
    {
        NSLog(@"executing path action");
        CCSequence *exploreAction = [[CCCallFunc actionWithTarget:_ox
                                                         selector:@selector(explore)] retain];
        CCSequence *sequence = [[CCSequence actionOne:_sequence two:exploreAction] retain];
        [_ox runAction: sequence];
    }
}

- (void) dealloc
{
    NSLog(@"OXPATH: Dealloc");
    [_ox release];
    [_path release];
    _ox = nil;
    _path = nil;
    [super dealloc];
}

+ (float) getOxTimeBetween:(CGPoint)a and:(CGPoint)b
{
    // the distance between two vectors is the sqrt of (a * a) + (b * b)
    float x = fabs(b.x - a.x);
    float y = fabs(b.y - a.y);
    
    float distance = sqrt((x *  x) + (y * y));
    
    float time = fabsf(BEE_SPEED * distance);
    //NSLog(@"time: %f", time);
    return time;
}



@end
