//
//  ViewController.h
//  Google
//
//  Created by Sai on 26/04/17.
//  Copyright © 2017 Mangi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController<GIDSignInDelegate, GIDSignInUIDelegate>


- (IBAction)gPlusAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginAction;
- (IBAction)fbLoginAction:(id)sender;
@end

