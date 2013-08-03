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

@interface SenecaCreateTapHandler : NSObject <SenecaTapHandler>
-(id) initWithLayer: (CAShapeLayer*) layer;
@end
