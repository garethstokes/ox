//
//  Ox.h
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "CCLayer.h"
#import "SpriteHelperLoader.h"

@interface Ox : CCLayer {
    SpriteHelperLoader *_loader;
}

- (void) explore;

@end
