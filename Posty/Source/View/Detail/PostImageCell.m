//
//  PostImageCell.m
//  MyDear
//
//  Created by phuongthuy on 2/10/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "PostImageCell.h"
#import "PostModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PostImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithPost:(PostModel *)post
{
    [_imvPost sd_setImageWithURL:[NSURL URLWithString:post.imageUrl]
                    placeholderImage:[UIImage imageNamed:@"selectPhoto.png"]];
}

@end
