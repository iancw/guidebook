//
//  SenecaQuartzView.m
//  SenecaGuidebook
//
//  Created by Ian Will on 7/14/13.
//  Copyright (c) 2013 Ian Will Software. All rights reserved.
//

#import "SenecaQuartzView.h"

@implementation SenecaQuartzView
{
    CGImageRef _image;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGRect imageRect;
	imageRect.origin = CGPointMake(8.0, 8.0);
	imageRect.size = CGSizeMake(256.0, 256.0);
	
	// Note: The images are actually drawn upside down because Quartz image drawing expects
	// the coordinate system to have the origin in the lower-left corner, but a UIView
	// puts the origin in the upper-left corner. For the sake of brevity (and because
	// it likely would go unnoticed for the image used) this is not addressed here.
	// For the demonstration of PDF drawing however, it is addressed, as it would definately
	// be noticed, and one method of addressing it is shown there.
    
	// Draw the image in the upper left corner (0,0) with size 64x64
	CGContextDrawImage(context, imageRect, self.image);
}

-(void)drawBlipAtLocation:(CGPoint)point
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context){
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextFillRect(context, CGRectMake(point.x, point.y, 3, 3));
    }
}

- (CGImageRef)image
{
	if (_image == NULL)
	{
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"seneca" ofType:@"jpg"];
		UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
		_image = CGImageRetain(img.CGImage);
	}
	return _image;
    
}

@end
