//
//  FetchOperation.m
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import "FetchOperation.h"

@implementation FetchOperation

- (instancetype)initWithURLString:(NSString *)urlString
{
    self = [super init];
    if (self == nil) return nil;
    self.urlString = urlString;
    return self;
}

- (void)main
{
    dispatch_semaphore_t doneSemaphore = dispatch_semaphore_create(0);
    NSURL * url = [NSURL URLWithString:self.urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:
      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          self.data = data;
          self.response = response;
          self.error = error;
          dispatch_semaphore_signal(doneSemaphore);
      }] resume];
    dispatch_semaphore_wait(doneSemaphore, DISPATCH_TIME_FOREVER);
}

@end
