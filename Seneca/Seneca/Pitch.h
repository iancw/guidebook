//
//  Pitch.h
//  Seneca
//
//  Created by Ian Will on 9/4/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrawPoint;

@interface Pitch : NSManagedObject

@property (nonatomic, retain) NSNumber * pitchNo;
@property (nonatomic, retain) NSSet *pointOnPitch;
@end

@interface Pitch (CoreDataGeneratedAccessors)

- (void)addPointOnPitchObject:(DrawPoint *)value;
- (void)removePointOnPitchObject:(DrawPoint *)value;
- (void)addPointOnPitch:(NSSet *)values;
- (void)removePointOnPitch:(NSSet *)values;

@end
