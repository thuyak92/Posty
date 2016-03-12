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

@implementation PostCell

- (void)awakeFromNib {
    // Initialization code
    [_imvAvatar.layer setMasksToBounds:YES];
    [_imvAvatar.layer setCornerRadius:15];
}

- (void)initWithPost:(PostModel *)post
{
    [_imvPost sd_setImageWithURL:[NSURL URLWithString:post.imageUrl]
                placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
    [_imvAvatar sd_setImageWithURL:[NSURL URLWithString:post.user.avatarUrl]
                  placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
    [_imvFriendAva setImage:[UIImage imageNamed:[NSString stringWithFormat:@"iconPrivacy%ld.png", post.privacySetup]]];
    [_lblName setText:post.user.nickname];
    [_lblViewNum setText:[NSString stringWithFormat:@"%ld", post.likeNum]];
    [_lblCommentNum setText:[NSString stringWithFormat:@"%ld", post.commentNum]];
    [_lblStarNum setText:[NSString stringWithFormat:@"%ld", post.starNum]];
    [_lblLocation setText:[NSString stringWithFormat:@"%@", post.locationName]];
    [_lblStatus setText:post.textContent];
    [_lblTime setText:[Lib stringFromDate:post.deliverTime formatter:TIME_FORMAT]];
    if ([Lib isMyPost:post.userId]) {
        [_lblViewNum setTextColor:[Lib colorFromHexString:COLOR_TINT]];
        [_lblCommentNum setTextColor:[Lib colorFromHexString:COLOR_TINT]];
        [_lblStarNum setTextColor:[Lib colorFromHexString:COLOR_TINT]];
        [_imvView setHighlighted:YES];
        [_imvComment setHighlighted:YES];
        [_imvStar setHighlighted:YES];
    } else {
        [_lblViewNum setTextColor:[Lib colorFromHexString:COLOR_DEFAULT]];
        [_lblCommentNum setTextColor:[Lib colorFromHexString:COLOR_DEFAULT]];
        [_lblStarNum setTextColor:[Lib colorFromHexString:COLOR_DEFAULT]];
        [_imvView setHighlighted:NO];
        [_imvComment setHighlighted:NO];
        [_imvStar setHighlighted:NO];
    }
}

@end
