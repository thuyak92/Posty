//
//  PostVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface PostVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, RestKitLibDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSelectPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
- (IBAction)onButonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
