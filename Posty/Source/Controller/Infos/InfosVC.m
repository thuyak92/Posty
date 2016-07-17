//
//  InfosVC.m
//  Posty
//
//  Created by phuongthuy on 2/18/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "InfosVC.h"
#import "Lib.h"
#import "AppDelegate.h"
#import "SettingVC.h"
#import "FriendsVC.h"
#import "NotifyVC.h"
#import "ProfileVC.h"

@interface InfosVC ()

@end

@implementation InfosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    vcNotice = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:SB_NOTICE];
    [vcNotice.view setFrame:_viewContent.frame];
    [self.viewContent addSubview:vcNotice.view];
    [_tabBar setSelectedItem:[[_tabBar items] objectAtIndex:0]];
    
    vcProfile = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:SB_PROFILE];
    [vcProfile.view setFrame:_viewContent.frame];
    
    vcFriend = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:SB_FRIEND];
    [vcFriend.view setFrame:_viewContent.frame];
    
    vcSetting = [[UIStoryboard storyboardWithName:@"Info" bundle:nil] instantiateViewControllerWithIdentifier:SB_SETTING];
    [vcSetting.view setFrame:_viewContent.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![Lib checkLogin]) {
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        [app showLogin];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    for (UIView *vi in self.viewContent.subviews) {
        [vi removeFromSuperview];
    }
    switch (item.tag) {
        case 0:
            [self.viewContent addSubview:vcNotice.view];
            break;
        case 1:
            [self.viewContent addSubview:vcProfile.view];
            break;
        case 2:
            [self.viewContent addSubview:vcFriend.view];
            break;
        case 3:
            [self.viewContent addSubview:vcSetting.view];
            [self addChildViewController:vcSetting];
            [vcSetting didMoveToParentViewController:self];
            break;
            
        default:
            break;
    }
}

@end
