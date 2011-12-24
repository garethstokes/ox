//
//  Ox.m
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "Ox.h"
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
    [_loader spriteWithUniqueName:@"body_basic_pos_2" atPosition:ccp(50,50) inLayer:self];
    
    return self;
}

- (void) dealloc
{
    NSLog(@"Dealloc Ox");
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

@end
