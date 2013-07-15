//
//  SenecaDetailViewController.h
//  SenecaGuidebook
//
//  Created by Ian Will on 7/14/13.
//  Copyright (c) 2013 Ian Will Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SenecaDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
