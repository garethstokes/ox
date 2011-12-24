//
//  OxPath.h
//  ox
//
//  Created by Gareth Stokes on 24/12/11.
//  Copyright (c) 2011 digital five. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ox.h"
#import "cocos2d.h"

@interface OxPath : NSObject {
    Ox* _ox;
    CCSequence *_sequence;
    CCSequence *_action;
    NSMutableArray *_path;
}

@property (nonatomic, retain) NSMutableArray *path;

- (id) initFor:(Ox*)ox;
- (CCSequence *) appendNewSequence:(CGPoint)point;
- (void) moved;

- (void) beginPath:(CGPoint)startPoint;
- (void) addPathPoint:(CGPoint)nextPoint;
- (void) makeItSo;

+ (float) getOxTimeBetween:(CGPoint)a and:(CGPoint)b;
@end

