//
//  InfosVC.h
//  Posty
//
//  Created by phuongthuy on 2/18/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NotifyVC;
@class ProfileVC;
@class FriendsVC;
@class SettingVC;

@interface InfosVC : UIViewController<UITabBarDelegate>
{
    NotifyVC *vcNotice;
    ProfileVC *vcProfile;
    FriendsVC *vcFriend;
    SettingVC *vcSetting;
}
- (IBAction)btnLogout:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end
