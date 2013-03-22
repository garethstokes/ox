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
#import "GameConfig.h"

@implementation Ox

- (id) init
{
    if(!(self = [super init]))
	{
		NSLog(@"OX: Failed to load");
		return self;
	}
    
    _loader = [[SpriteHelperLoader alloc] initWithContentOfFile:@"stampy"];
    [self orientate:1];
    
    self.position = ccp(arc4random() % 400, arc4random() % 280);
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
    CGPoint randomPoint = ccp(rand() % 400, rand() % 280);
    
    int orientation = [self calculateOrientationFrom:randomPoint to:currentPosition];
    [self orientate:orientation];
    
    float time = [OxPath getOxTimeBetween:currentPosition and:randomPoint]; //getBeeTime(currentPosition, random_point);
    
    id a = [CCMoveTo actionWithDuration:time position:randomPoint];
    id m = [[CCCallFunc actionWithTarget:self selector:@selector(explore)] retain];
    [self runAction: [CCSequence actions:a, m, nil]];
    [m release];
}

- (int) calculateOrientationFrom:(CGPoint)current to:(CGPoint)to
{
    float angle = ccpToAngle( ccpSub(to, current) );
    angle = CC_RADIANS_TO_DEGREES(angle) + 180;
    NSLog(@"angle : %f", angle);
   
    // right by default.
    int orientation = 2;
    
    // left
    if (angle >= 157 && angle < 202) {
        orientation = 1;
    }
    
    // right
    if (angle <= 22 || angle > 337 ) {
        orientation = 2;
    }
    
    // up
    if (angle > 67 && angle <= 112) {
        orientation = 3;
    }
    
    // down
    if (angle >= 247 && angle <= 292) {
        orientation = 4;
    }
    
    // up_left
    if (angle >= 112 && angle <= 157) {
        orientation = 5;
    }
    
    // up_right
    if (angle >= 22 && angle <= 67) {
        orientation = 6;
    }
    
    // down_left
    if (angle >= 202 && angle <= 247) {
        orientation = 7;
    }
    
    // down_right
    if (angle >= 292 && angle <= 337) {
        orientation = 8;
    }
    
    return orientation;
}

/*
    This function switches the sprite depending on which orientation
    is provided. Supported values are:
        * left          : 1
        * right         : 2
        * up            : 3
        * down          : 4
        * up_left       : 5
        * up_right      : 6
        * down_left     : 7
        * down_right    : 8
 */
- (void) orientate:(int)withOrientation
{
    if (_spriteBody != nil) {
        [self removeChild:_spriteBody cleanup:YES];
    }
    
    if (_spriteHead != nil) {
        [self removeChild:_spriteHead cleanup:YES];
    }
    
    switch(withOrientation)
    {
        case 1: // left
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_4" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(-43, 0) inLayer:self];
            break;
        case 2: // right
            // diaginal = ccp(17, 2)
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_5" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(21, 0) inLayer:self];
            break;
        case 3: // up
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_8" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_6-8_reg_orange" atPosition:ccp(-6, 30) inLayer:self];
            
            [self reorderChild:_spriteBody z:20];
            [self reorderChild:_spriteHead z:10];
            break;
            
        case 4: // down
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_1" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(-7, -20) inLayer:self];
            break;
        
        case 5: //up_left
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_6" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(-37, 5) inLayer:self];
            break;
            
        case 6: // up_right
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_7" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(17, 2) inLayer:self];
            break;
            
        case 7: // down_left
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_2" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(-43, -5) inLayer:self];
            break;
            
        case 8: // down_right
            _spriteBody = [_loader spriteWithUniqueName:@"body_basic_pos_3" atPosition:ccp(0,0) inLayer:self];
            _spriteHead = [_loader spriteWithUniqueName:@"head_position_2-5_reg_orange" atPosition:ccp(17, -2) inLayer:self];
            break;
    }
    
    [self setContentSize:_spriteBody.contentSize];
}

- (void) dealloc
{
    NSLog(@"Dealloc Ox");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
