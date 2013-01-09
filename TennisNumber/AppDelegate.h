//
//  AppDelegate.h
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (BOOL) isEnabled;
+ (void) enable;
+ (void) showMessageForEnablingFeatures;

@end
