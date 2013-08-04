//
//  SenecaCreateTapHandler.h
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SenecaTapHandler.h"
#import <QuartzCore/CAShapeLayer.h>
#import <CoreData/CoreData.h>

@interface SenecaCreateTapHandler : NSObject <SenecaTapHandler>

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

-(id) initWithLayer: (CAShapeLayer*) layer AndObjectManagerContext: (NSManagedObjectContext*) context;

@end
