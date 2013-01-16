//
//  AppDelegate.m
//  International Tennis Number
//
//  Created by Robson Ximenes on 17/11/12.
//  Copyright (c) 2012 Robson Ximenes. All rights reserved.
//

#import "AppDelegate.h"
#import "AssessmentBC.h"

@implementation AppDelegate{
    SKProduct * inAppPurchaseProduct;
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:DEFAULTS_OLD_USER]){
        [defaults setBool:YES forKey:DEFAULTS_OLD_USER];
        [defaults setBool:YES forKey:DEFAULTS_SOUND_ENEBLED];
        [defaults synchronize];
        [AssessmentBC configureSampleAssessment];
        [AssessmentBC clearInstance];
    }
    

    [[TennisNumberIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            inAppPurchaseProduct = [products lastObject];
        }
    }];
    
    [self customizeAppearance];
    return YES;
}

- (void)customizeAppearance
{
    // Create resizable images
    UIImage *gradientImage = [[UIImage imageNamed:@"pixelVerde"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:gradientImage
                                       forBarMetrics:UIBarMetricsDefault];

    [[UITabBar appearance] setBackgroundImage:gradientImage];
    
    
    [[UIToolbar appearance] setBackgroundImage:gradientImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    
    // Customize the title text for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Arial-Bold" size:0.0],
      UITextAttributeFont, 
      nil]];
    
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,
                    [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        
//        NSLog(@"Limpando o bando devido a erro na base...");
//        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark Habilitação Full Features

+ (BOOL) isEnabled{
//    return true;
    return [[NSUserDefaults standardUserDefaults] boolForKey:DEFAULTS_FULL_FEATURES];
}

+ (void) enable{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:DEFAULTS_FULL_FEATURES];
}

#pragma mark Mensagens full features

- (void)showMessageForEnablingFeatures {
    UIAlertView *action = [[UIAlertView alloc] initWithTitle:@"Enable all features!" message:@"You can enable this features:\nUnlimited assessments\nIndividual strokes scores\nSend assessement by e-mail." delegate:self cancelButtonTitle:@"Not now..." otherButtonTitles:@"Ok, lets go!", nil];
    [action show];
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"Button: %d",buttonIndex);
    
    if (buttonIndex == 0){
		// Yes, do something
        
        
	}else if (buttonIndex == 1){
		
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
    
        
        NSLog(@"Buying %@...", inAppPurchaseProduct.productIdentifier);
        [[TennisNumberIAPHelper sharedInstance] buyProduct:inAppPurchaseProduct];
        
        
        [alertView resignFirstResponder];
    }
}

- (void)productPurchased:(NSNotification *)notification {
    NSString * productIdentifier = notification.object;
    if ([inAppPurchaseProduct.productIdentifier isEqualToString:productIdentifier]) {
        [AppDelegate enable];
    }
}



@end
