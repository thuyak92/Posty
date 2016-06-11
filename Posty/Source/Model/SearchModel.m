//
//  SearchModel.m
//  MyDear
//
//  Created by phuongthuy on 2/7/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.status forKey:@"status"];
    [aCoder encodeInteger:self.privacySetup forKey:@"privacySetup"];
    [aCoder encodeInteger:self.spot forKey:@"spot"];
    [aCoder encodeFloat:self.distance forKey:@"distance"];
    [aCoder encodeFloat:self.longitude forKey:@"longitude"];
    [aCoder encodeFloat:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.orderKey forKey:@"orderKey"];
    [aCoder encodeObject:self.orderValue forKey:@"orderValue"];
    [aCoder encodeObject:self.keyword forKey:@"keyword"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.status = [aDecoder decodeIntegerForKey:@"status"];
        self.privacySetup = [aDecoder decodeIntegerForKey:@"privacySetup"];
        self.spot = [aDecoder decodeIntegerForKey:@"spot"];
        self.distance = [aDecoder decodeFloatForKey:@"distance"];
        self.longitude = [aDecoder decodeFloatForKey:@"longitude"];
        self.latitude = [aDecoder decodeFloatForKey:@"latitude"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.orderKey = [aDecoder decodeObjectForKey:@"orderKey"];
        self.orderValue = [aDecoder decodeObjectForKey:@"orderValue"];
        self.keyword = [aDecoder decodeObjectForKey:@"keyword"];
    }
    return self;
}

@end
