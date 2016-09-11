//
//  CachedFetchOperation.m
//  Snappy
//
//  Created by Pär Majholm on 12/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "CachedFetchOperation.h"
#import "AppModel.h"

@implementation CachedFetchOperation

- (void)main
{
    NSData * cachedResource = [AppModel shared].cachedResources[self.urlString];
    if (cachedResource != nil) {
        self.data = cachedResource;
        return;
    }
    [super main];
    if (!self.error) {
        [AppModel shared].cachedResources[self.urlString] = self.data;
    }
}

@end
