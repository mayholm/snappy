//
//  Post.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)initWithJSONObject:(NSDictionary *)jsonObject
{
    self = [super init];
    if (self == nil) return nil;
    self.name = jsonObject[@"name"];
    self.description_ = jsonObject[@"description"];
    self.tags = jsonObject[@"tags"];
    self.url = jsonObject[@"url"];
    return self;
}

@end
