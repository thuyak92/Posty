//
//  PostImageCell.h
//  MyDear
//
//  Created by phuongthuy on 2/10/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PostModel;

@interface PostImageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imvPost;
- (void)initWithPost:(PostModel *)post;
@end
