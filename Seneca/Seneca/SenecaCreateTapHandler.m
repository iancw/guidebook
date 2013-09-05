//
//  SenecaCreateTapHandler.m
//  Seneca
//
//  Created by Ian & Adrienne Will on 8/3/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import "SenecaCreateTapHandler.h"
#import "DrawPoint.h"
#import "Pitch.h"

@implementation SenecaCreateTapHandler

NSMutableArray * _points;
CAShapeLayer *_layer;

@synthesize managedObjectContext = _managedObjectContext;

-(id) initWithLayer: (CAShapeLayer*) layer AndObjectManagerContext: (NSManagedObjectContext*) context;
{
    self = [super init];
    if (self)
    {
        _points = [[NSMutableArray alloc] init];
        _layer = layer;
        self.managedObjectContext = context;
    }
    return self;
}

- (void) handleLongPress:(CGPoint) point
{
    /*
     Create a new instance of the Event entity.
     */
    Pitch *pitch = (Pitch *)[NSEntityDescription insertNewObjectForEntityForName:@"Pitch" inManagedObjectContext:self.managedObjectContext];
    for (int i=0; i<[_points count]; i++)
    {
        CGPoint curPoint = [[_points objectAtIndex:i] CGPointValue];
        DrawPoint *dp = (DrawPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"DrawPoint" inManagedObjectContext:self.managedObjectContext];
        dp.x = [NSNumber numberWithFloat:curPoint.x];
        dp.y = [NSNumber numberWithFloat:curPoint.y];
        dp.seqNo = [NSNumber numberWithInt:i];
        dp.parentPitch = pitch;
        
        // Configure the new event with information from the location.
        //pitch.topo = curTopo;
        
        /*
        event.creationDate = location.timestamp;
        CLLocationCoordinate2D coordinate = location.coordinate;
        event.latitude = @(coordinate.latitude);
        event.longitude = @(coordinate.longitude);
        */
    }
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"Error saving");
    }
    [_points removeAllObjects];
}

- (void) handleTap:(CGPoint) point
{
    [_points addObject:[NSValue valueWithCGPoint:point]];
    NSLog(@"%f, %f", point.x, point.y);
    
    [_layer setFillColor:[[UIColor clearColor] CGColor]];
    [_layer setStrokeColor:[[UIColor blueColor] CGColor]];
    [_layer setLineWidth: 6.0f];
    [_layer setLineJoin:kCALineJoinRound];
    [_layer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:5],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint curPoint = [[_points objectAtIndex:0] CGPointValue];
    CGPathMoveToPoint(path, NULL, curPoint.x, curPoint.y);
    for (int i=1; i<[_points count]; i++)
    {
        curPoint = [[_points objectAtIndex:i] CGPointValue];
        CGPathAddLineToPoint(path, NULL, curPoint.x, curPoint.y);
    }
    
    [_layer setPath:path];
    CGPathRelease(path);
}

@end
