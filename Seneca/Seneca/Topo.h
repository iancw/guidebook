//
//  Topo.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PitchOnTopo;

@interface Topo : NSManagedObject

@property (nonatomic, retain) NSString * imageFile;
@property (nonatomic, retain) PitchOnTopo *pitches;

@end
