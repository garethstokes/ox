//
//  Ox.h
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "cocos2d.h"
#import "SpriteHelperLoader.h"

@interface Ox : CCLayer {
    SpriteHelperLoader *_loader;
    CCSprite * _spriteBody;
    CCSprite * _spriteHead;
}

- (void) explore;
- (int) calculateOrientationFrom:(CGPoint)current to:(CGPoint)to;
- (void) orientate:(int)orientation;

@end
