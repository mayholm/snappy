//
//  Post.h
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (retain, nonatomic) NSString * name;
@property (retain, nonatomic) NSString * description_; // because "description" is taken; already defined in NSObject
@property (retain, nonatomic) NSMutableArray<NSString *> * tags;
@property (retain, nonatomic) NSString * url;

- (instancetype)initWithJSONObject:(NSDictionary *)jsonObject;

@end
