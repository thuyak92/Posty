//
//  MessageModel.h
//  MyDear
//
//  Created by phuongthuy on 1/9/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic, assign) NSInteger messId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) NSDate *time;

@end
