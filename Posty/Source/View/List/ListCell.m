//
//  ListCell.m
//  Posty
//
//  Created by phuongthuy on 2/18/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "ListCell.h"
#import "UserModel.h"
#import "Lib.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ListCell

- (void)awakeFromNib {
    // Initialization code
    [_imv.layer setMasksToBounds:YES];
    [_imv.layer setCornerRadius:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ListCell *)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ListCell" owner:self options:nil] objectAtIndex:0];
}

- (void)initWithUser:(UserModel *)user
{
    _title.text = user.nickname;
//    _lblTime.text = [Lib stringFromDate:firstMess.time formatter:DATE_FORMAT];
//    _subTitle.text = firstMess.message;
    [_imv sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl]
                placeholderImage:[UIImage imageNamed:@"iconAvaDefault.png"]];
}

@end
