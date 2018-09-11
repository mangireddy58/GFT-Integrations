//
//  ViewController.m
//  Google
//
//  Created by Sai on 26/04/17.
//  Copyright © 2017 Mangi. All rights reserved.
//

#import "ViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    https://developers.facebook.com/docs/facebook-login/ios
//    https://console.developers.google.com/iam-admin/projects
//    https://developers.google.com/identity/sign-in/ios/
//    https://github.com/twitter/twitter-kit-ios/wiki/Installation
//    https://developer.twitter.com/en/apps/15845644
}

- (void)viewWillAppear:(BOOL)animated {
    
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.clientID = @"1026868718441-gfi7ajkkn4o1bgnajgjcosu4ar5cpak8.apps.googleusercontent.com";
    signIn.scopes = @[ @"profile", @"email" ];
    signIn.delegate = self;
    signIn.uiDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gPlusAction:(id)sender {
    [[GIDSignIn sharedInstance]signOut];
    [[GIDSignIn sharedInstance]signIn];
}
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    NSLog(@"%@", user.userID);
    NSLog(@"%@", user.profile.name);
    NSLog(@"%@", user.profile.givenName);
    NSLog(@"%@", user.profile.familyName);
    NSLog(@"%@", user.profile.email);
    
    NSLog(@"%d", user.profile.hasImage);
    
    NSString *profileImageString = @"";
    if (user.profile.hasImage){
        profileImageString = [user.profile imageURLWithDimension:100].absoluteString;
        NSLog(@"url : %@",profileImageString);
    }
    
    /*BOOL isFirstNameAvailable = NO;
     NSString *firstName = @"";
     if((NSNull *)user.profile.givenName != [NSNull null]){
     isFirstNameAvailable = YES;
     firstName = user.profile.givenName;
     }
     
     BOOL isLastNameAvailable = NO;
     NSString *lastName = @"";
     if((NSNull *)user.profile.familyName != [NSNull null]){
     isLastNameAvailable = YES;
     lastName = user.profile.familyName;
     }
     
     BOOL isEmailAvailable = NO;
     NSString *email;
     if((NSNull *)user.profile.email != [NSNull null]){
     isEmailAvailable = YES;
     email = user.profile.email;
     }*/
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    NSLog(@"Disconnected user");
}
- (IBAction)fbLoginAction:(id)sender {//Facebook
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        //TODO: process error or result.
        NSLog(@"%@", result);
        if (error) {
            NSLog(@"Process error");
            [self facebookLoginFailed:YES];
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
            [self facebookLoginFailed:NO];
        } else {
            NSLog(@"Login Result: %@", result);
            NSLog(@"Logged in");
            if ([FBSDKAccessToken currentAccessToken]) {
                NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id,name,email,first_name,last_name,picture.type(large)" forKey:@"fields"];
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                         
                     }
                 }];
            }
            else{
                [self facebookLoginFailed:YES];
            }
        }
    }];
}
- (void)facebookLoginFailed:(BOOL)isFBResponce{
    //    [self hideProgressIndicator];
    if(isFBResponce){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Attention", nil) message:NSLocalizedString(@"request_error", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Attention", nil) message:NSLocalizedString(@"Cancelled", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"pop_ok", nil) otherButtonTitles: nil];
        [alert show];
    }
}
- (IBAction)twitterLoginBtnAction:(id)sender {
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
/*
    Twitter.sharedInstance().logIn(completion: { (session, error) in
        if (session != nil) {
            print("signed in as \(session?.userName)");
        } else {
            print("error: \(error?.localizedDescription)");
        }
    })
 */
}
@end
