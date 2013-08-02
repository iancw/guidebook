//
//  SenecaViewController.m
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import "SenecaViewController.h"
#import <QuartzCore/CALayer.h>
#import <QuartzCore/CAShapeLayer.h>

@interface SenecaViewController()
@property (nonatomic, strong) IBOutlet UIView *parentView;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CAShapeLayer *routesLayer;

- (void)centerScrollViewContents;

@end

@implementation SenecaViewController

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1
    UIImage *image = [UIImage imageNamed:@"gunsight-topo.png"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=image.size};
    [self.scrollView addSubview:self.imageView];
    
    // 2
    self.scrollView.contentSize = image.size;

    
	// Do any additional setup after loading the view, typically from a nib.
    self.routesLayer = [CAShapeLayer layer];
    [self.imageView.layer addSublayer: self.routesLayer];
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
    CGRect scrollViewFrame = self.scrollView.frame;
    CGRect parentFrame = self.parentView.frame;
    CGSize scrollContentSize = self.scrollView.contentSize;
    CGSize imageContentSize = self.imageView.image.size;
    
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

- (IBAction)processTap:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.imageView];
    CGPoint scrollPoint = [gestureRecognizer locationInView:self.scrollView];
    CGPoint parentPoint = [gestureRecognizer locationInView:self.parentView];
    
    CAShapeLayer *layer = self.routesLayer;
    [layer setBounds:self.imageView.bounds];
    [layer setPosition:self.imageView.center];
    [layer setFillColor:[[UIColor clearColor] CGColor]];
    [layer setStrokeColor:[[UIColor blueColor] CGColor]];
    [layer setLineWidth: 3.0f];
    [layer setLineJoin:kCALineJoinRound];
    [layer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:5],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x+100, point.y+100);
    
    [layer setPath:path];
    CGPathRelease(path);
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
