//
//  SettingVC.h
//  Posty
//
//  Created by phuongthuy on 7/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountInfoVC;

#define SETTING_ACCOUNT     0
#define SETTING_PRIVACY     1
#define SETTING_NOTICE      2
#define SETTING_ABOUT       3
#define SETTING_HELP        4
#define SETTING_LOGOUT      5

@interface SettingVC : UITableViewController
{
    AccountInfoVC *vcAccount;
}

@end
