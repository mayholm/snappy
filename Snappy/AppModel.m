//
//  AppModel.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "AppModel.h"

@interface AppModel ()

@end

@implementation AppModel

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    self.cachedResources = [NSMutableDictionary dictionary];
    return self;
}

// TODO save cache to file

+ (AppModel *)shared
{
    static AppModel * shared = nil;
    @synchronized (self) {
        if (shared == nil)
            shared = [[AppModel alloc] init];
    }
    return shared;
}

@end
