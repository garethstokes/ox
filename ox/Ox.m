//
//  Ox.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "Ox.h"
#import "OxPath.h"
#import "SpriteHelperLoader.h"

@implementation Ox

- (id) init
{
    if(!(self = [super init]))
	{
		NSLog(@"OX: Failed to load");
		return self;
	}
    
    _loader = [[SpriteHelperLoader alloc] initWithContentOfFile:@"stampy"];
    CCSprite *body = [_loader spriteWithUniqueName:@"body_basic_pos_2" atPosition:ccp(0,0) inLayer:self];
    [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(-37,-0) inLayer:self];
    
    [self setContentSize:body.contentSize];
    
    self.position = ccp(arc4random() % 480, arc4random() % 320);
    [self explore];
    return self;
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

- (void) explore 
{    
    NSLog(@"OX: exploring");
    CGPoint currentPosition = [self position];
    CGPoint randomPoint = ccp(rand() % 480, rand() % 320);
    
    //[_sprite setFlipX:currentPosition.x > random_point.x];
    
    float time = [OxPath getOxTimeBetween:currentPosition and:randomPoint]; //getBeeTime(currentPosition, random_point);
    
    id a = [CCMoveTo actionWithDuration:time position:randomPoint];
    id m = [[CCCallFunc actionWithTarget:self selector:@selector(explore)] retain];
    [self runAction: [CCSequence actions:a, m, nil]];
    [m release];
}

- (void) dealloc
{
    NSLog(@"Dealloc Ox");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
