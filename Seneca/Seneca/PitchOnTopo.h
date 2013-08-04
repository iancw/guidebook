//
//  PitchOnTopo.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pitch, DrawPoint, Topo;

@interface PitchOnTopo : NSManagedObject

@property (nonatomic, retain) Pitch *pitch;
@property (nonatomic, retain) Topo *topo;
@property (nonatomic, retain) DrawPoint *points;

@end
