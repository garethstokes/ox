//
//  GameLayer.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "GameLayer.h"
#import "Ox.h"
#import "OxPath.h"
#import "CCTouchDispatcher.h"

@implementation GameLayer

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// enable touches
		self.isTouchEnabled = YES;
		
        // register to receive targeted touch events
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self
                                                         priority:0
                                                  swallowsTouches:YES];
        
		// enable accelerometer
		self.isAccelerometerEnabled = YES;
		
		CGSize screenSize = [CCDirector sharedDirector].winSize;
		CCLOG(@"Screen width %0.2f screen height %0.2f",screenSize.width,screenSize.height);
		
        _oxen = [[NSMutableArray array] retain];
        _activePaths = [[NSMutableDictionary dictionary] retain];
        
        Ox *ox = [[Ox alloc] init];
        [self addChild:ox];
        
        [_oxen addObject:ox];
        
	}
	return self;
}

-(void) draw
{
    for (OxPath *oxPath in [_activePaths allValues])
    {
        
        NSArray *path = [oxPath path];
        if ([path count] == 0) continue;

        CGPoint last = ccp(0, 0);
        for (int i = 0; i < [path count]; i++) 
        {
            NSValue* val = [path objectAtIndex:i];
            CGPoint p = [val CGPointValue];
            if (last.y == 0 && last.x == 0) last = p;
            ccDrawLine(ccp(last.x, last.y), ccp(p.x, p.y));
            last = p;
        }
    } 
    
    /*
    for (Ox *ox in _oxen) 
    {
        CGRect rect = [ox boundingBox];
		CGPoint vertices[4]={
			ccp(rect.origin.x,rect.origin.y),
			ccp(rect.origin.x+rect.size.width,rect.origin.y),
			ccp(rect.origin.x+rect.size.width,rect.origin.y+rect.size.height),
			ccp(rect.origin.x,rect.origin.y+rect.size.height),
		};
		ccDrawPoly(vertices, 4, YES);
    }
     */
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event 
{  
    CGPoint point = [self convertTouchToNodeSpace:touch];
    
    NSLog(@"touched at point: (x => %f, y => %f)", point.x, point.y);
    //NSLog(@"touched at point: (x => %f, y => %f)", point.x, point.y);
    
    for (Ox *ox in _oxen) 
    {
        
        if (CGRectContainsPoint([ox boundingBox], point))
        {
            OxPath *path = [[[OxPath alloc] initFor:ox] autorelease];

            // might need to flip this point and reverse it.
            [path beginPath:point]; 
            
            NSString* key = [NSString stringWithFormat:@"%i",[touch hash]];
            NSLog(@"setting active ox for touch hash: %@", key);
            [_activePaths setValue:path forKey:key];
            break;
        }
    }
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    NSString* key = [NSString stringWithFormat:@"%i",[touch hash]];
    OxPath* path = [_activePaths objectForKey:key];
    if (path == nil) return;
    
    CGPoint point = [self convertTouchToNodeSpace:touch];
    [path addPathPoint:point];
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    //  NSLog(@"ccTouchEnded");
    //[_currentBee move];
    
    NSString* key = [NSString stringWithFormat:@"%i",[touch hash]];
    OxPath* path = [_activePaths objectForKey:key];
    if (path == nil) return;
    
    [path makeItSo];
    [_activePaths removeObjectForKey:key];
}

- (void) dealloc
{
    NSLog(@"Dealloc Ox");
    _oxen = nil;
    _activePaths = nil;
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
