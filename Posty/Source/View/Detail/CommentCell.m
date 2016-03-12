//
//  CommentCell.m
//  MyDear
//
//  Created by phuongthuy on 2/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UserModel.h"
#import "Lib.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithComment:(CommentModel *)comment
{
//    [_imvAva sd_setImageWithURL:[NSURL URLWithString:comment.user.avatarUrl]
//                   placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
//    _lblName.text = comment.user.nickname;
    _lblTime.text = [Lib stringFromDate:comment.time formatter:DATE_TIME_FORMAT];
    _txtvComment.text = comment.comment;
}

@end
