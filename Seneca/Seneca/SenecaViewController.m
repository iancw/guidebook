//
//  SenecaViewController.m
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import "SenecaAppDelegate.h"
#import "SenecaViewController.h"
#import "SenecaTapHandler.h"
#import "SenecaExploreTapHandler.h"
#import "SenecaCreateTapHandler.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAShapeLayer.h>
#import <CoreData/CoreData.h>

#import "DrawPoint.h"
#import "Pitch.h"

@interface SenecaViewController()

@property (nonatomic, strong) IBOutlet UIView *parentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CAShapeLayer *routesLayer;
@property (nonatomic, strong) NSMutableArray *points;

- (void)centerScrollViewContents;

@end

@implementation SenecaViewController

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize managedObjectContext = _managedObjectContext;

id<SenecaTapHandler> tapHandler;
SenecaExploreTapHandler *exploreTapHandler;
SenecaCreateTapHandler *createTapHandler;


- (void)toggleMode:(id)sender
{
    NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
    if ( [sender selectedSegmentIndex] )  // If it's 1...Explore was selected
    {
        if (! exploreTapHandler)
        {
            exploreTapHandler = [[SenecaExploreTapHandler alloc] init];
        }
        tapHandler = exploreTapHandler;
        [self drawRoutesOnLayer:self.routesLayer];
    }else{
        if (! createTapHandler)
        {
            createTapHandler = [[SenecaCreateTapHandler alloc] initWithLayer: self.routesLayer AndObjectManagerContext:self.managedObjectContext];
        }
        tapHandler = createTapHandler;
    }
}

- (void)addRoutesFromCoreData
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SenecaAppDelegate *appDelegate = (SenecaAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext= appDelegate.managedObjectContext;
    
    _points = [[NSMutableArray alloc] init];

    // 1
    UIImage *image = [UIImage imageNamed:@"gunsight-topo.png"];
    // It's 2448 x 3264 ... 
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
    // 2
    self.scrollView.contentSize = image.size;

    
	// Do any additional setup after loading the view, typically from a nib.
    self.routesLayer = [CAShapeLayer layer];
    [self.imageView.layer addSublayer: self.routesLayer];
    
    [self drawRoutesOnLayer: self.routesLayer];
    
    [self.segmentedControl addTarget:self
                         action:@selector(toggleMode:)
               forControlEvents:UIControlEventValueChanged];
    tapHandler = [[SenecaCreateTapHandler alloc] init];
}

- (void)drawRoutesOnLayer: (CAShapeLayer* ) layer
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Pitch"];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pitch" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    NSError *error;
	NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:request error:&error];
	if (fetchResults == nil) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
	}
    NSSortDescriptor * descriptor =
    [[NSSortDescriptor alloc] initWithKey:@"seqNo" ascending:YES];
    [layer setFillColor:[[UIColor clearColor] CGColor]];
    [layer setStrokeColor:[[UIColor redColor] CGColor]];
    [layer setLineWidth: 6.0f];
    [layer setLineJoin:kCALineJoinRound];
    [layer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:5],nil]];

    CGMutablePathRef path = CGPathCreateMutable();
    for (id object in fetchResults)
    {
        Pitch * pitch = (Pitch*)object;
        NSSet *points = [pitch pointOnPitch];
        NSArray* sortedPoints = [points sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        Boolean first = TRUE;
        for (id dp_id in sortedPoints){
            DrawPoint *dp = (DrawPoint*)dp_id;
            CGPoint curPoint = CGPointMake(dp.x.floatValue, dp.y.floatValue);
            if (first){
                CGPathMoveToPoint(path, NULL, curPoint.x, curPoint.y);
                first = FALSE;
            }else{
                CGPathAddLineToPoint(path, NULL, curPoint.x, curPoint.y);
            }
        }
    }
    [layer setPath:path];
    CGPathRelease(path);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    // 4
    CGRect parentFrame = self.parentView.frame;
    
    CGFloat scaleWidth = parentFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = parentFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    if (minScale == 0.0)
    {
        minScale = 0.1;
    }
    self.scrollView.minimumZoomScale = minScale;
    
    // 5
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    // 6
    [self centerScrollViewContents];
}

- (IBAction)processLongPress:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint scrollPoint = [recognizer locationInView:self.scrollView];
    if ( CGRectContainsPoint(self.scrollView.frame, scrollPoint) )
    {
        CGPoint point = [recognizer locationInView:self.imageView];
        [tapHandler handleLongPress:point];
    }
}

- (IBAction)processTap:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint scrollPoint = [gestureRecognizer locationInView:self.scrollView];
    if ( CGRectContainsPoint(self.scrollView.frame, scrollPoint) )
    {
        CGPoint point = [gestureRecognizer locationInView:self.imageView];
        [tapHandler handleTap:point];
    }
}

- (void)centerScrollViewContents {
    CGSize boundsSize = _scrollView.bounds.size;
    CGRect contentsFrame = _imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    _imageView.frame = contentsFrame;
}



@end
