//
//  GameLayer.h
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import "cocos2d.h"
#import "OxSnow.h"

@interface GameLayer : CCLayer {
    NSMutableArray* _oxen;
    NSMutableDictionary* _activePaths;
    OxSnow *_snow;
    ccTime _time;
}

@end
