//
//  SenecaDetailViewController.m
//  SenecaGuidebook
//
//  Created by Ian Will on 7/14/13.
//  Copyright (c) 2013 Ian Will Software. All rights reserved.
//

#import "SenecaDetailViewController.h"
#import "SenecaQuartzView.h"

@interface SenecaDetailViewController ()
- (void)configureView;

@property (nonatomic, strong) IBOutlet SenecaQuartzView *senecaQuartzView;

@end

@implementation SenecaDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showTap:(UITapGestureRecognizer *)gestureRecognizer
{
    UIView *quartzView = [gestureRecognizer view];
    CGPoint loc = [gestureRecognizer  locationInView:quartzView];
    if (CGRectContainsPoint([self.senecaQuartzView frame], loc))
    {
        [self.senecaQuartzView drawBlipAtLocation:loc];
    }

}

/**
 Ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously.
 Prevent other gesture recognizers from recognizing simultaneously.
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // If either of the gesture recognizers is the long press, don't allow simultaneous recognition.
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return NO;
    }
    
    return YES;
}

@end
