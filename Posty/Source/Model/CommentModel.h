//
//  CommentModel.h
//  Posty
//
//  Created by phuongthuy on 2/20/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface CommentModel : NSObject

@property (nonatomic, assign) NSInteger commentId;
@property (nonatomic, assign) NSInteger postId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) UserModel *user;
@property (nonatomic, assign) NSInteger actionType;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSDate *time;

@end
