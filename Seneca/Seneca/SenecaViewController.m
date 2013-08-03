//
//  SenecaViewController.m
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import "SenecaViewController.h"
#import "SenecaTapHandler.h"
#import "SenecaExploreTapHandler.h"
#import "SenecaCreateTapHandler.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAShapeLayer.h>

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
    }else{
        if (! createTapHandler)
        {
            createTapHandler = [[SenecaCreateTapHandler alloc] initWithLayer: self.routesLayer];
        }
        tapHandler = createTapHandler;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [self.segmentedControl addTarget:self
                         action:@selector(toggleMode:)
               forControlEvents:UIControlEventValueChanged];
    tapHandler = [[SenecaCreateTapHandler alloc] init];
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
