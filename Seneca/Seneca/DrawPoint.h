//
//  Point.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PitchOnTopo;

@interface DrawPoint : NSManagedObject

@property (nonatomic, retain) NSNumber * sequenceNo;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) PitchOnTopo *pitchOnTopo;

@end
