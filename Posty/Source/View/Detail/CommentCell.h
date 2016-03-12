//
//  CommentCell.h
//  MyDear
//
//  Created by phuongthuy on 2/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
@class UserModel;

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imvAva;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UITextView *txtvComment;

- (void)initWithComment:(CommentModel *)comment;

@end
