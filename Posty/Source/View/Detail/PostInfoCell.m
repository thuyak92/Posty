//
//  PostInfoCell.m
//  MyDear
//
//  Created by phuongthuy on 2/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostInfoCell.h"
#import "PostModel.h"
#import "Lib.h"
#import "LibRestKit.h"

@implementation PostInfoCell

- (void)awakeFromNib {
    // Initialization code
    _txtvStatus.scrollEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onButtonClicked:(id)sender {
    UserModel *userInfo = [Lib currentUser];
    if (userInfo == nil) {
        [Lib showAlertTitle:nil message:@"Please login to like, comment or rate"];
        return;
    }
    NSInteger action;
    if (sender == _btnLike) {
        if (_btnLike.isSelected) {
            action = ACTION_DISLIKE;
        } else {
            action = ACTION_LIKE;
        }
    } else if (sender  == _btnStar) {
        if (_btnStar.isSelected) {
            action = ACTION_UNFAVORITE;
        } else {
            action = ACTION_FAVORITE;
        }
    }
    [[LibRestKit share] postObject:nil toPath:URL_ACTION params: [self createActionRequest:action] forClass:CLASS_POST success:^(id objects) {
        _post = (PostModel *)objects;
        [self refreshAction];
    }];
}

- (void)initWithPost:(PostModel *)post
{
    _post = post;
    [_lblTime setText:[Lib stringFromDate:post.deliverTime formatter:DATE_TIME_FORMAT]];
    [_txtvStatus setText:post.textContent];
    
    [self refreshAction];
}

- (void)refreshAction
{
    [_lblViewNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
    [_lblCommentNum setText:[NSString stringWithFormat:@"%ld", _post.commentNum]];
    [_lblStarNum setText:[NSString stringWithFormat:@"%ld", _post.starNum]];
    
    if ([[_post.flag objectForKey:KEY_LIKED] boolValue]) {
        [_btnLike setSelected:YES];
    } else {
        [_btnLike setSelected:NO];
    }
    if ([[_post.flag objectForKey:KEY_FAVORITED] boolValue]) {
        [_btnStar setSelected:YES];
    } else {
        [_btnStar setSelected:NO];
    }
}

- (NSDictionary *)createActionRequest: (NSInteger)action
{
    UserModel *userInfo = [Lib currentUser];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(_post.postId), @"id",
                            @(userInfo.userId), @"user_id",
                            @(action), @"action",
                            nil];
    return params;
}


@end
