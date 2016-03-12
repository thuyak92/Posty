//
//  DetailVC.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibRestKit.h"
#import "InteractiveView.h"

@interface DetailVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, RestKitLibDelegate>
{
    NSMutableArray *listComments;
    UserModel *user;
    CGRect defaultFrame;
    float cellWidth;
}

@property (strong, nonatomic) PostModel *post;
@property (strong, nonatomic) InteractiveView *interactiveView;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *imvAvar;
@property (weak, nonatomic) IBOutlet UIImageView *imvPrivacy;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextView *txtvCmt;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnTypeText;
@property (weak, nonatomic) IBOutlet UIButton *btnTypeImage;

- (IBAction)onButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AccessoryLayoutComment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardControlLayout;

@end
