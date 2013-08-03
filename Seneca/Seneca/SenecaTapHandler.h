//
//  SenecaTapHandler.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SenecaTapHandler <NSObject>

- (void) handleTap:(CGPoint) pointInImage;
- (void) handleLongPress:(CGPoint) pointInImage;

@end
