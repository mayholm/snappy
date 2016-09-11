//
//  FetchOperation.h
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchOperation : NSOperation

@property (retain, nonatomic) NSString * urlString;
@property (retain, nonatomic) NSData * data;
@property (retain, nonatomic) NSURLResponse * response;
@property (retain, nonatomic) NSError * error;

- (instancetype)initWithURLString:(NSString *)urlString;

@end
