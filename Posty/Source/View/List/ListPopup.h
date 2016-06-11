//
//  ListPopup.h
//  Posty
//
//  Created by phuongthuy on 3/14/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPopup : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *listFriends;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
