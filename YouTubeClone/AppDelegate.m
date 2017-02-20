//
//  AppDelegate.m
//  YouTubeClone
//
//  Created by Changchang on 4/2/17.
//  Copyright © 2017 University of Melbourne. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeScreenController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    HomeScreenController *homeScreenController = [[HomeScreenController alloc]initWithCollectionViewLayout:layout];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeScreenController];
    
//    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:230.0/255.0 green:32.0/255.0 blue:31.0/255.0 alpha:1];
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    //get rid of black shadow under navbar
    [UINavigationBar appearance].shadowImage = [[UIImage alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
