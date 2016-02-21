//
//  SearchVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

#define TYPE_PRIVACY_ALL        0
#define TYPE_PRIVACY_FRIEND     1
#define TYPE_PRIVACY_PUBLIC     2

#define TYPE_ORDER_TIME         @"order_time"
#define TYPE_ORDER_LIKE         @"order_liked"

#define TYPE_ORDER_VALUE_DESC   @"desc"
#define TYPE_ORDER_VALUE_ASC    @"asc"

@interface SearchVC : UITableViewController<RestKitLibDelegate>
{
    SearchModel *search;
}

//Search bar
@property (weak, nonatomic) IBOutlet UISearchBar *searchPost;

//Users
@property (weak, nonatomic) IBOutlet UIButton *btnAllOfUser;
@property (weak, nonatomic) IBOutlet UIButton *btnFriend;
@property (weak, nonatomic) IBOutlet UIButton *btnPublic;
- (IBAction)onUserButtonClicked:(id)sender;

//Category
@property (weak, nonatomic) IBOutlet UIButton *btnAllCategory;
- (IBAction)onCategoryButtonClicked:(id)sender;
- (IBAction)onAllCategoryButtonClicked:(id)sender;

//Order
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPost;
@property (weak, nonatomic) IBOutlet UIButton *btnPopular;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPopular;
- (IBAction)onOrderButtonClicked:(id)sender;
- (IBAction)onOrderSegmentChangedValue:(id)sender;

//Commit
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onBtnCommitClicked:(id)sender;

@end
