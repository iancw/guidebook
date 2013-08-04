//
//  SenecaAppDelegate.h
//  Seneca
//
//  Created by Ian Will on 7/26/13.
//  Copyright (c) 2013 Ian Will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SenecaAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end
