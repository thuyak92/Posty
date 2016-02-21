//
//  PostVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

#define MENU_RECEIVED   0
#define MENU_DELAY      1
#define MENU_SAVE       2
#define MENU_SEND       3
#define MENU_TRASH      4


@interface PostVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, RestKitLibDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSelectPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
- (IBAction)onButonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
