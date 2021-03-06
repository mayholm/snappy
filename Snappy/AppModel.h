//
//  AppModel.h
//  Snappy
//
//  Created by Pär Majholm on 11/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppModel : NSObject

@property (retain, nonatomic) NSMutableDictionary<NSString *, NSData *> * cachedResources;

+ (AppModel *)shared;

@end
