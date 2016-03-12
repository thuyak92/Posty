//
//  PostInfoCell.h
//  MyDear
//
//  Created by phuongthuy on 2/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostModel;

@interface PostInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblViewNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentNum;
@property (weak, nonatomic) IBOutlet UILabel *lblStarNum;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UITextView *txtvStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imvView;
@property (weak, nonatomic) IBOutlet UIImageView *imvComment;
@property (weak, nonatomic) IBOutlet UIImageView *imvStar;

- (void)initWithPost:(PostModel *)post;

@end
