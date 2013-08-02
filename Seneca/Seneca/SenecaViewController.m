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

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UIView *parentView;

@property (nonatomic, strong) CAShapeLayer *routesLayer;

@end

@implementation SenecaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.routesLayer = [CAShapeLayer layer];
    [self.parentView.layer addSublayer: self.routesLayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)processTap:(UITapGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.parentView];
    CAShapeLayer *layer = self.routesLayer;
    [layer setBounds:self.parentView.bounds];
    [layer setPosition:self.parentView.center];
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

- (IBAction)processPinch:(UIPinchGestureRecognizer *)recognizer {
    CGFloat scale = [recognizer scale];
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    self.imageView.transform = transform;
    
    [UIView animateWithDuration:0.5 animations:^{
        
    }];
}

- (IBAction)processPan:(UIPanGestureRecognizer *)recognizer {
    CGPoint point = [recognizer translationInView: self.imageView];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(point.x, point.y);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.transform = transform;
    }];
}
@end
