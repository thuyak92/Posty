//
//  LoginVC.m
//  MyDear
//
//  Created by phuongthuy on 1/18/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([Lib checkLogin]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [LibRestKit share].delegate = self;
        _btnLoginFb.delegate = self;
        [self loginTwitterDidComplete];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Twitter

- (IBAction)onLoginTwitterButtonClicked:(id)sender {
    
}

- (void)loginTwitterDidComplete
{
    [_btnLoginTwt setLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            UserModel *user = [[UserModel alloc] init];
            user.twiterId = session.userID;
            [MBProgressHUD showHUDAddedTo:self.view animated:NO];
            [[LibRestKit share] registerUser:user success:^(UserModel *user) {
                [self handleRegisterSuccess:user];
            }];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
}

#pragma mark - Facebook

- (IBAction)onLoginFacebookButtonClicked:(id)sender {
    _btnLoginFb.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if (error) {
        NSLog(@"Process error");
    } else if (result.isCancelled) {
        NSLog(@"Cancelled");
    } else {
        FBSDKAccessToken *token = result.token;
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                UserModel *user = [[UserModel alloc] init];
                user.facebookId = token.userID;
                user.nickname = [result valueForKey:@"name"];
                user.avatarUrl = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                [[LibRestKit share] registerUser:user success:^(UserModel *user) {
                    [self handleRegisterSuccess:user];
                }];
            }
        }];
    }
}


//- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
//                            user:(id<FBGraphUser>)user {
//    NSLog(@"user = %@", user);
//    if (!fbUser) {
//        if (![GlobalVariable shareInstance].isConnectedServer) {
//            [[SocketLib shareSocketLib] connectToHost:SERVER_DOMAIN Port:SERVER_PORT];
//        }else {
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            [self performSelector:@selector(loginToServer) withObject:nil afterDelay:2.0f];
//        }
//        fbUser = [[UserModel alloc] init];
//        fbUser.userId = user.objectID;
//        fbUser.name = user.name;
//        fbUser.email = [user objectForKey:@"email"];
//    }
//    
//}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    [Lib logout];
}

#pragma mark - login Posty account

- (UserModel *)getInfo
{
    UserModel *user = [[UserModel alloc] init];
    user.email = _txtfUsername.text;
    user.password = _txtfPassword.text;
    return user;
}

- (BOOL)validate: (UserModel *)user
{
    if (!user.email || user.email.length == 0) {
        [Lib showAlertTitle:@"エラー" message:@"メールを入力してください。"];
        return FALSE;
    }
    if (![Lib checkEmailValid:user.email]) {
        [Lib showAlertTitle:@"エラー" message:@"メールは正しくありません。"];
        return FALSE;
    }
    if (!user.password || user.password.length == 0) {
        [Lib showAlertTitle:@"エラー" message:@"パスワードを入力してください。"];
        return FALSE;
    }
    return TRUE;
}

- (IBAction)onLoginButtonClicked:(id)sender {
    UserModel *user = [self getInfo];
    if (![self validate:user]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    
    if (sender == _btnLogin) {
        [[LibRestKit share] login:user success:^(UserModel *user) {
            [self handleLoginSuccess:user];
        }];
    } else {
        [[LibRestKit share] registerUser:user success:^(UserModel *user) {
            [self handleRegisterSuccess:user];
        }];
    }
}

- (IBAction)onCancelButtonClicked:(id)sender {
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [Lib setGuest:TRUE];
    [self dismissViewControllerAnimated:YES completion:nil];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app switchToTabWithIndex:TAB_HOME];
}

#pragma mark - TextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(0, -130 - textField.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtfUsername) {
        //press Next
        [_txtfPassword becomeFirstResponder];
        // Scroll to selected row
        return NO;
    }
    else
    {
        //press Done
        [_txtfPassword resignFirstResponder];
        [textField endEditing:YES];
        return YES;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - RestKit Delegate                 

- (void)handleLoginSuccess: (UserModel *)user
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [Lib setCurrentUser:user];
    [Lib setGuest:FALSE];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleRegisterSuccess: (UserModel *)user
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
    [Lib setCurrentUser:user];
    [Lib setGuest:FALSE];
    if (user.nickname) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self performSegueWithIdentifier:SEGUE_LOGIN_TO_USER_INFO sender:nil];
    }
}

@end
