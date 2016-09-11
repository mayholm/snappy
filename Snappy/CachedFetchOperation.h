//
//  CachedFetchOperation.h
//  Snappy
//
//  Created by Pär Majholm on 12/09/16.
//  Copyright © 2016 Pär Majholm. All rights reserved.
//

// puprose of this class is to support offline data and short term caching
// TODO investigate NSURLSession built in caching

#import "FetchOperation.h"

@interface CachedFetchOperation : FetchOperation

@end
