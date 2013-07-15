//
//  SenecaMasterViewController.h
//  SenecaGuidebook
//
//  Created by Ian Will on 7/14/13.
//  Copyright (c) 2013 Ian Will Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface SenecaMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
