//
//  Pitch.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PitchOnTopo, Route;

@interface Pitch : NSManagedObject

@property (nonatomic, retain) NSNumber * pitchNo;
@property (nonatomic, retain) PitchOnTopo *onTopo;
@property (nonatomic, retain) Route *onRoute;

@end
