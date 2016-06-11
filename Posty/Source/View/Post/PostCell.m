//
//  Post_m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostCell.h"
#import "PostModel.h"
#import "UserModel.h"
#import "Lib.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LibRestKit.h"

@implementation PostCell

- (void)awakeFromNib {
    // Initialization code
    [_imvAvatar.layer setMasksToBounds:YES];
    [_imvAvatar.layer setCornerRadius:15];
}

- (void)initWithPost:(PostModel *)post
{
    _post = post;
    [_imvPost sd_setImageWithURL:[NSURL URLWithString:post.imageUrl]
                placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
    [_imvAvatar sd_setImageWithURL:[NSURL URLWithString:post.user.avatarUrl]
                  placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
    [_imvFriendAva setImage:[UIImage imageNamed:[NSString stringWithFormat:@"iconPrivacy%ld.png", post.privacySetup]]];
    [_lblName setText:post.user.nickname];
    [_lblLocation setText:[NSString stringWithFormat:@"%@", post.locationName]];
    [_lblStatus setText:post.textContent];
    [_lblTime setText:[Lib stringFromDate:post.deliverTime formatter:TIME_FORMAT]];
    
    [self refreshAction];
}

- (void)refreshAction
{
    [_lblViewNum setText:[NSString stringWithFormat:@"%ld", _post.likeNum]];
    [_lblCommentNum setText:[NSString stringWithFormat:@"%ld", _post.commentNum]];
    [_lblStarNum setText:[NSString stringWithFormat:@"%ld", _post.starNum]];
    
    if ([Lib isMyPost:_post.userId]) {
        [_lblName setTextColor:[Lib colorFromHexString:COLOR_TINT]];
    } else {
        [_lblName setTextColor:[Lib colorFromHexString:COLOR_DEFAULT]];
    }
    if (_post.isLiked == 1) {
        [_btnLike setSelected:YES];
    } else {
        [_btnLike setSelected:NO];
    }
    if (_post.isFavorited == 1) {
        [_btnStar setSelected:YES];
    } else {
        [_btnStar setSelected:NO];
    }
}

- (IBAction)onButtonClicked:(id)sender {
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
    [[LibRestKit share] postObject:nil toPath:[self createActionRequest:action] forClass:CLASS_POST success:^(id objects) {
        _post = (PostModel *)objects;
        [self refreshAction];
    }];
}

- (NSString *)createActionRequest: (NSInteger)action
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(_post.postId), @"id",
                            @(_post.userId), @"user_id",
                            @(action), @"action",
                            nil];
    NSString *searchUrl = [Lib addQueryStringToUrlString: URL_ACTION withDictionary:params];
    NSLog(@"search = %@", searchUrl);
    return searchUrl;
}


@end
