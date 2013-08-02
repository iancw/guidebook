//
//  SenecaViewController.m
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import "SenecaViewController.h"

@interface SenecaViewController()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation SenecaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)processTap:(UITapGestureRecognizer *)gestureRecognizer
{
}

- (IBAction)processPinch:(UIPinchGestureRecognizer *)recognizer {
    CGFloat scale = [recognizer scale];
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.transform = transform;
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
