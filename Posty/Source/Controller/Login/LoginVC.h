//
//  LoginVC.h
//  Posty
//
//  Created by phuongthuy on 3/11/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LibRestKit.h"

@interface LoginVC : UITableViewController<UITextFieldDelegate, RestKitLibDelegate, FBSDKLoginButtonDelegate>
{
    NSString *url;
}
@property (weak, nonatomic) IBOutlet UITextField *txtfUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)onLoginButtonClicked:(id)sender;
- (IBAction)onCancelButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet TWTRLogInButton *btnLoginTwt;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *btnLoginFb;
- (IBAction)onLoginFacebookButtonClicked:(id)sender;
@end
