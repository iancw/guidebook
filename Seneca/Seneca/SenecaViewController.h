//
//  SenecaViewController.h
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SenecaViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;


@end
