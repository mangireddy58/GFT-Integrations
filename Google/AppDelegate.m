//
//  AppDelegate.m
//  Google
//
//  Created by Sai on 26/04/17.
//  Copyright © 2017 Mangi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Facebook SDK
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [[Twitter sharedInstance] startWithConsumerKey:@"Z9fK0d8c24BOGguOJsZ99nfyW" consumerSecret:@"8rwv00payP0c3nj7oRuDf1chOSEQf77NSu73jJIwcZK7CSmzpY"];
    
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

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if([[url absoluteString] containsString:@"google"]){
//        return [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication
//                                          annotation:annotation];
//    }
//    else{
//        return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//    }
//    return YES;
//}

- (BOOL)application:(UIApplication* )app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if([[url absoluteString] containsString:@"twitterkit"]){
        return [[Twitter sharedInstance] application:app openURL:url options:options];
    }
    else if([[url absoluteString] containsString:@"google"]){
        return [[GIDSignIn sharedInstance] handleURL:url
                                   sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                          annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
    else{
        BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:app
                                                                      openURL:url
                                                            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                                   annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                        ];
        return handled;
    }
    return YES;
}


//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
//    if([[url absoluteString] containsString:@"googleTwitter://"]) {
//        return [[Twitter sharedInstance] application:app openURL:url options:options];
//    }
//    return YES;
//}
@end
