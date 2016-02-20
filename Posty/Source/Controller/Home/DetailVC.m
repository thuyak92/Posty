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

}

- (void)viewDidAppear:(BOOL)animated
{
    defaultFrame = self.view.frame;
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
        return 3;// listComments.count;
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
        [cell.imvPost sd_setImageWithURL:[NSURL URLWithString:_post.imageUrl]
        placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
        return cell;
    } else if (indexPath.section == 1) {
        PostInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostInfoCell"];
        [cell.lblViewNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
        [cell.lblCommentNum setText:[NSString stringWithFormat:@"12345%ld", _post.likeNum]];
        [cell.lblStarNum setText:[NSString stringWithFormat:@"4%ld", _post.likeNum]];
        [cell.lblTime setText:[Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT]];
        [cell.txtvStatus setText:_post.textContent];
        return cell;
    } else if (indexPath.section == 2) {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
//        [cell.imvAva sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]
//    placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
//        cell.lblName.text = user.nickname;
        cell.lblTime.text = [Lib stringFromDate:_post.deliverTime formatter:DATE_TIME_FORMAT];
        cell.txtvComment.text = _post.textContent;
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnBack) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (sender == _btnSend) {
        
    }
}

#pragma mark - Comment

- (void)sendChatMessage
{
//    if (txtfChat.text && txtfChat.text.length != 0) {
//        [[SocketLib shareSocketLib] sendChatMessage:txtfChat.text TableID:[Libs getTableID]];
//        txtfChat.text = @"";
//    }
//    [self performSelector:@selector(hideChatView) withObject:nil afterDelay:3];
}

//- (void)onChatReceived:(SocketLib *)controller message:(NSString *)mess username:(NSString *)name
//{
//    [self showChatView];
//    NSString *curText = txtvChat.text;
//    curText = [curText stringByAppendingString:@"\n"];
//    curText = [curText stringByAppendingString:[NSString stringWithFormat:@"%@: %@", name, mess]];
//    [txtvChat setText:curText];
//    
//    NSRange range = NSMakeRange(txtvChat.text.length - 1, 1);
//    [txtvChat scrollRangeToVisible:range];
//    if (keyboardSize.height == 0) {
//        [self performSelector:@selector(hideChatView) withObject:self afterDelay:3];
//    }
//    
//}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
//    [self sendChatMessage];
    return YES;
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.0, kbSize.height, 0.0);
//    self.tableView.contentInset = contentInsets;
//    self.tableView.scrollIndicatorInsets = contentInsets;
    CGRect frame = defaultFrame;
    frame.origin.y -= kbSize.height;
    [self.view setFrame:frame];
}

- (void)keyboardWillHide:(NSNotification*)aNotification {
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, 0.0, 0.0, 0.0);
//    self.tableView.contentInset = contentInsets;
//    self.tableView.scrollIndicatorInsets = contentInsets;
    [_viewComment setFrame:defaultFrame];
}

@end
