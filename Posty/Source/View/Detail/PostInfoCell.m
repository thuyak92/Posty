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

@implementation PostInfoCell

- (void)awakeFromNib {
    // Initialization code
    _txtvStatus.scrollEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithPost:(PostModel *)post
{
    [_lblViewNum setText:[NSString stringWithFormat:@"%ld", post.likeNum]];
    [_lblCommentNum setText:[NSString stringWithFormat:@"%ld", post.commentNum]];
    [_lblStarNum setText:[NSString stringWithFormat:@"%ld", post.starNum]];
    [_lblTime setText:[Lib stringFromDate:post.deliverTime formatter:DATE_TIME_FORMAT]];
    [_txtvStatus setText:post.textContent];
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
