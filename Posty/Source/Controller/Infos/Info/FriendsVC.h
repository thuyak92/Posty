//
//  FriendsVC.h
//  Posty
//
//  Created by phuongthuy on 7/16/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface FriendsVC : UITableViewController<UISearchBarDelegate, RestKitLibDelegate>
{
    NSMutableArray *listFriends;
    UISearchBar *searchBar;
    NSInteger countPublic, countGroup;
}

@end
