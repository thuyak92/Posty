//
//  PostConfirmVC.h
//  Posty
//
//  Created by phuongthuy on 2/21/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"

@interface PostConfirmVC : UIViewController<UITableViewDataSource, UITableViewDelegate, RestKitLibDelegate>

@property (nonatomic, strong) PostModel *post;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;
- (IBAction)onButtonClicked:(id)sender;

@end
