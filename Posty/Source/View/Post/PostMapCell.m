//
//  PostMapCell.m
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostMapCell.h"
#import "PostModel.h"
#import "UserModel.h"
#import "Lib.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PostMapCell

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
    [_lblName setText:post.user.nickname];
}

@end
