//
//  PostModel.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;

//@class RKObjectManager;

#define PRIVACY_PUBLIC      0
#define PRIVACY_FRIEND      1
#define PRIVACY_ONLY_ME     2

@interface PostModel : NSObject

@property (nonatomic, assign) NSInteger postId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) NSString *textContent;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSData *image;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, assign) NSInteger likeNum;
@property (nonatomic, assign) NSInteger commentNum;
@property (nonatomic, assign) NSInteger starNum;
@property (nonatomic, strong) NSDate *deliverTime;
@property (nonatomic, assign) NSInteger privacySetup;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSDictionary *flag;

@end
