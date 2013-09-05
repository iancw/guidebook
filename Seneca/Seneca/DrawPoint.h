//
//  DrawPoint.h
//  Seneca
//
//  Created by Ian Will on 9/4/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pitch;

@interface DrawPoint : NSManagedObject

@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * seqNo;
@property (nonatomic, retain) Pitch *parentPitch;

@end
