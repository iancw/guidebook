//
//  Route.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pitch;

@interface Route : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * routeNo;
@property (nonatomic, retain) Pitch *pitches;

@end
