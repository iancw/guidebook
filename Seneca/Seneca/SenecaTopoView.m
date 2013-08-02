//
//  SenecaTopoView.m
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import "SenecaTopoView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SenecaTopoView
{
    CGImageRef _image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.delegate = self;
    }
    return self;
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
/*
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath,NULL,15.0f,15.f);
    CGPathAddCurveToPoint(thePath,
                          NULL,
                          15.f,250.0f,
                          295.0f,250.0f,
                          295.0f,15.0f);
    CGContextBeginPath(context);
    CGContextAddPath(context, thePath);
    CGContextSetLineWidth(context, 5);
    CGContextStrokePath(context);
    // Release the path
    CFRelease(thePath);
 */
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect imageRect;
	imageRect.origin = CGPointMake(0.0, 0.0);
	imageRect.size = CGSizeMake(480, 640);
	
	// Note: The images are actually drawn upside down because Quartz image drawing expects
	// the coordinate system to have the origin in the lower-left corner, but a UIView
	// puts the origin in the upper-left corner. For the sake of brevity (and because
	// it likely would go unnoticed for the image used) this is not addressed here.
	// For the demonstration of PDF drawing however, it is addressed, as it would definately
	// be noticed, and one method of addressing it is shown there.
    
	// Draw the image in the upper left corner (0,0) with size 64x64
	CGContextDrawImage(context, imageRect, self.image);
}

- (CGImageRef)image
{
	if (_image == NULL)
	{
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"gunsight-topo" ofType:@"png"];
		UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
		_image = CGImageRetain(img.CGImage);
	}
	return _image;
    
}

@end
