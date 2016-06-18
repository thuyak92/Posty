//
//  DetailVC.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "DetailVC.h"
#import "Lib.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PostInfoCell.h"
#import "PostImageCell.h"
#import "CommentCell.h"
#import "UITextView+Placeholder.h"


@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [Lib currentUser];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    _txtvCmt.placeholder = @"Type a message";
    _txtvCmt.showsVerticalScrollIndicator = NO;
    _txtvCmt.autocorrectionType = UITextAutocorrectionTypeNo;
    _btnSend.enabled = NO;
//    [_txtvCmt.layer setBorderWidth:1];
    
    [[LibRestKit share] getObjectsAtPath:[NSString stringWithFormat:URL_GET_COMMENT, _post.postId] forClass:CLASS_COMMENT success:^(id objects) {
        listComments = [NSMutableArray arrayWithArray:objects];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    //Interactive keyboard and tableview
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.interactiveView = [[InteractiveView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.AccessoryLayoutComment.constant)];
    self.interactiveView.userInteractionEnabled = NO;
    self.txtvCmt.inputAccessoryView = self.interactiveView;
    self.txtvCmt.inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    __weak typeof(self)weakSelf = self;
    self.interactiveView.inputAcessoryViewFrameChangedBlock = ^(CGRect inputAccessoryViewFrame){
        CGFloat value = CGRectGetHeight(weakSelf.view.frame) - CGRectGetMinY(inputAccessoryViewFrame) - CGRectGetHeight(weakSelf.txtvCmt.inputAccessoryView.frame);
        NSLog(@"value = %f, weakself = %f, input = %f, cmt = %f", value, weakSelf.view.frame.size.height, inputAccessoryViewFrame.size.height, weakSelf.txtvCmt.inputAccessoryView.frame.size.height);
        if (!weakSelf.btnTypeImage.isSelected) {
            weakSelf.keyboardControlLayout.constant = MAX(0, value);
        }
        [weakSelf.view layoutIfNeeded];
    };
    [self.txtvCmt reloadInputViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return listComments.count;
    }
    return 1;
}

- (CGSize)frameForText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:attributesDictionary
                                      context:nil];
    
    // This contains both height and width, but we really care about height.
    return frame.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PostImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostImageCell"];
        [cell initWithPost:_post];
        return cell;
    } else if (indexPath.section == 1) {
        PostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
        [cell initWithPost:_post];
        return cell;
    } else if (indexPath.section == 2) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        CommentModel *comment = listComments[indexPath.row];
        [cell initWithComment:comment];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnBack) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender == _btnSend) {
#warning T send message
        [[LibRestKit share] postObject:nil toPath:URL_ACTION params:[self createActionRequest:ACTION_COMMENT content:_txtvCmt.text] forClass:CLASS_COMMENT success:^(id objects) {
            [listComments addObject:(CommentModel *)objects];
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:listComments.count-1 inSection:2]] withRowAnimation:UITableViewRowAnimationNone];
//            listComments = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listComments.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//            PostModel *p = (PostModel *)objects;
//            [[LibRestKit share] getObjectsAtPath:[NSString stringWithFormat:URL_GET_COMMENT, p.postId] forClass:CLASS_COMMENT success:^(id objects) {
//                listComments = [NSMutableArray arrayWithArray:objects];
//                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
//                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listComments.count-1 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//            }];
        }];
        self.txtvCmt.text = @"";
        [self accessoryViewDidChange];
        [self.txtvCmt resignFirstResponder];
    } else if (sender == _btnTypeText) {
//        self.showImageCollectionView.hidden = YES;
        
//        if (self.imageOption.isSelected) {
//            [UIView performWithoutAnimation:^{
//                [self.typeAMessageTextView becomeFirstResponder];
//            }];
//        } else {
            [self.txtvCmt becomeFirstResponder];
//        }
        
        [_btnTypeText setSelected:YES];
        [_btnTypeImage setSelected:NO];
        
        self.txtvCmt.hidden = NO;
        self.btnSend.hidden = NO;
        self.AccessoryLayoutComment.constant = 75;
        [self accessoryViewDidChange];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else if (sender == _btnTypeImage) {
//        self.showImageCollectionView.hidden = NO;
//        
//        [self.textOption setSelected:NO];
//        [self.imageOption setSelected:YES];
//        
//        self.typeAMessageTextView.hidden = YES;
//        [self.typeAMessageTextView resignFirstResponder];
//        self.sendButton.hidden = YES;
//        
//        self.keyboardControlLayoutConstraint.constant = 216;
//        self.accessoryLayoutConstraint.constant = 40;
//        [UIView animateWithDuration:0.2 animations:^{
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            
//        }];
    }
}

#pragma mark - Comment

- (NSDictionary *)createActionRequest: (NSInteger)action content:(NSString *)content
{
    UserModel *userInfo = [Lib currentUser];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(_post.postId), @"id",
                            @(userInfo.userId), @"user_id",
                            @(action), @"action",
                            content, @"content",
                            nil];
//    NSString *searchUrl = [Lib addQueryStringToUrlString: URL_ACTION withDictionary:params];
//    NSLog(@"search = %@", searchUrl);
    return params;
}

- (CommentModel *)aaa: (NSInteger)action content:(NSString*)content
{
    CommentModel *cmt = [[CommentModel alloc] init];
    cmt.postId = _post.postId;
    cmt.userId = _post.userId;
    cmt.actionType = action;
    cmt.comment = content;
    return cmt;
}

#pragma mark - TextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (_txtvCmt.text.length > 0) {
        _btnSend.enabled = YES;
    } else {
        _btnSend.enabled = NO;
    }
    
    [self accessoryViewDidChange];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
//    [self.textOption setSelected:YES];
//    [self.imageOption setSelected:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
//    [self.textOption setSelected:NO];
}

#pragma mark - Other
- (void)accessoryViewDidChange {
    float rawLineNumber = (_txtvCmt.contentSize.height - _txtvCmt.textContainerInset.top - _txtvCmt.textContainerInset.bottom) / _txtvCmt.font.lineHeight;
    int finalLineNumber = round(rawLineNumber);
    if (finalLineNumber <= 5) {
        self.AccessoryLayoutComment.constant = finalLineNumber*16.707031 + 58.292969;
    } else {
        self.AccessoryLayoutComment.constant = 5*16.707031 + 58.292969;
    }
    
    //Update interactive frame
    self.interactiveView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.AccessoryLayoutComment.constant);
    [_txtvCmt reloadInputViews];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Notification
- (void)keyboardWillShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
}

@end
